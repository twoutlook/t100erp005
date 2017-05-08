#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt740.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-12-09 16:47:53), PR版次:0001(2017-01-04 11:00:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgt740
#+ Description: 人工預算審核作業
#+ Creator....: 05016(2016-12-09 16:47:53)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgt740.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
PRIVATE type type_g_bggo_m        RECORD
       bggo002 LIKE bggo_t.bggo002, 
   bggo002_desc LIKE type_t.chr80, 
   bggo003 LIKE bggo_t.bggo003, 
   bggo004 LIKE bggo_t.bggo004, 
   bggo004_desc LIKE type_t.chr80, 
   bggo005 LIKE bggo_t.bggo005, 
   bggo001 LIKE bggo_t.bggo001, 
   l_bgaa002 LIKE type_t.chr10, 
   l_bgaa003 LIKE type_t.chr10, 
   bggo011 LIKE bggo_t.bggo011, 
   bggo007 LIKE bggo_t.bggo007, 
   bggo007_desc LIKE type_t.chr80, 
   bggo006 LIKE bggo_t.bggo006, 
   bggostus LIKE bggo_t.bggostus
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bggo_d        RECORD
       bggoseq LIKE bggo_t.bggoseq, 
   bggoseq2 LIKE bggo_t.bggoseq2, 
   bggo039 LIKE bggo_t.bggo039, 
   bggo012 LIKE bggo_t.bggo012, 
   bggo012_desc LIKE type_t.chr500, 
   bggo013 LIKE bggo_t.bggo013, 
   bggo013_desc LIKE type_t.chr500, 
   bggo014 LIKE bggo_t.bggo014, 
   bggo014_desc LIKE type_t.chr500, 
   bggo015 LIKE bggo_t.bggo015, 
   bggo015_desc LIKE type_t.chr500, 
   bggo016 LIKE bggo_t.bggo016, 
   bggo016_desc LIKE type_t.chr500, 
   bggo017 LIKE bggo_t.bggo017, 
   bggo017_desc LIKE type_t.chr500, 
   bggo018 LIKE bggo_t.bggo018, 
   bggo018_desc LIKE type_t.chr500, 
   bggo019 LIKE bggo_t.bggo019, 
   bggo019_desc LIKE type_t.chr500, 
   bggo020 LIKE bggo_t.bggo020, 
   bggo020_desc LIKE type_t.chr500, 
   bggo021 LIKE bggo_t.bggo021, 
   bggo021_desc LIKE type_t.chr500, 
   bggo022 LIKE bggo_t.bggo022, 
   bggo022_desc LIKE type_t.chr500, 
   bggo023 LIKE bggo_t.bggo023, 
   bggo023_desc LIKE type_t.chr500, 
   bggo024 LIKE bggo_t.bggo024, 
   bggo024_desc LIKE type_t.chr500, 
   bggo100 LIKE bggo_t.bggo100, 
   bggo008 LIKE bggo_t.bggo008, 
   bggo106 LIKE bggo_t.bggo106, 
   bggo1062 LIKE type_t.num20_6, 
   bggo1063 LIKE type_t.num20_6, 
   bggo1064 LIKE type_t.num20_6, 
   bggo1065 LIKE type_t.num20_6, 
   bggo1066 LIKE type_t.num20_6, 
   bggo1067 LIKE type_t.num20_6, 
   bggo1068 LIKE type_t.num20_6, 
   bggo1069 LIKE type_t.num20_6, 
   bggo10610 LIKE type_t.num20_6, 
   bggo10611 LIKE type_t.num20_6, 
   bggo10612 LIKE type_t.num20_6, 
   bggo10613 LIKE type_t.num20_6, 
   l_sum LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE TYPE type_g_bggo2_d RECORD
       bggo007 LIKE type_t.chr500, 
   bggo0121 LIKE type_t.chr20, 
   bggo0121_desc LIKE type_t.chr500, 
   bggo0131 LIKE type_t.chr10, 
   bggo0131_desc LIKE type_t.chr500, 
   bggo0141 LIKE type_t.chr10, 
   bggo0141_desc LIKE type_t.chr500, 
   bggo0151 LIKE type_t.chr10, 
   bggo0151_desc LIKE type_t.chr500, 
   bggo0161 LIKE type_t.chr10, 
   bggo0161_desc LIKE type_t.chr500, 
   bggo0171 LIKE type_t.chr10, 
   bggo0171_desc LIKE type_t.chr500, 
   bggo0181 LIKE type_t.chr10, 
   bggo0181_desc LIKE type_t.chr500, 
   bggo0191 LIKE type_t.chr10, 
   bggo0191_desc LIKE type_t.chr500, 
   bggo0201 LIKE type_t.chr20, 
   bggo0201_desc LIKE type_t.chr500, 
   bggo0211 LIKE type_t.chr30, 
   bggo0211_desc LIKE type_t.chr500, 
   bggo0221 LIKE type_t.chr10, 
   bggo0221_desc LIKE type_t.chr500, 
   bggo0231 LIKE type_t.chr10, 
   bggo0231_desc LIKE type_t.chr500, 
   bggo0241 LIKE type_t.chr10, 
   bggo0241_desc LIKE type_t.chr500, 
   bggo1001 LIKE type_t.chr10, 
   bggo1061  LIKE type_t.num20_6, 
   bggo1062  LIKE type_t.num20_6, 
   bggo1063  LIKE type_t.num20_6, 
   bggo1064  LIKE type_t.num20_6, 
   bggo1065  LIKE type_t.num20_6, 
   bggo1066  LIKE type_t.num20_6, 
   bggo1067  LIKE type_t.num20_6, 
   bggo1068  LIKE type_t.num20_6, 
   bggo1069  LIKE type_t.num20_6, 
   bggo10610 LIKE type_t.num20_6, 
   bggo10611 LIKE type_t.num20_6, 
   bggo10612 LIKE type_t.num20_6, 
   bggo10613 LIKE type_t.num20_6,
   l_sum LIKE type_t.num20_6
       END RECORD
       
DEFINE g_bgaa            RECORD
        bgaa002   LIKE bgaa_t.bgaa002,
        bgaa003   LIKE bgaa_t.bgaa003,
        bgaa008   LIKE bgaa_t.bgaa008,
        bgaa009   LIKE bgaa_t.bgaa009    #現金變動碼參照表
     END RECORD

DEFINE g_glaald          LIKE glaa_t.glaald
DEFINE g_glac002         LIKE glac_t.glac002    #項目對應會科

DEFINE g_bgawcond       DYNAMIC ARRAY OF RECORD
                        l_field   LIKE type_t.chr100,
                        l_act     LIKE type_t.chr100
                        END RECORD
DEFINE g_group          STRING                    
DEFINE g_max_period     LIKE bgac_t.bgac004
DEFINE l_ac2            LIKE type_t.num10 
DEFINE g_bggo2_d        DYNAMIC ARRAY OF type_g_bggo2_d
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_bggo_m          type_g_bggo_m
DEFINE g_bggo_m_t        type_g_bggo_m
DEFINE g_bggo_m_o        type_g_bggo_m
DEFINE g_bggo_m_mask_o   type_g_bggo_m #轉換遮罩前資料
DEFINE g_bggo_m_mask_n   type_g_bggo_m #轉換遮罩後資料
 
   DEFINE g_bggo002_t LIKE bggo_t.bggo002
DEFINE g_bggo003_t LIKE bggo_t.bggo003
DEFINE g_bggo005_t LIKE bggo_t.bggo005
DEFINE g_bggo001_t LIKE bggo_t.bggo001
DEFINE g_bggo007_t LIKE bggo_t.bggo007
DEFINE g_bggo006_t LIKE bggo_t.bggo006
 
 
DEFINE g_bggo_d          DYNAMIC ARRAY OF type_g_bggo_d
DEFINE g_bggo_d_t        type_g_bggo_d
DEFINE g_bggo_d_o        type_g_bggo_d
DEFINE g_bggo_d_mask_o   DYNAMIC ARRAY OF type_g_bggo_d #轉換遮罩前資料
DEFINE g_bggo_d_mask_n   DYNAMIC ARRAY OF type_g_bggo_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_bggo002 LIKE bggo_t.bggo002,
      b_bggo003 LIKE bggo_t.bggo003,
      b_bggo005 LIKE bggo_t.bggo005,
      b_bggo007 LIKE bggo_t.bggo007,
      b_bggo006 LIKE bggo_t.bggo006,
      b_bggo008 LIKE bggo_t.bggo008,
      b_bggo001 LIKE bggo_t.bggo001
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
 
{<section id="abgt740.main" >}
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
   CALL cl_ap_init("abg","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT bggo002,'',bggo003,bggo004,'',bggo005,bggo001,'','',bggo011,bggo007,'', 
       bggo006,bggostus", 
                      " FROM bggo_t",
                      " WHERE bggoent= ? AND bggo001=? AND bggo002=? AND bggo003=? AND bggo005=? AND  
                          bggo006=? AND bggo007=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt740_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bggo002,t0.bggo003,t0.bggo004,t0.bggo005,t0.bggo001,t0.bggo011,t0.bggo007, 
       t0.bggo006,t0.bggostus",
               " FROM bggo_t t0",
               
               " WHERE t0.bggoent = " ||g_enterprise|| " AND t0.bggo001 = ? AND t0.bggo002 = ? AND t0.bggo003 = ? AND t0.bggo005 = ? AND t0.bggo006 = ? AND t0.bggo007 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgt740_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgt740 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgt740_init()   
 
      #進入選單 Menu (="N")
      CALL abgt740_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgt740
      
   END IF 
   
   CLOSE abgt740_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgt740.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgt740_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('bggostus','13','FC,N,Y')
 
      CALL cl_set_combo_scc('bggo005','8963') 
   CALL cl_set_combo_scc('bggo006','9989') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('bggostus','13','N,Y,FC')     
   CALL cl_set_combo_scc('bggo022','6013')       #經營方式
   CALL cl_set_combo_scc('bggo0221','6013')      #經營方式
   CALL cl_set_combo_scc('bggo022_desc','6013')  #經營方式
   CALL cl_set_combo_scc('bggo0221_desc','6013') #經營方式
   CALL cl_set_combo_scc('bggo006','9989')       #資料來源
   
   #end add-point
   
   CALL abgt740_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abgt740.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abgt740_ui_dialog()
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
         INITIALIZE g_bggo_m.* TO NULL
         CALL g_bggo_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abgt740_init()
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
               CALL abgt740_idx_chk()
               CALL abgt740_fetch('') # reload data
               LET g_detail_idx = 1
               CALL abgt740_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_bggo_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL abgt740_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgt740_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               CALL abgt740_b_fill2(l_ac)
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
                              #此段落i02,i07樣板使用, 但目前不支援批次修改狀態, 先註解
			   ##此段落由子樣板a22產生
               ##目前選取的stus為FC
               #IF . = "FC" THEN
               #                     CALL cl_set_act_visible('final_confirmed',FALSE)
                  CALL cl_set_act_visible('unconfirmed',TRUE)
                  CALL cl_set_act_visible('confirmed',TRUE)
 
               #END IF
               ##stus - Start - 
               ##目前選取的stus為}
               #IF . = "}" THEN
               #   }
               #END IF        
               ##stus -  End  -               
    
 
 
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_bggo2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgt740_idx_chk()
               CALL abgt740_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body3.before_row"

               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page =2                        
         
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps 
         
         BEFORE DIALOG
            #先填充browser資料
            CALL abgt740_browser_fill("")
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
               CALL abgt740_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abgt740_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            ON ACTION statechange
               LET g_action_choice = "statechange"
               CALL abgt740_statechange()
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
               CALL abgt740_set_act_visible()   
               CALL abgt740_set_act_no_visible()
               IF NOT (g_bggo_m.bggo001 IS NULL
                    OR g_bggo_m.bggo002 IS NULL
                    OR g_bggo_m.bggo003 IS NULL
                    OR g_bggo_m.bggo004 IS NULL
                    OR g_bggo_m.bggo005 IS NULL
                    OR g_bggo_m.bggo006 IS NULL
                    OR g_bggo_m.bggo007 IS NULL
               
                 ) THEN
                  #組合條件
                  LET g_add_browse = " bggoent = " ||g_enterprise|| " AND",
                                     " bggo001 = '", g_bggo_m.bggo001, "' "
                                    ," AND bggo002 = '", g_bggo_m.bggo002, "' "
                                    ," AND bggo003 = '", g_bggo_m.bggo003, "' "
                                    ," AND bggo004 = '", g_bggo_m.bggo004, "' "
                                    ," AND bggo005 = '", g_bggo_m.bggo005, "' "
                                    ," AND bggo006 = '", g_bggo_m.bggo006, "' "
                                    ," AND bggo007 = '", g_bggo_m.bggo007, "' "
               
                  #填到對應位置
                  CALL abgt740_browser_fill("")
            END IF
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL abgt740_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abgt740_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt740_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abgt740_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt740_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abgt740_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt740_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abgt740_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt740_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abgt740_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt740_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_bggo_d)
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
               NEXT FIELD bggo008
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
               CALL abgt740_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL abgt740_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL abgt740_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgt740_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgt740_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgt740_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgt740_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgt740_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgt740_set_pk_array()
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
 
{<section id="abgt740.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION abgt740_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt740.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abgt740_browser_fill(ps_page_action)
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
   IF cl_null(g_wc) THEN LET g_wc = ' 1=1' END IF
   LET g_wc = g_wc," AND bggo006 = '2' AND bggo001 = '30' AND bggo005 = '1'  "
   #end add-point    
 
   LET l_searchcol = "bggo001,bggo002,bggo003,bggo005,bggo006,bggo007"
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
      LET l_sub_sql = " SELECT DISTINCT bggo001 ",
                      ", bggo002 ",
                      ", bggo003 ",
                      ", bggo005 ",
                      ", bggo006 ",
                      ", bggo007 ",
 
                      " FROM bggo_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE bggoent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bggo_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bggo001 ",
                      ", bggo002 ",
                      ", bggo003 ",
                      ", bggo005 ",
                      ", bggo006 ",
                      ", bggo007 ",
 
                      " FROM bggo_t ",
                      " ",
                      " ", 
 
 
                      " WHERE bggoent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bggo_t")
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
      INITIALIZE g_bggo_m.* TO NULL
      CALL g_bggo_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bggo002,t0.bggo003,t0.bggo005,t0.bggo007,t0.bggo006,t0.bggo008,t0.bggo001 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.bggo002,t0.bggo003,t0.bggo005,t0.bggo007,t0.bggo006,t0.bggo008,t0.bggo001", 
 
                " FROM bggo_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.bggoent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("bggo_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
  LET g_sql  = "SELECT DISTINCT t0.bggo002,t0.bggo003,t0.bggo005,t0.bggo007,t0.bggo006,'',t0.bggo001", 

                " FROM bggo_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.bggoent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("bggo_t")
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"bggo_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_bggo002,g_browser[g_cnt].b_bggo003,g_browser[g_cnt].b_bggo005, 
          g_browser[g_cnt].b_bggo007,g_browser[g_cnt].b_bggo006,g_browser[g_cnt].b_bggo008,g_browser[g_cnt].b_bggo001  
 
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
         CALL abgt740_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_bggo001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_bggo_m.* TO NULL
      CALL g_bggo_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL abgt740_fetch('')
   
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
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange", FALSE)
   END IF
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abgt740_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bggo_m.bggo001 = g_browser[g_current_idx].b_bggo001   
   LET g_bggo_m.bggo002 = g_browser[g_current_idx].b_bggo002   
   LET g_bggo_m.bggo003 = g_browser[g_current_idx].b_bggo003   
   LET g_bggo_m.bggo005 = g_browser[g_current_idx].b_bggo005   
   LET g_bggo_m.bggo006 = g_browser[g_current_idx].b_bggo006   
   LET g_bggo_m.bggo007 = g_browser[g_current_idx].b_bggo007   
 
   EXECUTE abgt740_master_referesh USING g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005, 
       g_bggo_m.bggo006,g_bggo_m.bggo007 INTO g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005, 
       g_bggo_m.bggo001,g_bggo_m.bggo011,g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus
   CALL abgt740_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abgt740_ui_detailshow()
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
 
{<section id="abgt740.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgt740_ui_browser_refresh()
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
      IF g_browser[l_i].b_bggo001 = g_bggo_m.bggo001 
         AND g_browser[l_i].b_bggo002 = g_bggo_m.bggo002 
         AND g_browser[l_i].b_bggo003 = g_bggo_m.bggo003 
         AND g_browser[l_i].b_bggo005 = g_bggo_m.bggo005 
         AND g_browser[l_i].b_bggo006 = g_bggo_m.bggo006 
         AND g_browser[l_i].b_bggo007 = g_bggo_m.bggo007 
 
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
 
{<section id="abgt740.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgt740_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_ooef001_str   STRING
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_bggo_m.* TO NULL
   CALL g_bggo_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bggo002,bggo003,bggo004,bggo005,bggo001,bggo007,bggo006,bggostus
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo002
            #add-point:BEFORE FIELD bggo002 name="construct.b.bggo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo002
            
            #add-point:AFTER FIELD bggo002 name="construct.a.bggo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo002
            #add-point:ON ACTION controlp INFIELD bggo002 name="construct.c.bggo002"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaastus='Y'"
            LET g_qryparam.where =  g_qryparam.where," bgaa001 IN (SELECT DISTINCT bggo002 FROM bggo_t      ", 
                                                     "              WHERE bggoent = ",g_enterprise,"       ",
                                                     "                AND bggo006 = '2' AND bggo001 = '30')"    
            CALL q_bgaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggo002  #顯示到畫面上
            NEXT FIELD bggo002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo003
            #add-point:BEFORE FIELD bggo003 name="construct.b.bggo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo003
            
            #add-point:AFTER FIELD bggo003 name="construct.a.bggo003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggo003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo003
            #add-point:ON ACTION controlp INFIELD bggo003 name="construct.c.bggo003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo004
            #add-point:BEFORE FIELD bggo004 name="construct.b.bggo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo004
            
            #add-point:AFTER FIELD bggo004 name="construct.a.bggo004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggo004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo004
            #add-point:ON ACTION controlp INFIELD bggo004 name="construct.c.bggo004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgaistus='Y' "
            CALL q_bgai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggo004  #顯示到畫面上
            NEXT FIELD bggo004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo005
            #add-point:BEFORE FIELD bggo005 name="construct.b.bggo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo005
            
            #add-point:AFTER FIELD bggo005 name="construct.a.bggo005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo005
            #add-point:ON ACTION controlp INFIELD bggo005 name="construct.c.bggo005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo001
            #add-point:BEFORE FIELD bggo001 name="construct.b.bggo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo001
            
            #add-point:AFTER FIELD bggo001 name="construct.a.bggo001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggo001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo001
            #add-point:ON ACTION controlp INFIELD bggo001 name="construct.c.bggo001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo007
            #add-point:BEFORE FIELD bggo007 name="construct.b.bggo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo007
            
            #add-point:AFTER FIELD bggo007 name="construct.a.bggo007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggo007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo007
            #add-point:ON ACTION controlp INFIELD bggo007 name="construct.c.bggo007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef205 = 'Y'"
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site('','',g_user,'06') RETURNING l_ooef001_str
            CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_ooef001_str
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bggo007  #顯示到畫面上
            NEXT FIELD bggo007                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo006
            #add-point:BEFORE FIELD bggo006 name="construct.b.bggo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo006
            
            #add-point:AFTER FIELD bggo006 name="construct.a.bggo006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo006
            #add-point:ON ACTION controlp INFIELD bggo006 name="construct.c.bggo006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggostus
            #add-point:BEFORE FIELD bggostus name="construct.b.bggostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggostus
            
            #add-point:AFTER FIELD bggostus name="construct.a.bggostus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bggostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggostus
            #add-point:ON ACTION controlp INFIELD bggostus name="construct.c.bggostus"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON bggoseq,bggoseq2,bggo039,bggo012,bggo012_desc,bggo013,bggo013_desc,bggo014, 
          bggo014_desc,bggo015,bggo015_desc,bggo016,bggo016_desc,bggo017,bggo017_desc,bggo018,bggo018_desc, 
          bggo019,bggo019_desc,bggo020,bggo020_desc,bggo021,bggo021_desc,bggo022,bggo022_desc,bggo023, 
          bggo023_desc,bggo024,bggo024_desc,bggo100,bggo008,bggo106,bggo1062,bggo1063,bggo1064,bggo1065, 
          bggo1066,bggo1067,bggo1068,bggo1069,bggo10610,bggo10611,bggo10612,bggo10613,l_sum
           FROM s_detail1[1].bggoseq,s_detail1[1].bggoseq2,s_detail1[1].bggo039,s_detail1[1].bggo012, 
               s_detail1[1].bggo012_desc,s_detail1[1].bggo013,s_detail1[1].bggo013_desc,s_detail1[1].bggo014, 
               s_detail1[1].bggo014_desc,s_detail1[1].bggo015,s_detail1[1].bggo015_desc,s_detail1[1].bggo016, 
               s_detail1[1].bggo016_desc,s_detail1[1].bggo017,s_detail1[1].bggo017_desc,s_detail1[1].bggo018, 
               s_detail1[1].bggo018_desc,s_detail1[1].bggo019,s_detail1[1].bggo019_desc,s_detail1[1].bggo020, 
               s_detail1[1].bggo020_desc,s_detail1[1].bggo021,s_detail1[1].bggo021_desc,s_detail1[1].bggo022, 
               s_detail1[1].bggo022_desc,s_detail1[1].bggo023,s_detail1[1].bggo023_desc,s_detail1[1].bggo024, 
               s_detail1[1].bggo024_desc,s_detail1[1].bggo100,s_detail1[1].bggo008,s_detail1[1].bggo106, 
               s_detail1[1].bggo1062,s_detail1[1].bggo1063,s_detail1[1].bggo1064,s_detail1[1].bggo1065, 
               s_detail1[1].bggo1066,s_detail1[1].bggo1067,s_detail1[1].bggo1068,s_detail1[1].bggo1069, 
               s_detail1[1].bggo10610,s_detail1[1].bggo10611,s_detail1[1].bggo10612,s_detail1[1].bggo10613, 
               s_detail1[1].l_sum
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggoseq
            #add-point:BEFORE FIELD bggoseq name="construct.b.page1.bggoseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggoseq
            
            #add-point:AFTER FIELD bggoseq name="construct.a.page1.bggoseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggoseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggoseq
            #add-point:ON ACTION controlp INFIELD bggoseq name="construct.c.page1.bggoseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggoseq2
            #add-point:BEFORE FIELD bggoseq2 name="construct.b.page1.bggoseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggoseq2
            
            #add-point:AFTER FIELD bggoseq2 name="construct.a.page1.bggoseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggoseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggoseq2
            #add-point:ON ACTION controlp INFIELD bggoseq2 name="construct.c.page1.bggoseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo039
            #add-point:BEFORE FIELD bggo039 name="construct.b.page1.bggo039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo039
            
            #add-point:AFTER FIELD bggo039 name="construct.a.page1.bggo039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo039
            #add-point:ON ACTION controlp INFIELD bggo039 name="construct.c.page1.bggo039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo012
            #add-point:BEFORE FIELD bggo012 name="construct.b.page1.bggo012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo012
            
            #add-point:AFTER FIELD bggo012 name="construct.a.page1.bggo012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo012
            #add-point:ON ACTION controlp INFIELD bggo012 name="construct.c.page1.bggo012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo012_desc
            #add-point:BEFORE FIELD bggo012_desc name="construct.b.page1.bggo012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo012_desc
            
            #add-point:AFTER FIELD bggo012_desc name="construct.a.page1.bggo012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo012_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo012_desc
            #add-point:ON ACTION controlp INFIELD bggo012_desc name="construct.c.page1.bggo012_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo013
            #add-point:BEFORE FIELD bggo013 name="construct.b.page1.bggo013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo013
            
            #add-point:AFTER FIELD bggo013 name="construct.a.page1.bggo013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo013
            #add-point:ON ACTION controlp INFIELD bggo013 name="construct.c.page1.bggo013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo013_desc
            #add-point:BEFORE FIELD bggo013_desc name="construct.b.page1.bggo013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo013_desc
            
            #add-point:AFTER FIELD bggo013_desc name="construct.a.page1.bggo013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo013_desc
            #add-point:ON ACTION controlp INFIELD bggo013_desc name="construct.c.page1.bggo013_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo014
            #add-point:BEFORE FIELD bggo014 name="construct.b.page1.bggo014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo014
            
            #add-point:AFTER FIELD bggo014 name="construct.a.page1.bggo014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo014
            #add-point:ON ACTION controlp INFIELD bggo014 name="construct.c.page1.bggo014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo014_desc
            #add-point:BEFORE FIELD bggo014_desc name="construct.b.page1.bggo014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo014_desc
            
            #add-point:AFTER FIELD bggo014_desc name="construct.a.page1.bggo014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo014_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo014_desc
            #add-point:ON ACTION controlp INFIELD bggo014_desc name="construct.c.page1.bggo014_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo015
            #add-point:BEFORE FIELD bggo015 name="construct.b.page1.bggo015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo015
            
            #add-point:AFTER FIELD bggo015 name="construct.a.page1.bggo015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo015
            #add-point:ON ACTION controlp INFIELD bggo015 name="construct.c.page1.bggo015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo015_desc
            #add-point:BEFORE FIELD bggo015_desc name="construct.b.page1.bggo015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo015_desc
            
            #add-point:AFTER FIELD bggo015_desc name="construct.a.page1.bggo015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo015_desc
            #add-point:ON ACTION controlp INFIELD bggo015_desc name="construct.c.page1.bggo015_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo016
            #add-point:BEFORE FIELD bggo016 name="construct.b.page1.bggo016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo016
            
            #add-point:AFTER FIELD bggo016 name="construct.a.page1.bggo016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo016
            #add-point:ON ACTION controlp INFIELD bggo016 name="construct.c.page1.bggo016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo016_desc
            #add-point:BEFORE FIELD bggo016_desc name="construct.b.page1.bggo016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo016_desc
            
            #add-point:AFTER FIELD bggo016_desc name="construct.a.page1.bggo016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo016_desc
            #add-point:ON ACTION controlp INFIELD bggo016_desc name="construct.c.page1.bggo016_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo017
            #add-point:BEFORE FIELD bggo017 name="construct.b.page1.bggo017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo017
            
            #add-point:AFTER FIELD bggo017 name="construct.a.page1.bggo017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo017
            #add-point:ON ACTION controlp INFIELD bggo017 name="construct.c.page1.bggo017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo017_desc
            #add-point:BEFORE FIELD bggo017_desc name="construct.b.page1.bggo017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo017_desc
            
            #add-point:AFTER FIELD bggo017_desc name="construct.a.page1.bggo017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo017_desc
            #add-point:ON ACTION controlp INFIELD bggo017_desc name="construct.c.page1.bggo017_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo018
            #add-point:BEFORE FIELD bggo018 name="construct.b.page1.bggo018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo018
            
            #add-point:AFTER FIELD bggo018 name="construct.a.page1.bggo018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo018
            #add-point:ON ACTION controlp INFIELD bggo018 name="construct.c.page1.bggo018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo018_desc
            #add-point:BEFORE FIELD bggo018_desc name="construct.b.page1.bggo018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo018_desc
            
            #add-point:AFTER FIELD bggo018_desc name="construct.a.page1.bggo018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo018_desc
            #add-point:ON ACTION controlp INFIELD bggo018_desc name="construct.c.page1.bggo018_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo019
            #add-point:BEFORE FIELD bggo019 name="construct.b.page1.bggo019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo019
            
            #add-point:AFTER FIELD bggo019 name="construct.a.page1.bggo019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo019
            #add-point:ON ACTION controlp INFIELD bggo019 name="construct.c.page1.bggo019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo019_desc
            #add-point:BEFORE FIELD bggo019_desc name="construct.b.page1.bggo019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo019_desc
            
            #add-point:AFTER FIELD bggo019_desc name="construct.a.page1.bggo019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo019_desc
            #add-point:ON ACTION controlp INFIELD bggo019_desc name="construct.c.page1.bggo019_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo020
            #add-point:BEFORE FIELD bggo020 name="construct.b.page1.bggo020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo020
            
            #add-point:AFTER FIELD bggo020 name="construct.a.page1.bggo020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo020
            #add-point:ON ACTION controlp INFIELD bggo020 name="construct.c.page1.bggo020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo020_desc
            #add-point:BEFORE FIELD bggo020_desc name="construct.b.page1.bggo020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo020_desc
            
            #add-point:AFTER FIELD bggo020_desc name="construct.a.page1.bggo020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo020_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo020_desc
            #add-point:ON ACTION controlp INFIELD bggo020_desc name="construct.c.page1.bggo020_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo021
            #add-point:BEFORE FIELD bggo021 name="construct.b.page1.bggo021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo021
            
            #add-point:AFTER FIELD bggo021 name="construct.a.page1.bggo021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo021
            #add-point:ON ACTION controlp INFIELD bggo021 name="construct.c.page1.bggo021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo021_desc
            #add-point:BEFORE FIELD bggo021_desc name="construct.b.page1.bggo021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo021_desc
            
            #add-point:AFTER FIELD bggo021_desc name="construct.a.page1.bggo021_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo021_desc
            #add-point:ON ACTION controlp INFIELD bggo021_desc name="construct.c.page1.bggo021_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo022
            #add-point:BEFORE FIELD bggo022 name="construct.b.page1.bggo022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo022
            
            #add-point:AFTER FIELD bggo022 name="construct.a.page1.bggo022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo022
            #add-point:ON ACTION controlp INFIELD bggo022 name="construct.c.page1.bggo022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo022_desc
            #add-point:BEFORE FIELD bggo022_desc name="construct.b.page1.bggo022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo022_desc
            
            #add-point:AFTER FIELD bggo022_desc name="construct.a.page1.bggo022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo022_desc
            #add-point:ON ACTION controlp INFIELD bggo022_desc name="construct.c.page1.bggo022_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo023
            #add-point:BEFORE FIELD bggo023 name="construct.b.page1.bggo023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo023
            
            #add-point:AFTER FIELD bggo023 name="construct.a.page1.bggo023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo023
            #add-point:ON ACTION controlp INFIELD bggo023 name="construct.c.page1.bggo023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo023_desc
            #add-point:BEFORE FIELD bggo023_desc name="construct.b.page1.bggo023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo023_desc
            
            #add-point:AFTER FIELD bggo023_desc name="construct.a.page1.bggo023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo023_desc
            #add-point:ON ACTION controlp INFIELD bggo023_desc name="construct.c.page1.bggo023_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo024
            #add-point:BEFORE FIELD bggo024 name="construct.b.page1.bggo024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo024
            
            #add-point:AFTER FIELD bggo024 name="construct.a.page1.bggo024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo024
            #add-point:ON ACTION controlp INFIELD bggo024 name="construct.c.page1.bggo024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo024_desc
            #add-point:BEFORE FIELD bggo024_desc name="construct.b.page1.bggo024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo024_desc
            
            #add-point:AFTER FIELD bggo024_desc name="construct.a.page1.bggo024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo024_desc
            #add-point:ON ACTION controlp INFIELD bggo024_desc name="construct.c.page1.bggo024_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo100
            #add-point:BEFORE FIELD bggo100 name="construct.b.page1.bggo100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo100
            
            #add-point:AFTER FIELD bggo100 name="construct.a.page1.bggo100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo100
            #add-point:ON ACTION controlp INFIELD bggo100 name="construct.c.page1.bggo100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo008
            #add-point:BEFORE FIELD bggo008 name="construct.b.page1.bggo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo008
            
            #add-point:AFTER FIELD bggo008 name="construct.a.page1.bggo008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo008
            #add-point:ON ACTION controlp INFIELD bggo008 name="construct.c.page1.bggo008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo106
            #add-point:BEFORE FIELD bggo106 name="construct.b.page1.bggo106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo106
            
            #add-point:AFTER FIELD bggo106 name="construct.a.page1.bggo106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo106
            #add-point:ON ACTION controlp INFIELD bggo106 name="construct.c.page1.bggo106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1062
            #add-point:BEFORE FIELD bggo1062 name="construct.b.page1.bggo1062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1062
            
            #add-point:AFTER FIELD bggo1062 name="construct.a.page1.bggo1062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo1062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1062
            #add-point:ON ACTION controlp INFIELD bggo1062 name="construct.c.page1.bggo1062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1063
            #add-point:BEFORE FIELD bggo1063 name="construct.b.page1.bggo1063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1063
            
            #add-point:AFTER FIELD bggo1063 name="construct.a.page1.bggo1063"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo1063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1063
            #add-point:ON ACTION controlp INFIELD bggo1063 name="construct.c.page1.bggo1063"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1064
            #add-point:BEFORE FIELD bggo1064 name="construct.b.page1.bggo1064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1064
            
            #add-point:AFTER FIELD bggo1064 name="construct.a.page1.bggo1064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo1064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1064
            #add-point:ON ACTION controlp INFIELD bggo1064 name="construct.c.page1.bggo1064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1065
            #add-point:BEFORE FIELD bggo1065 name="construct.b.page1.bggo1065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1065
            
            #add-point:AFTER FIELD bggo1065 name="construct.a.page1.bggo1065"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo1065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1065
            #add-point:ON ACTION controlp INFIELD bggo1065 name="construct.c.page1.bggo1065"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1066
            #add-point:BEFORE FIELD bggo1066 name="construct.b.page1.bggo1066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1066
            
            #add-point:AFTER FIELD bggo1066 name="construct.a.page1.bggo1066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo1066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1066
            #add-point:ON ACTION controlp INFIELD bggo1066 name="construct.c.page1.bggo1066"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1067
            #add-point:BEFORE FIELD bggo1067 name="construct.b.page1.bggo1067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1067
            
            #add-point:AFTER FIELD bggo1067 name="construct.a.page1.bggo1067"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo1067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1067
            #add-point:ON ACTION controlp INFIELD bggo1067 name="construct.c.page1.bggo1067"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1068
            #add-point:BEFORE FIELD bggo1068 name="construct.b.page1.bggo1068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1068
            
            #add-point:AFTER FIELD bggo1068 name="construct.a.page1.bggo1068"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo1068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1068
            #add-point:ON ACTION controlp INFIELD bggo1068 name="construct.c.page1.bggo1068"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1069
            #add-point:BEFORE FIELD bggo1069 name="construct.b.page1.bggo1069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1069
            
            #add-point:AFTER FIELD bggo1069 name="construct.a.page1.bggo1069"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo1069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1069
            #add-point:ON ACTION controlp INFIELD bggo1069 name="construct.c.page1.bggo1069"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo10610
            #add-point:BEFORE FIELD bggo10610 name="construct.b.page1.bggo10610"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo10610
            
            #add-point:AFTER FIELD bggo10610 name="construct.a.page1.bggo10610"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo10610
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo10610
            #add-point:ON ACTION controlp INFIELD bggo10610 name="construct.c.page1.bggo10610"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo10611
            #add-point:BEFORE FIELD bggo10611 name="construct.b.page1.bggo10611"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo10611
            
            #add-point:AFTER FIELD bggo10611 name="construct.a.page1.bggo10611"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo10611
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo10611
            #add-point:ON ACTION controlp INFIELD bggo10611 name="construct.c.page1.bggo10611"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo10612
            #add-point:BEFORE FIELD bggo10612 name="construct.b.page1.bggo10612"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo10612
            
            #add-point:AFTER FIELD bggo10612 name="construct.a.page1.bggo10612"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo10612
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo10612
            #add-point:ON ACTION controlp INFIELD bggo10612 name="construct.c.page1.bggo10612"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo10613
            #add-point:BEFORE FIELD bggo10613 name="construct.b.page1.bggo10613"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo10613
            
            #add-point:AFTER FIELD bggo10613 name="construct.a.page1.bggo10613"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bggo10613
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo10613
            #add-point:ON ACTION controlp INFIELD bggo10613 name="construct.c.page1.bggo10613"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum
            #add-point:BEFORE FIELD l_sum name="construct.b.page1.l_sum"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum
            
            #add-point:AFTER FIELD l_sum name="construct.a.page1.l_sum"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_sum
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum
            #add-point:ON ACTION controlp INFIELD l_sum name="construct.c.page1.l_sum"
            
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
   LET g_wc2_table1 = cl_replace_str(g_wc2_table1,"_desc","")
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
 
{<section id="abgt740.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abgt740_filter()
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
      CONSTRUCT g_wc_filter ON bggo002,bggo003,bggo005,bggo007,bggo006,bggo008,bggo001
                          FROM s_browse[1].b_bggo002,s_browse[1].b_bggo003,s_browse[1].b_bggo005,s_browse[1].b_bggo007, 
                              s_browse[1].b_bggo006,s_browse[1].b_bggo008,s_browse[1].b_bggo001
 
         BEFORE CONSTRUCT
               DISPLAY abgt740_filter_parser('bggo002') TO s_browse[1].b_bggo002
            DISPLAY abgt740_filter_parser('bggo003') TO s_browse[1].b_bggo003
            DISPLAY abgt740_filter_parser('bggo005') TO s_browse[1].b_bggo005
            DISPLAY abgt740_filter_parser('bggo007') TO s_browse[1].b_bggo007
            DISPLAY abgt740_filter_parser('bggo006') TO s_browse[1].b_bggo006
            DISPLAY abgt740_filter_parser('bggo008') TO s_browse[1].b_bggo008
            DISPLAY abgt740_filter_parser('bggo001') TO s_browse[1].b_bggo001
      
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
 
      CALL abgt740_filter_show('bggo002')
   CALL abgt740_filter_show('bggo003')
   CALL abgt740_filter_show('bggo005')
   CALL abgt740_filter_show('bggo007')
   CALL abgt740_filter_show('bggo006')
   CALL abgt740_filter_show('bggo008')
   CALL abgt740_filter_show('bggo001')
 
END FUNCTION
 
{</section>}
 
{<section id="abgt740.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abgt740_filter_parser(ps_field)
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
 
{<section id="abgt740.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abgt740_filter_show(ps_field)
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
   LET ls_condition = abgt740_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abgt740.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgt740_query()
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
   CALL g_bggo_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL abgt740_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abgt740_browser_fill(g_wc)
      CALL abgt740_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL abgt740_browser_fill("F")
   
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
      CALL abgt740_fetch("F") 
   END IF
   
   CALL abgt740_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgt740_fetch(p_flag)
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
   
   LET g_bggo_m.bggo001 = g_browser[g_current_idx].b_bggo001
   LET g_bggo_m.bggo002 = g_browser[g_current_idx].b_bggo002
   LET g_bggo_m.bggo003 = g_browser[g_current_idx].b_bggo003
   LET g_bggo_m.bggo005 = g_browser[g_current_idx].b_bggo005
   LET g_bggo_m.bggo006 = g_browser[g_current_idx].b_bggo006
   LET g_bggo_m.bggo007 = g_browser[g_current_idx].b_bggo007
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgt740_master_referesh USING g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005, 
       g_bggo_m.bggo006,g_bggo_m.bggo007 INTO g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005, 
       g_bggo_m.bggo001,g_bggo_m.bggo011,g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_bggo_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_bggo_m_mask_o.* =  g_bggo_m.*
   CALL abgt740_bggo_t_mask()
   LET g_bggo_m_mask_n.* =  g_bggo_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt740_set_act_visible()
   CALL abgt740_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_bggo_m_t.* = g_bggo_m.*
   LET g_bggo_m_o.* = g_bggo_m.*
   
   #重新顯示   
   CALL abgt740_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgt740.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgt740_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_bggo_d.clear()
 
 
   INITIALIZE g_bggo_m.* TO NULL             #DEFAULT 設定
   LET g_bggo001_t = NULL
   LET g_bggo002_t = NULL
   LET g_bggo003_t = NULL
   LET g_bggo005_t = NULL
   LET g_bggo006_t = NULL
   LET g_bggo007_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      LET g_bggo_m.bggo005 = '1'
      LET g_bggo_m.bggo006 = '2'
      LET g_bggo_m.bggo001 = '30'
      LET g_bggo_m.bggostus = 'N'
      CASE g_bggo_m.bggostus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "FC"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
      END CASE
      #end add-point 
 
      CALL abgt740_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_bggo_m.* TO NULL
         INITIALIZE g_bggo_d TO NULL
 
         CALL abgt740_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bggo_m.* = g_bggo_m_t.*
         CALL abgt740_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_bggo_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt740_set_act_visible()
   CALL abgt740_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bggo001_t = g_bggo_m.bggo001
   LET g_bggo002_t = g_bggo_m.bggo002
   LET g_bggo003_t = g_bggo_m.bggo003
   LET g_bggo005_t = g_bggo_m.bggo005
   LET g_bggo006_t = g_bggo_m.bggo006
   LET g_bggo007_t = g_bggo_m.bggo007
 
   
   #組合新增資料的條件
   LET g_add_browse = " bggoent = " ||g_enterprise|| " AND",
                      " bggo001 = '", g_bggo_m.bggo001, "' "
                      ," AND bggo002 = '", g_bggo_m.bggo002, "' "
                      ," AND bggo003 = '", g_bggo_m.bggo003, "' "
                      ," AND bggo005 = '", g_bggo_m.bggo005, "' "
                      ," AND bggo006 = '", g_bggo_m.bggo006, "' "
                      ," AND bggo007 = '", g_bggo_m.bggo007, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt740_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL abgt740_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abgt740_master_referesh USING g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005, 
       g_bggo_m.bggo006,g_bggo_m.bggo007 INTO g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005, 
       g_bggo_m.bggo001,g_bggo_m.bggo011,g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus
   
   #遮罩相關處理
   LET g_bggo_m_mask_o.* =  g_bggo_m.*
   CALL abgt740_bggo_t_mask()
   LET g_bggo_m_mask_n.* =  g_bggo_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bggo_m.bggo002,g_bggo_m.bggo002_desc,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo004_desc, 
       g_bggo_m.bggo005,g_bggo_m.bggo001,g_bggo_m.l_bgaa002,g_bggo_m.l_bgaa003,g_bggo_m.bggo011,g_bggo_m.bggo007, 
       g_bggo_m.bggo007_desc,g_bggo_m.bggo006,g_bggo_m.bggostus
   
   #功能已完成,通報訊息中心
   CALL abgt740_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgt740_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_bggo_m.bggo001 IS NULL
   OR g_bggo_m.bggo002 IS NULL
   OR g_bggo_m.bggo003 IS NULL
   OR g_bggo_m.bggo005 IS NULL
   OR g_bggo_m.bggo006 IS NULL
   OR g_bggo_m.bggo007 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bggo001_t = g_bggo_m.bggo001
   LET g_bggo002_t = g_bggo_m.bggo002
   LET g_bggo003_t = g_bggo_m.bggo003
   LET g_bggo005_t = g_bggo_m.bggo005
   LET g_bggo006_t = g_bggo_m.bggo006
   LET g_bggo007_t = g_bggo_m.bggo007
 
   CALL s_transaction_begin()
   
   OPEN abgt740_cl USING g_enterprise,g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt740_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt740_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt740_master_referesh USING g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005, 
       g_bggo_m.bggo006,g_bggo_m.bggo007 INTO g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005, 
       g_bggo_m.bggo001,g_bggo_m.bggo011,g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus
   
   #遮罩相關處理
   LET g_bggo_m_mask_o.* =  g_bggo_m.*
   CALL abgt740_bggo_t_mask()
   LET g_bggo_m_mask_n.* =  g_bggo_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abgt740_show()
   WHILE TRUE
      LET g_bggo001_t = g_bggo_m.bggo001
      LET g_bggo002_t = g_bggo_m.bggo002
      LET g_bggo003_t = g_bggo_m.bggo003
      LET g_bggo005_t = g_bggo_m.bggo005
      LET g_bggo006_t = g_bggo_m.bggo006
      LET g_bggo007_t = g_bggo_m.bggo007
 
 
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      CALL abgt740_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bggo_m.* = g_bggo_m_t.*
         CALL abgt740_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bggo_m.bggo001 != g_bggo001_t 
      OR g_bggo_m.bggo002 != g_bggo002_t 
      OR g_bggo_m.bggo003 != g_bggo003_t 
      OR g_bggo_m.bggo005 != g_bggo005_t 
      OR g_bggo_m.bggo006 != g_bggo006_t 
      OR g_bggo_m.bggo007 != g_bggo007_t 
 
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
   CALL abgt740_set_act_visible()
   CALL abgt740_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bggoent = " ||g_enterprise|| " AND",
                      " bggo001 = '", g_bggo_m.bggo001, "' "
                      ," AND bggo002 = '", g_bggo_m.bggo002, "' "
                      ," AND bggo003 = '", g_bggo_m.bggo003, "' "
                      ," AND bggo005 = '", g_bggo_m.bggo005, "' "
                      ," AND bggo006 = '", g_bggo_m.bggo006, "' "
                      ," AND bggo007 = '", g_bggo_m.bggo007, "' "
 
   #填到對應位置
   CALL abgt740_browser_fill("")
 
   CALL abgt740_idx_chk()
 
   CLOSE abgt740_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt740_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="abgt740.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgt740_input(p_cmd)
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
   DEFINE l_site_str             STRING
   DEFINE l_bggo                 type_g_bggo_d
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
   DISPLAY BY NAME g_bggo_m.bggo002,g_bggo_m.bggo002_desc,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo004_desc, 
       g_bggo_m.bggo005,g_bggo_m.bggo001,g_bggo_m.l_bgaa002,g_bggo_m.l_bgaa003,g_bggo_m.bggo011,g_bggo_m.bggo007, 
       g_bggo_m.bggo007_desc,g_bggo_m.bggo006,g_bggo_m.bggostus
   
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
   LET g_forupd_sql = "SELECT bggoseq,bggoseq2,bggo039,bggo012,bggo013,bggo014,bggo015,bggo016,bggo017, 
       bggo018,bggo019,bggo020,bggo021,bggo022,bggo023,bggo024,bggo100,bggo008,bggo106 FROM bggo_t WHERE  
       bggoent=? AND bggo001=? AND bggo002=? AND bggo003=? AND bggo005=? AND bggo006=? AND bggo007=?  
       AND bggo008=? AND bggoseq=? AND bggoseq2=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt740_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abgt740_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgt740_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005,g_bggo_m.bggo001, 
       g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abgt740.input.head" >}
   
      #單頭段
      INPUT BY NAME g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005,g_bggo_m.bggo001, 
          g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            CALL g_bggo2_d.clear()
            LET g_bggo_m.bggo002 = '' LET g_bggo_m.bggo002_desc = '' 
            LET g_bggo_m.bggo003 = ''
            LET g_bggo_m.bggo004 = '' LET g_bggo_m.bggo004_desc = '' 
            LET g_bggo_m.bggo007 = '' LET g_bggo_m.bggo007_desc = '' 
            DISPLAY BY NAME g_bggo_m.bggo002,g_bggo_m.bggo002_desc,
                            g_bggo_m.bggo003,                      
                            g_bggo_m.bggo004,g_bggo_m.bggo004_desc,                    
                            g_bggo_m.bggo007,g_bggo_m.bggo007_desc
            NEXT FIELD bggo002
           
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo002
            
            #add-point:AFTER FIELD bggo002 name="input.a.bggo002"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggo_m.bggo001) AND NOT cl_null(g_bggo_m.bggo002) AND NOT cl_null(g_bggo_m.bggo003) AND NOT cl_null(g_bggo_m.bggo005) AND NOT cl_null(g_bggo_m.bggo006) AND NOT cl_null(g_bggo_m.bggo007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggo_m.bggo001 != g_bggo001_t  OR g_bggo_m.bggo002 != g_bggo002_t  OR g_bggo_m.bggo003 != g_bggo003_t  OR g_bggo_m.bggo005 != g_bggo005_t  OR g_bggo_m.bggo006 != g_bggo006_t  OR g_bggo_m.bggo007 != g_bggo007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM bggo_t WHERE "||"bggoent = " ||g_enterprise|| " AND "||"bggo001 = '"||g_bggo_m.bggo001 ||"' AND "|| "bggo002 = '"||g_bggo_m.bggo002 ||"' AND "|| "bggo003 = '"||g_bggo_m.bggo003 ||"' AND "|| "bggo005 = '"||g_bggo_m.bggo005 ||"' AND "|| "bggo006 = '"||g_bggo_m.bggo006 ||"' AND "|| "bggo007 = '"||g_bggo_m.bggo007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
          
            IF NOT cl_null(g_bggo_m.bggo002) THEN
               IF g_bggo_m.bggo002 != g_bggo_m_o.bggo002 OR cl_null(g_bggo_m_o.bggo002) THEN                                
                  CALL abgt740_bggo002_bggo003_chk(g_bggo_m.bggo002,g_bggo_m.bggo003)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggo_m.bggo002 = g_bggo_m_o.bggo002 
                     LET g_bggo_m.bggo002_desc = s_desc_get_budget_desc(g_bggo_m.bggo002)
                     #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼
                     SELECT bgaa002,bgaa003,bgaa008,bgaa009 INTO g_bgaa.*
                       FROM bgaa_t
                      WHERE bgaaent = g_enterprise
                        AND bgaa001 = g_bggo_m.bggo002
                     LET g_bggo_m.l_bgaa002 = g_bgaa.bgaa002 #預算週期
                     LET g_bggo_m.l_bgaa003 = g_bgaa.bgaa003 #預算幣別
                     DISPLAY BY NAME g_bggo_m.bggo002_desc,g_bggo_m.bggo002,g_bggo_m.l_bgaa002,g_bggo_m.l_bgaa003 
                     NEXT FIELD CURRENT
                  END IF
                  INITIALIZE g_bgaa.* TO NULL
                  #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼
                  SELECT bgaa002,bgaa003,bgaa008,bgaa009 INTO g_bgaa.*
                    FROM bgaa_t
                   WHERE bgaaent = g_enterprise
                     AND bgaa001 = g_bggo_m.bggo002
                  LET g_bggo_m.l_bgaa002 = g_bgaa.bgaa002 #預算週期
                  LET g_bggo_m.l_bgaa003 = g_bgaa.bgaa003 #預算幣別
                  DISPLAY BY NAME g_bggo_m.l_bgaa002,g_bggo_m.l_bgaa003                                                
                  #抓取預算樣表
                  IF NOT cl_null(g_bggo_m.bggo004) THEN
                     SELECT DISTINCT bgai008 INTO g_bggo_m.bggo011 FROM bgai_t
                      WHERE bgaient=g_enterprise AND bgai001=g_bggo_m.bggo002 AND bgai002=g_bggo_m.bggo004
                      DISPLAY BY NAME g_bggo_m.bggo011
                     #设置核算项显示位置
                     CALL abgt740_set_bggo_visible()
                  END IF
               END IF              
            END IF   
            #最大週期數
            SELECT MAX(bgac004) INTO g_max_period FROM bgac_t
             WHERE bgacent = g_enterprise 
               AND bgac001= (SELECT bgaa002 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bggo_m.bggo002)             
            LET g_bggo_m.bggo002_desc = s_desc_get_budget_desc(g_bggo_m.bggo002)
            DISPLAY BY NAME g_bggo_m.bggo002_desc,g_bggo_m.bggo002
            LET g_bggo_m_o.* = g_bggo_m.* 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo002
            #add-point:BEFORE FIELD bggo002 name="input.b.bggo002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo002
            #add-point:ON CHANGE bggo002 name="input.g.bggo002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo003
            #add-point:BEFORE FIELD bggo003 name="input.b.bggo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo003
            
            #add-point:AFTER FIELD bggo003 name="input.a.bggo003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggo_m.bggo001) AND NOT cl_null(g_bggo_m.bggo002) AND NOT cl_null(g_bggo_m.bggo003) AND NOT cl_null(g_bggo_m.bggo005) AND NOT cl_null(g_bggo_m.bggo006) AND NOT cl_null(g_bggo_m.bggo007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggo_m.bggo001 != g_bggo001_t  OR g_bggo_m.bggo002 != g_bggo002_t  OR g_bggo_m.bggo003 != g_bggo003_t  OR g_bggo_m.bggo005 != g_bggo005_t  OR g_bggo_m.bggo006 != g_bggo006_t  OR g_bggo_m.bggo007 != g_bggo007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggo_t WHERE "||"bggoent = " ||g_enterprise|| " AND "||"bggo001 = '"||g_bggo_m.bggo001 ||"' AND "|| "bggo002 = '"||g_bggo_m.bggo002 ||"' AND "|| "bggo003 = '"||g_bggo_m.bggo003 ||"' AND "|| "bggo005 = '"||g_bggo_m.bggo005 ||"' AND "|| "bggo006 = '"||g_bggo_m.bggo006 ||"' AND "|| "bggo007 = '"||g_bggo_m.bggo007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bggo_m.bggo003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bggo_m.bggo003 != g_bggo_m_t.bggo003 OR g_bggo_m_t.bggo003 IS NULL )) THEN            
                  IF NOT cl_null(g_bggo_m.bggo002) AND NOT cl_null(g_bggo_m.bggo003) THEN
                     CALL abgt740_bggo002_bggo003_chk(g_bggo_m.bggo002,g_bggo_m.bggo003)
                      RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bggo_m.bggo003 = g_bggo_m_t.bggo003
                        DISPLAY BY NAME g_bggo_m.bggo003
                        NEXT FIELD CURRENT                   
                     END IF                     
                  END IF                  
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo003
            #add-point:ON CHANGE bggo003 name="input.g.bggo003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo004
            
            #add-point:AFTER FIELD bggo004 name="input.a.bggo004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bggo_m.bggo002
            LET g_ref_fields[2] = g_bggo_m.bggo004
            CALL ap_ref_array2(g_ref_fields,"SELECT bgail004 FROM bgail_t WHERE bgailent="||g_enterprise||" AND bgail001=? AND bgail002=? AND bgail003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bggo_m.bggo004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bggo_m.bggo004_desc                       
            
            IF NOT cl_null(g_bggo_m.bggo004) THEN
               IF g_bggo_m.bggo004 != g_bggo_m_t.bggo004 OR cl_null(g_bggo_m_t.bggo004) THEN 
                  CALL s_abg2_bgai002_chk(g_bggo_m.bggo002,g_bggo_m.bggo004,'06')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend =g_bggo_m.bggo004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggo_m.bggo004 = g_bggo_m_t.bggo004
                     CALL s_desc_get_bgai002_desc(g_bggo_m.bggo001,g_bggo_m.bggo004) RETURNING g_bggo_m.bggo004_desc
                     DISPLAY BY NAME g_bggo_m.bggo004_desc
                     NEXT FIELD CURRENT
                  END IF
                  #抓取預算樣表
                  IF NOT cl_null(g_bggo_m.bggo002) THEN
                     SELECT DISTINCT bgai008 INTO g_bggo_m.bggo011 FROM bgai_t
                      WHERE bgaient=g_enterprise AND bgai001=g_bggo_m.bggo002 AND bgai002=g_bggo_m.bggo004
                      DISPLAY BY NAME g_bggo_m.bggo011
                     #设置核算项显示位置
                     CALL abgt740_set_bggo_visible()
                  END IF
               END IF
            END IF
            CALL s_desc_get_bgai002_desc(g_bggo_m.bggo001,g_bggo_m.bggo004) RETURNING g_bggo_m.bggo004_desc
            DISPLAY BY NAME g_bggo_m.bggo004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo004
            #add-point:BEFORE FIELD bggo004 name="input.b.bggo004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo004
            #add-point:ON CHANGE bggo004 name="input.g.bggo004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo005
            #add-point:BEFORE FIELD bggo005 name="input.b.bggo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo005
            
            #add-point:AFTER FIELD bggo005 name="input.a.bggo005"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggo_m.bggo001) AND NOT cl_null(g_bggo_m.bggo002) AND NOT cl_null(g_bggo_m.bggo003) AND NOT cl_null(g_bggo_m.bggo005) AND NOT cl_null(g_bggo_m.bggo006) AND NOT cl_null(g_bggo_m.bggo007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggo_m.bggo001 != g_bggo001_t  OR g_bggo_m.bggo002 != g_bggo002_t  OR g_bggo_m.bggo003 != g_bggo003_t  OR g_bggo_m.bggo005 != g_bggo005_t  OR g_bggo_m.bggo006 != g_bggo006_t  OR g_bggo_m.bggo007 != g_bggo007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggo_t WHERE "||"bggoent = " ||g_enterprise|| " AND "||"bggo001 = '"||g_bggo_m.bggo001 ||"' AND "|| "bggo002 = '"||g_bggo_m.bggo002 ||"' AND "|| "bggo003 = '"||g_bggo_m.bggo003 ||"' AND "|| "bggo005 = '"||g_bggo_m.bggo005 ||"' AND "|| "bggo006 = '"||g_bggo_m.bggo006 ||"' AND "|| "bggo007 = '"||g_bggo_m.bggo007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo005
            #add-point:ON CHANGE bggo005 name="input.g.bggo005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo001
            #add-point:BEFORE FIELD bggo001 name="input.b.bggo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo001
            
            #add-point:AFTER FIELD bggo001 name="input.a.bggo001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggo_m.bggo001) AND NOT cl_null(g_bggo_m.bggo002) AND NOT cl_null(g_bggo_m.bggo003) AND NOT cl_null(g_bggo_m.bggo005) AND NOT cl_null(g_bggo_m.bggo006) AND NOT cl_null(g_bggo_m.bggo007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggo_m.bggo001 != g_bggo001_t  OR g_bggo_m.bggo002 != g_bggo002_t  OR g_bggo_m.bggo003 != g_bggo003_t  OR g_bggo_m.bggo005 != g_bggo005_t  OR g_bggo_m.bggo006 != g_bggo006_t  OR g_bggo_m.bggo007 != g_bggo007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggo_t WHERE "||"bggoent = " ||g_enterprise|| " AND "||"bggo001 = '"||g_bggo_m.bggo001 ||"' AND "|| "bggo002 = '"||g_bggo_m.bggo002 ||"' AND "|| "bggo003 = '"||g_bggo_m.bggo003 ||"' AND "|| "bggo005 = '"||g_bggo_m.bggo005 ||"' AND "|| "bggo006 = '"||g_bggo_m.bggo006 ||"' AND "|| "bggo007 = '"||g_bggo_m.bggo007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo001
            #add-point:ON CHANGE bggo001 name="input.g.bggo001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo007
            
            #add-point:AFTER FIELD bggo007 name="input.a.bggo007"

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggo_m.bggo001) AND NOT cl_null(g_bggo_m.bggo002) AND NOT cl_null(g_bggo_m.bggo003) AND NOT cl_null(g_bggo_m.bggo005) AND NOT cl_null(g_bggo_m.bggo006) AND NOT cl_null(g_bggo_m.bggo007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggo_m.bggo001 != g_bggo001_t  OR g_bggo_m.bggo002 != g_bggo002_t  OR g_bggo_m.bggo003 != g_bggo003_t  OR g_bggo_m.bggo005 != g_bggo005_t  OR g_bggo_m.bggo006 != g_bggo006_t  OR g_bggo_m.bggo007 != g_bggo007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggo_t WHERE "||"bggoent = " ||g_enterprise|| " AND "||"bggo001 = '"||g_bggo_m.bggo001 ||"' AND "|| "bggo002 = '"||g_bggo_m.bggo002 ||"' AND "|| "bggo003 = '"||g_bggo_m.bggo003 ||"' AND "|| "bggo005 = '"||g_bggo_m.bggo005 ||"' AND "|| "bggo006 = '"||g_bggo_m.bggo006 ||"' AND "|| "bggo007 = '"||g_bggo_m.bggo007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_bggo_m.bggo007_desc = ' '
            DISPLAY BY NAME g_bggo_m.bggo007_desc
            IF NOT cl_null(g_bggo_m.bggo007) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bggo_m.bggo007 != g_bggo_m_t.bggo007 OR g_bggo_m_t.bggo007 IS NULL )) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_bggo_m.bggo007
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi100|",cl_get_progname("aooi100",g_lang,"2"),"|:EXEPROGaooi100"
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #檢查失敗時後續處理
                     LET g_bggo_m.bggo007 = g_bggo_m_t.bggo007
                     LET g_bggo_m.bggo007_desc = s_desc_get_department_desc(g_bggo_m.bggo007)
                     DISPLAY BY NAME g_bggo_m.bggo007_desc
                     NEXT FIELD CURRENT
                  END IF       
      
                  #1.檢查是否在預算編號對應的最上層組織+版本的預算tree中，且為azzi800中有權限的據點
                  #2.檢查預算組織是否在abgi090中可操作的組織中
                  CALL s_abg2_bgai004_chk(g_bggo_m.bggo002,g_bggo_m.bggo004,g_bggo_m.bggo007,'06')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     IF g_errno = 'sub-01302' THEN
                        LET g_errparam.replace[1] = 'agli020'
                        LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                        LET g_errparam.exeprog = 'agli020'
                     END IF
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bggo_m.bggo007 = g_bggo_m_t.bggo007
                     LET g_bggo_m.bggo007_desc = s_desc_get_department_desc(g_bggo_m.bggo007)
                     DISPLAY BY NAME g_bggo_m.bggo007_desc,g_bggo_m.bggo007
                     NEXT FIELD CURRENT
                  END IF   
                  #检查预算编号+版本+预算管理组织+销售来源下预算组织的下层组织是否存在未审核或未汇总的资料
                  IF NOT cl_null(g_bggo_m.bggo002) AND NOT cl_null(g_bggo_m.bggo003) AND
                     NOT cl_null(g_bggo_m.bggo004) AND NOT cl_null(g_bggo_m.bggo005) THEN
                     #檢查有下層組織, 但未確認之 abgt740 之資料 or 下層有資料未匯總
                     CALL s_abgt740_bggo007_chk(g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005,g_bggo_m.bggo007)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        IF g_errno = 'abg-00235' OR g_errno = 'abg-00236' THEN
                           LET g_errparam.replace[1] = cl_get_progname('abgt740',g_lang,"2")
                           LET g_errparam.exeprog = 'abgt740'
                        END IF
                        IF g_errno = 'abg-00234' THEN
                           LET g_errparam.replace[1] = cl_get_progname('abgt740',g_lang,"2")
                           LET g_errparam.exeprog = 'abgt740'
                        END IF
                        LET g_errparam.extend =g_bggo_m.bggo007
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bggo_m.bggo007 = g_bggo_m_t.bggo007
                        CALL s_desc_get_department_desc(g_bggo_m.bggo007) RETURNING g_bggo_m.bggo007_desc
                        DISPLAY BY NAME g_bggo_m.bggo007_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF                  
               END IF
            END IF
            LET g_bggo_m.bggo007_desc = s_desc_get_department_desc(g_bggo_m.bggo007)
            DISPLAY BY NAME g_bggo_m.bggo007_desc,g_bggo_m.bggo007


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo007
            #add-point:BEFORE FIELD bggo007 name="input.b.bggo007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo007
            #add-point:ON CHANGE bggo007 name="input.g.bggo007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo006
            #add-point:BEFORE FIELD bggo006 name="input.b.bggo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo006
            
            #add-point:AFTER FIELD bggo006 name="input.a.bggo006"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bggo_m.bggo001) AND NOT cl_null(g_bggo_m.bggo002) AND NOT cl_null(g_bggo_m.bggo003) AND NOT cl_null(g_bggo_m.bggo005) AND NOT cl_null(g_bggo_m.bggo006) AND NOT cl_null(g_bggo_m.bggo007) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bggo_m.bggo001 != g_bggo001_t  OR g_bggo_m.bggo002 != g_bggo002_t  OR g_bggo_m.bggo003 != g_bggo003_t  OR g_bggo_m.bggo005 != g_bggo005_t  OR g_bggo_m.bggo006 != g_bggo006_t  OR g_bggo_m.bggo007 != g_bggo007_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggo_t WHERE "||"bggoent = " ||g_enterprise|| " AND "||"bggo001 = '"||g_bggo_m.bggo001 ||"' AND "|| "bggo002 = '"||g_bggo_m.bggo002 ||"' AND "|| "bggo003 = '"||g_bggo_m.bggo003 ||"' AND "|| "bggo005 = '"||g_bggo_m.bggo005 ||"' AND "|| "bggo006 = '"||g_bggo_m.bggo006 ||"' AND "|| "bggo007 = '"||g_bggo_m.bggo007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo006
            #add-point:ON CHANGE bggo006 name="input.g.bggo006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggostus
            #add-point:BEFORE FIELD bggostus name="input.b.bggostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggostus
            
            #add-point:AFTER FIELD bggostus name="input.a.bggostus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggostus
            #add-point:ON CHANGE bggostus name="input.g.bggostus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bggo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo002
            #add-point:ON ACTION controlp INFIELD bggo002 name="input.c.bggo002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggo_m.bggo002      #給予default值
            LET g_qryparam.where = " bgaa001 IN (SELECT DISTINCT bggo002 FROM bggo_t ", 
                                   "              WHERE bggoent = ",g_enterprise,"  )"                                  
            CALL q_bgaa001()                                #呼叫開窗
            LET g_bggo_m.bggo002 = g_qryparam.return1              
            DISPLAY g_bggo_m.bggo002 TO bggo002              
            NEXT FIELD bggo002                               #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.bggo003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo003
            #add-point:ON ACTION controlp INFIELD bggo003 name="input.c.bggo003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bggo004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo004
            #add-point:ON ACTION controlp INFIELD bggo004 name="input.c.bggo004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggo_m.bggo004             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " bgaistus='Y' AND bgai003 = '",g_user,"'  ",
                                   " AND (bgai005 ='06' OR bgai005 = '00')    "
            IF NOT cl_null(g_bggo_m.bggo002) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgai001 = '",g_bggo_m.bggo002,"' "
            END IF
            CALL q_bgai002()                                #呼叫開窗
            LET g_bggo_m.bggo004 = g_qryparam.return1              
            DISPLAY g_bggo_m.bggo004 TO bggo004              #
            NEXT FIELD bggo004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bggo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo005
            #add-point:ON ACTION controlp INFIELD bggo005 name="input.c.bggo005"
            
            #END add-point
 
 
         #Ctrlp:input.c.bggo001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo001
            #add-point:ON ACTION controlp INFIELD bggo001 name="input.c.bggo001"
            
            #END add-point
 
 
         #Ctrlp:input.c.bggo007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo007
            #add-point:ON ACTION controlp INFIELD bggo007 name="input.c.bggo007"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bggo_m.bggo007          #給予default值
            LET g_qryparam.default2 = ""                        #组织编号
            LET g_qryparam.arg1 = "" 
            LET g_qryparam.where = " ooef205 = 'Y'"
            CALL s_abg2_get_budget_site(g_bggo_m.bggo002,g_bggo_m.bggo004,g_user,'06') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_site_str            
            CALL q_ooef001()                                #呼叫開窗
            LET g_bggo_m.bggo007 = g_qryparam.return1              
            DISPLAY g_bggo_m.bggo007 TO bggo007            
            NEXT FIELD bggo007                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bggo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo006
            #add-point:ON ACTION controlp INFIELD bggo006 name="input.c.bggo006"
            
            #END add-point
 
 
         #Ctrlp:input.c.bggostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggostus
            #add-point:ON ACTION controlp INFIELD bggostus name="input.c.bggostus"
            
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
            DISPLAY BY NAME g_bggo_m.bggo001             
                            ,g_bggo_m.bggo002   
                            ,g_bggo_m.bggo003   
                            ,g_bggo_m.bggo005   
                            ,g_bggo_m.bggo006   
                            ,g_bggo_m.bggo007   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL abgt740_bggo_t_mask_restore('restore_mask_o')
            
               UPDATE bggo_t SET (bggo002,bggo003,bggo004,bggo005,bggo001,bggo011,bggo007,bggo006,bggostus) = (g_bggo_m.bggo002, 
                   g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005,g_bggo_m.bggo001,g_bggo_m.bggo011, 
                   g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus)
                WHERE bggoent = g_enterprise AND bggo001 = g_bggo001_t
                  AND bggo002 = g_bggo002_t
                  AND bggo003 = g_bggo003_t
                  AND bggo005 = g_bggo005_t
                  AND bggo006 = g_bggo006_t
                  AND bggo007 = g_bggo007_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bggo_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bggo_m.bggo001
               LET gs_keys_bak[1] = g_bggo001_t
               LET gs_keys[2] = g_bggo_m.bggo002
               LET gs_keys_bak[2] = g_bggo002_t
               LET gs_keys[3] = g_bggo_m.bggo003
               LET gs_keys_bak[3] = g_bggo003_t
               LET gs_keys[4] = g_bggo_m.bggo005
               LET gs_keys_bak[4] = g_bggo005_t
               LET gs_keys[5] = g_bggo_m.bggo006
               LET gs_keys_bak[5] = g_bggo006_t
               LET gs_keys[6] = g_bggo_m.bggo007
               LET gs_keys_bak[6] = g_bggo007_t
               LET gs_keys[7] = g_bggo_d[g_detail_idx].bggo008
               LET gs_keys_bak[7] = g_bggo_d_t.bggo008
               LET gs_keys[8] = g_bggo_d[g_detail_idx].bggoseq
               LET gs_keys_bak[8] = g_bggo_d_t.bggoseq
               LET gs_keys[9] = g_bggo_d[g_detail_idx].bggoseq2
               LET gs_keys_bak[9] = g_bggo_d_t.bggoseq2
               CALL abgt740_update_b('bggo_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_bggo_m_t)
                     #LET g_log2 = util.JSON.stringify(g_bggo_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL abgt740_bggo_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               #自動產生單身
               CALL cl_err_collect_init()
               CALL s_transaction_begin()
               CALL abgt740_auto_ins_detail() RETURNING g_sub_success 
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD bggo002
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               CALL cl_err_collect_show()
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abgt740_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_bggo001_t = g_bggo_m.bggo001
           LET g_bggo002_t = g_bggo_m.bggo002
           LET g_bggo003_t = g_bggo_m.bggo003
           LET g_bggo005_t = g_bggo_m.bggo005
           LET g_bggo006_t = g_bggo_m.bggo006
           LET g_bggo007_t = g_bggo_m.bggo007
 
           
           IF g_bggo_d.getLength() = 0 THEN
              NEXT FIELD bggo008
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="abgt740.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_bggo_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bggo_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgt740_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            CALL s_transaction_end('Y',0)
            EXIT DIALOG
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
            CALL abgt740_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN abgt740_cl USING g_enterprise,g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE abgt740_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt740_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_bggo_d[l_ac].bggo008 IS NOT NULL
               AND g_bggo_d[l_ac].bggoseq IS NOT NULL
               AND g_bggo_d[l_ac].bggoseq2 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bggo_d_t.* = g_bggo_d[l_ac].*  #BACKUP
               LET g_bggo_d_o.* = g_bggo_d[l_ac].*  #BACKUP
               CALL abgt740_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL abgt740_set_no_entry_b(l_cmd)
               OPEN abgt740_bcl USING g_enterprise,g_bggo_m.bggo001,
                                                g_bggo_m.bggo002,
                                                g_bggo_m.bggo003,
                                                g_bggo_m.bggo005,
                                                g_bggo_m.bggo006,
                                                g_bggo_m.bggo007,
 
                                                g_bggo_d_t.bggo008
                                                ,g_bggo_d_t.bggoseq
                                                ,g_bggo_d_t.bggoseq2
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt740_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt740_bcl INTO g_bggo_d[l_ac].bggoseq,g_bggo_d[l_ac].bggoseq2,g_bggo_d[l_ac].bggo039, 
                      g_bggo_d[l_ac].bggo012,g_bggo_d[l_ac].bggo013,g_bggo_d[l_ac].bggo014,g_bggo_d[l_ac].bggo015, 
                      g_bggo_d[l_ac].bggo016,g_bggo_d[l_ac].bggo017,g_bggo_d[l_ac].bggo018,g_bggo_d[l_ac].bggo019, 
                      g_bggo_d[l_ac].bggo020,g_bggo_d[l_ac].bggo021,g_bggo_d[l_ac].bggo022,g_bggo_d[l_ac].bggo023, 
                      g_bggo_d[l_ac].bggo024,g_bggo_d[l_ac].bggo100,g_bggo_d[l_ac].bggo008,g_bggo_d[l_ac].bggo106 
 
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bggo_d_t.bggo008,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bggo_d_mask_o[l_ac].* =  g_bggo_d[l_ac].*
                  CALL abgt740_bggo_t_mask()
                  LET g_bggo_d_mask_n[l_ac].* =  g_bggo_d[l_ac].*
                  
                  CALL abgt740_ref_show()
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
            INITIALIZE g_bggo_d_t.* TO NULL
            INITIALIZE g_bggo_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bggo_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_bggo_d[l_ac].bggo106 = "0"
      LET g_bggo_d[l_ac].bggo1062 = "0"
      LET g_bggo_d[l_ac].bggo1063 = "0"
      LET g_bggo_d[l_ac].bggo1064 = "0"
      LET g_bggo_d[l_ac].bggo1065 = "0"
      LET g_bggo_d[l_ac].bggo1066 = "0"
      LET g_bggo_d[l_ac].bggo1067 = "0"
      LET g_bggo_d[l_ac].bggo1068 = "0"
      LET g_bggo_d[l_ac].bggo1069 = "0"
      LET g_bggo_d[l_ac].bggo10610 = "0"
      LET g_bggo_d[l_ac].bggo10611 = "0"
      LET g_bggo_d[l_ac].bggo10612 = "0"
      LET g_bggo_d[l_ac].bggo10613 = "0"
      LET g_bggo_d[l_ac].l_sum = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            
            #end add-point
            LET g_bggo_d_t.* = g_bggo_d[l_ac].*     #新輸入資料
            LET g_bggo_d_o.* = g_bggo_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgt740_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL abgt740_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bggo_d[li_reproduce_target].* = g_bggo_d[li_reproduce].*
 
               LET g_bggo_d[g_bggo_d.getLength()].bggo008 = NULL
               LET g_bggo_d[g_bggo_d.getLength()].bggoseq = NULL
               LET g_bggo_d[g_bggo_d.getLength()].bggoseq2 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM bggo_t 
             WHERE bggoent = g_enterprise AND bggo001 = g_bggo_m.bggo001
               AND bggo002 = g_bggo_m.bggo002
               AND bggo003 = g_bggo_m.bggo003
               AND bggo005 = g_bggo_m.bggo005
               AND bggo006 = g_bggo_m.bggo006
               AND bggo007 = g_bggo_m.bggo007
 
               AND bggo008 = g_bggo_d[l_ac].bggo008
               AND bggoseq = g_bggo_d[l_ac].bggoseq
               AND bggoseq2 = g_bggo_d[l_ac].bggoseq2
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
               INSERT INTO bggo_t
                           (bggoent,
                            bggo002,bggo003,bggo004,bggo005,bggo001,bggo011,bggo007,bggo006,bggostus,
                            bggo008,bggoseq,bggoseq2
                            ,bggo039,bggo012,bggo013,bggo014,bggo015,bggo016,bggo017,bggo018,bggo019,bggo020,bggo021,bggo022,bggo023,bggo024,bggo100,bggo106) 
                     VALUES(g_enterprise,
                            g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005,g_bggo_m.bggo001,g_bggo_m.bggo011,g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus,
                            g_bggo_d[l_ac].bggo008,g_bggo_d[l_ac].bggoseq,g_bggo_d[l_ac].bggoseq2
                            ,g_bggo_d[l_ac].bggo039,g_bggo_d[l_ac].bggo012,g_bggo_d[l_ac].bggo013,g_bggo_d[l_ac].bggo014, 
                                g_bggo_d[l_ac].bggo015,g_bggo_d[l_ac].bggo016,g_bggo_d[l_ac].bggo017, 
                                g_bggo_d[l_ac].bggo018,g_bggo_d[l_ac].bggo019,g_bggo_d[l_ac].bggo020, 
                                g_bggo_d[l_ac].bggo021,g_bggo_d[l_ac].bggo022,g_bggo_d[l_ac].bggo023, 
                                g_bggo_d[l_ac].bggo024,g_bggo_d[l_ac].bggo100,g_bggo_d[l_ac].bggo106) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_bggo_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
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
               IF abgt740_before_delete() THEN 
                  
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_bggo_m.bggo001
                  LET gs_keys[gs_keys.getLength()+1] = g_bggo_m.bggo002
                  LET gs_keys[gs_keys.getLength()+1] = g_bggo_m.bggo003
                  LET gs_keys[gs_keys.getLength()+1] = g_bggo_m.bggo005
                  LET gs_keys[gs_keys.getLength()+1] = g_bggo_m.bggo006
                  LET gs_keys[gs_keys.getLength()+1] = g_bggo_m.bggo007
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bggo_d_t.bggo008
                  LET gs_keys[gs_keys.getLength()+1] = g_bggo_d_t.bggoseq
                  LET gs_keys[gs_keys.getLength()+1] = g_bggo_d_t.bggoseq2
 
 
                  #刪除下層單身
                  IF NOT abgt740_key_delete_b(gs_keys,'bggo_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE abgt740_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE abgt740_bcl
               LET l_count = g_bggo_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_bggo_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggoseq
            #add-point:BEFORE FIELD bggoseq name="input.b.page1.bggoseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggoseq
            
            #add-point:AFTER FIELD bggoseq name="input.a.page1.bggoseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bggo_m.bggo001 IS NOT NULL AND g_bggo_m.bggo002 IS NOT NULL AND g_bggo_m.bggo003 IS NOT NULL AND g_bggo_m.bggo005 IS NOT NULL AND g_bggo_m.bggo006 IS NOT NULL AND g_bggo_m.bggo007 IS NOT NULL AND g_bggo_d[g_detail_idx].bggo008 IS NOT NULL AND g_bggo_d[g_detail_idx].bggoseq IS NOT NULL AND g_bggo_d[g_detail_idx].bggoseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bggo_m.bggo001 != g_bggo001_t OR g_bggo_m.bggo002 != g_bggo002_t OR g_bggo_m.bggo003 != g_bggo003_t OR g_bggo_m.bggo005 != g_bggo005_t OR g_bggo_m.bggo006 != g_bggo006_t OR g_bggo_m.bggo007 != g_bggo007_t OR g_bggo_d[g_detail_idx].bggo008 != g_bggo_d_t.bggo008 OR g_bggo_d[g_detail_idx].bggoseq != g_bggo_d_t.bggoseq OR g_bggo_d[g_detail_idx].bggoseq2 != g_bggo_d_t.bggoseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggo_t WHERE "||"bggoent = " ||g_enterprise|| " AND "||"bggo001 = '"||g_bggo_m.bggo001 ||"' AND "|| "bggo002 = '"||g_bggo_m.bggo002 ||"' AND "|| "bggo003 = '"||g_bggo_m.bggo003 ||"' AND "|| "bggo005 = '"||g_bggo_m.bggo005 ||"' AND "|| "bggo006 = '"||g_bggo_m.bggo006 ||"' AND "|| "bggo007 = '"||g_bggo_m.bggo007 ||"' AND "|| "bggo008 = '"||g_bggo_d[g_detail_idx].bggo008 ||"' AND "|| "bggoseq = '"||g_bggo_d[g_detail_idx].bggoseq ||"' AND "|| "bggoseq2 = '"||g_bggo_d[g_detail_idx].bggoseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggoseq
            #add-point:ON CHANGE bggoseq name="input.g.page1.bggoseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggoseq2
            #add-point:BEFORE FIELD bggoseq2 name="input.b.page1.bggoseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggoseq2
            
            #add-point:AFTER FIELD bggoseq2 name="input.a.page1.bggoseq2"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bggo_m.bggo001 IS NOT NULL AND g_bggo_m.bggo002 IS NOT NULL AND g_bggo_m.bggo003 IS NOT NULL AND g_bggo_m.bggo005 IS NOT NULL AND g_bggo_m.bggo006 IS NOT NULL AND g_bggo_m.bggo007 IS NOT NULL AND g_bggo_d[g_detail_idx].bggo008 IS NOT NULL AND g_bggo_d[g_detail_idx].bggoseq IS NOT NULL AND g_bggo_d[g_detail_idx].bggoseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bggo_m.bggo001 != g_bggo001_t OR g_bggo_m.bggo002 != g_bggo002_t OR g_bggo_m.bggo003 != g_bggo003_t OR g_bggo_m.bggo005 != g_bggo005_t OR g_bggo_m.bggo006 != g_bggo006_t OR g_bggo_m.bggo007 != g_bggo007_t OR g_bggo_d[g_detail_idx].bggo008 != g_bggo_d_t.bggo008 OR g_bggo_d[g_detail_idx].bggoseq != g_bggo_d_t.bggoseq OR g_bggo_d[g_detail_idx].bggoseq2 != g_bggo_d_t.bggoseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggo_t WHERE "||"bggoent = " ||g_enterprise|| " AND "||"bggo001 = '"||g_bggo_m.bggo001 ||"' AND "|| "bggo002 = '"||g_bggo_m.bggo002 ||"' AND "|| "bggo003 = '"||g_bggo_m.bggo003 ||"' AND "|| "bggo005 = '"||g_bggo_m.bggo005 ||"' AND "|| "bggo006 = '"||g_bggo_m.bggo006 ||"' AND "|| "bggo007 = '"||g_bggo_m.bggo007 ||"' AND "|| "bggo008 = '"||g_bggo_d[g_detail_idx].bggo008 ||"' AND "|| "bggoseq = '"||g_bggo_d[g_detail_idx].bggoseq ||"' AND "|| "bggoseq2 = '"||g_bggo_d[g_detail_idx].bggoseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggoseq2
            #add-point:ON CHANGE bggoseq2 name="input.g.page1.bggoseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo039
            #add-point:BEFORE FIELD bggo039 name="input.b.page1.bggo039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo039
            
            #add-point:AFTER FIELD bggo039 name="input.a.page1.bggo039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo039
            #add-point:ON CHANGE bggo039 name="input.g.page1.bggo039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo012
            #add-point:BEFORE FIELD bggo012 name="input.b.page1.bggo012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo012
            
            #add-point:AFTER FIELD bggo012 name="input.a.page1.bggo012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo012
            #add-point:ON CHANGE bggo012 name="input.g.page1.bggo012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo012_desc
            #add-point:BEFORE FIELD bggo012_desc name="input.b.page1.bggo012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo012_desc
            
            #add-point:AFTER FIELD bggo012_desc name="input.a.page1.bggo012_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo012_desc
            #add-point:ON CHANGE bggo012_desc name="input.g.page1.bggo012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo013
            #add-point:BEFORE FIELD bggo013 name="input.b.page1.bggo013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo013
            
            #add-point:AFTER FIELD bggo013 name="input.a.page1.bggo013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo013
            #add-point:ON CHANGE bggo013 name="input.g.page1.bggo013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo013_desc
            #add-point:BEFORE FIELD bggo013_desc name="input.b.page1.bggo013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo013_desc
            
            #add-point:AFTER FIELD bggo013_desc name="input.a.page1.bggo013_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo013_desc
            #add-point:ON CHANGE bggo013_desc name="input.g.page1.bggo013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo014
            #add-point:BEFORE FIELD bggo014 name="input.b.page1.bggo014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo014
            
            #add-point:AFTER FIELD bggo014 name="input.a.page1.bggo014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo014
            #add-point:ON CHANGE bggo014 name="input.g.page1.bggo014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo014_desc
            #add-point:BEFORE FIELD bggo014_desc name="input.b.page1.bggo014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo014_desc
            
            #add-point:AFTER FIELD bggo014_desc name="input.a.page1.bggo014_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo014_desc
            #add-point:ON CHANGE bggo014_desc name="input.g.page1.bggo014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo015
            #add-point:BEFORE FIELD bggo015 name="input.b.page1.bggo015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo015
            
            #add-point:AFTER FIELD bggo015 name="input.a.page1.bggo015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo015
            #add-point:ON CHANGE bggo015 name="input.g.page1.bggo015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo015_desc
            #add-point:BEFORE FIELD bggo015_desc name="input.b.page1.bggo015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo015_desc
            
            #add-point:AFTER FIELD bggo015_desc name="input.a.page1.bggo015_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo015_desc
            #add-point:ON CHANGE bggo015_desc name="input.g.page1.bggo015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo016
            #add-point:BEFORE FIELD bggo016 name="input.b.page1.bggo016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo016
            
            #add-point:AFTER FIELD bggo016 name="input.a.page1.bggo016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo016
            #add-point:ON CHANGE bggo016 name="input.g.page1.bggo016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo016_desc
            #add-point:BEFORE FIELD bggo016_desc name="input.b.page1.bggo016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo016_desc
            
            #add-point:AFTER FIELD bggo016_desc name="input.a.page1.bggo016_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo016_desc
            #add-point:ON CHANGE bggo016_desc name="input.g.page1.bggo016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo017
            #add-point:BEFORE FIELD bggo017 name="input.b.page1.bggo017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo017
            
            #add-point:AFTER FIELD bggo017 name="input.a.page1.bggo017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo017
            #add-point:ON CHANGE bggo017 name="input.g.page1.bggo017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo017_desc
            #add-point:BEFORE FIELD bggo017_desc name="input.b.page1.bggo017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo017_desc
            
            #add-point:AFTER FIELD bggo017_desc name="input.a.page1.bggo017_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo017_desc
            #add-point:ON CHANGE bggo017_desc name="input.g.page1.bggo017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo018
            #add-point:BEFORE FIELD bggo018 name="input.b.page1.bggo018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo018
            
            #add-point:AFTER FIELD bggo018 name="input.a.page1.bggo018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo018
            #add-point:ON CHANGE bggo018 name="input.g.page1.bggo018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo018_desc
            #add-point:BEFORE FIELD bggo018_desc name="input.b.page1.bggo018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo018_desc
            
            #add-point:AFTER FIELD bggo018_desc name="input.a.page1.bggo018_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo018_desc
            #add-point:ON CHANGE bggo018_desc name="input.g.page1.bggo018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo019
            #add-point:BEFORE FIELD bggo019 name="input.b.page1.bggo019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo019
            
            #add-point:AFTER FIELD bggo019 name="input.a.page1.bggo019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo019
            #add-point:ON CHANGE bggo019 name="input.g.page1.bggo019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo019_desc
            #add-point:BEFORE FIELD bggo019_desc name="input.b.page1.bggo019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo019_desc
            
            #add-point:AFTER FIELD bggo019_desc name="input.a.page1.bggo019_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo019_desc
            #add-point:ON CHANGE bggo019_desc name="input.g.page1.bggo019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo020
            #add-point:BEFORE FIELD bggo020 name="input.b.page1.bggo020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo020
            
            #add-point:AFTER FIELD bggo020 name="input.a.page1.bggo020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo020
            #add-point:ON CHANGE bggo020 name="input.g.page1.bggo020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo020_desc
            #add-point:BEFORE FIELD bggo020_desc name="input.b.page1.bggo020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo020_desc
            
            #add-point:AFTER FIELD bggo020_desc name="input.a.page1.bggo020_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo020_desc
            #add-point:ON CHANGE bggo020_desc name="input.g.page1.bggo020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo021
            #add-point:BEFORE FIELD bggo021 name="input.b.page1.bggo021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo021
            
            #add-point:AFTER FIELD bggo021 name="input.a.page1.bggo021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo021
            #add-point:ON CHANGE bggo021 name="input.g.page1.bggo021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo021_desc
            #add-point:BEFORE FIELD bggo021_desc name="input.b.page1.bggo021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo021_desc
            
            #add-point:AFTER FIELD bggo021_desc name="input.a.page1.bggo021_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo021_desc
            #add-point:ON CHANGE bggo021_desc name="input.g.page1.bggo021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo022
            #add-point:BEFORE FIELD bggo022 name="input.b.page1.bggo022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo022
            
            #add-point:AFTER FIELD bggo022 name="input.a.page1.bggo022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo022
            #add-point:ON CHANGE bggo022 name="input.g.page1.bggo022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo022_desc
            #add-point:BEFORE FIELD bggo022_desc name="input.b.page1.bggo022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo022_desc
            
            #add-point:AFTER FIELD bggo022_desc name="input.a.page1.bggo022_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo022_desc
            #add-point:ON CHANGE bggo022_desc name="input.g.page1.bggo022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo023
            #add-point:BEFORE FIELD bggo023 name="input.b.page1.bggo023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo023
            
            #add-point:AFTER FIELD bggo023 name="input.a.page1.bggo023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo023
            #add-point:ON CHANGE bggo023 name="input.g.page1.bggo023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo023_desc
            #add-point:BEFORE FIELD bggo023_desc name="input.b.page1.bggo023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo023_desc
            
            #add-point:AFTER FIELD bggo023_desc name="input.a.page1.bggo023_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo023_desc
            #add-point:ON CHANGE bggo023_desc name="input.g.page1.bggo023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo024
            #add-point:BEFORE FIELD bggo024 name="input.b.page1.bggo024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo024
            
            #add-point:AFTER FIELD bggo024 name="input.a.page1.bggo024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo024
            #add-point:ON CHANGE bggo024 name="input.g.page1.bggo024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo024_desc
            #add-point:BEFORE FIELD bggo024_desc name="input.b.page1.bggo024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo024_desc
            
            #add-point:AFTER FIELD bggo024_desc name="input.a.page1.bggo024_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo024_desc
            #add-point:ON CHANGE bggo024_desc name="input.g.page1.bggo024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo100
            #add-point:BEFORE FIELD bggo100 name="input.b.page1.bggo100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo100
            
            #add-point:AFTER FIELD bggo100 name="input.a.page1.bggo100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo100
            #add-point:ON CHANGE bggo100 name="input.g.page1.bggo100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo008
            #add-point:BEFORE FIELD bggo008 name="input.b.page1.bggo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo008
            
            #add-point:AFTER FIELD bggo008 name="input.a.page1.bggo008"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_bggo_m.bggo001 IS NOT NULL AND g_bggo_m.bggo002 IS NOT NULL AND g_bggo_m.bggo003 IS NOT NULL AND g_bggo_m.bggo005 IS NOT NULL AND g_bggo_m.bggo006 IS NOT NULL AND g_bggo_m.bggo007 IS NOT NULL AND g_bggo_d[g_detail_idx].bggo008 IS NOT NULL AND g_bggo_d[g_detail_idx].bggoseq IS NOT NULL AND g_bggo_d[g_detail_idx].bggoseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_bggo_m.bggo001 != g_bggo001_t OR g_bggo_m.bggo002 != g_bggo002_t OR g_bggo_m.bggo003 != g_bggo003_t OR g_bggo_m.bggo005 != g_bggo005_t OR g_bggo_m.bggo006 != g_bggo006_t OR g_bggo_m.bggo007 != g_bggo007_t OR g_bggo_d[g_detail_idx].bggo008 != g_bggo_d_t.bggo008 OR g_bggo_d[g_detail_idx].bggoseq != g_bggo_d_t.bggoseq OR g_bggo_d[g_detail_idx].bggoseq2 != g_bggo_d_t.bggoseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bggo_t WHERE "||"bggoent = " ||g_enterprise|| " AND "||"bggo001 = '"||g_bggo_m.bggo001 ||"' AND "|| "bggo002 = '"||g_bggo_m.bggo002 ||"' AND "|| "bggo003 = '"||g_bggo_m.bggo003 ||"' AND "|| "bggo005 = '"||g_bggo_m.bggo005 ||"' AND "|| "bggo006 = '"||g_bggo_m.bggo006 ||"' AND "|| "bggo007 = '"||g_bggo_m.bggo007 ||"' AND "|| "bggo008 = '"||g_bggo_d[g_detail_idx].bggo008 ||"' AND "|| "bggoseq = '"||g_bggo_d[g_detail_idx].bggoseq ||"' AND "|| "bggoseq2 = '"||g_bggo_d[g_detail_idx].bggoseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo008
            #add-point:ON CHANGE bggo008 name="input.g.page1.bggo008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo106
            #add-point:BEFORE FIELD bggo106 name="input.b.page1.bggo106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo106
            
            #add-point:AFTER FIELD bggo106 name="input.a.page1.bggo106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo106
            #add-point:ON CHANGE bggo106 name="input.g.page1.bggo106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1062
            #add-point:BEFORE FIELD bggo1062 name="input.b.page1.bggo1062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1062
            
            #add-point:AFTER FIELD bggo1062 name="input.a.page1.bggo1062"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo1062
            #add-point:ON CHANGE bggo1062 name="input.g.page1.bggo1062"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1063
            #add-point:BEFORE FIELD bggo1063 name="input.b.page1.bggo1063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1063
            
            #add-point:AFTER FIELD bggo1063 name="input.a.page1.bggo1063"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo1063
            #add-point:ON CHANGE bggo1063 name="input.g.page1.bggo1063"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1064
            #add-point:BEFORE FIELD bggo1064 name="input.b.page1.bggo1064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1064
            
            #add-point:AFTER FIELD bggo1064 name="input.a.page1.bggo1064"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo1064
            #add-point:ON CHANGE bggo1064 name="input.g.page1.bggo1064"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1065
            #add-point:BEFORE FIELD bggo1065 name="input.b.page1.bggo1065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1065
            
            #add-point:AFTER FIELD bggo1065 name="input.a.page1.bggo1065"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo1065
            #add-point:ON CHANGE bggo1065 name="input.g.page1.bggo1065"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1066
            #add-point:BEFORE FIELD bggo1066 name="input.b.page1.bggo1066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1066
            
            #add-point:AFTER FIELD bggo1066 name="input.a.page1.bggo1066"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo1066
            #add-point:ON CHANGE bggo1066 name="input.g.page1.bggo1066"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1067
            #add-point:BEFORE FIELD bggo1067 name="input.b.page1.bggo1067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1067
            
            #add-point:AFTER FIELD bggo1067 name="input.a.page1.bggo1067"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo1067
            #add-point:ON CHANGE bggo1067 name="input.g.page1.bggo1067"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1068
            #add-point:BEFORE FIELD bggo1068 name="input.b.page1.bggo1068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1068
            
            #add-point:AFTER FIELD bggo1068 name="input.a.page1.bggo1068"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo1068
            #add-point:ON CHANGE bggo1068 name="input.g.page1.bggo1068"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo1069
            #add-point:BEFORE FIELD bggo1069 name="input.b.page1.bggo1069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo1069
            
            #add-point:AFTER FIELD bggo1069 name="input.a.page1.bggo1069"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo1069
            #add-point:ON CHANGE bggo1069 name="input.g.page1.bggo1069"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo10610
            #add-point:BEFORE FIELD bggo10610 name="input.b.page1.bggo10610"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo10610
            
            #add-point:AFTER FIELD bggo10610 name="input.a.page1.bggo10610"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo10610
            #add-point:ON CHANGE bggo10610 name="input.g.page1.bggo10610"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo10611
            #add-point:BEFORE FIELD bggo10611 name="input.b.page1.bggo10611"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo10611
            
            #add-point:AFTER FIELD bggo10611 name="input.a.page1.bggo10611"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo10611
            #add-point:ON CHANGE bggo10611 name="input.g.page1.bggo10611"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo10612
            #add-point:BEFORE FIELD bggo10612 name="input.b.page1.bggo10612"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo10612
            
            #add-point:AFTER FIELD bggo10612 name="input.a.page1.bggo10612"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo10612
            #add-point:ON CHANGE bggo10612 name="input.g.page1.bggo10612"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bggo10613
            #add-point:BEFORE FIELD bggo10613 name="input.b.page1.bggo10613"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bggo10613
            
            #add-point:AFTER FIELD bggo10613 name="input.a.page1.bggo10613"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bggo10613
            #add-point:ON CHANGE bggo10613 name="input.g.page1.bggo10613"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sum
            #add-point:BEFORE FIELD l_sum name="input.b.page1.l_sum"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sum
            
            #add-point:AFTER FIELD l_sum name="input.a.page1.l_sum"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sum
            #add-point:ON CHANGE l_sum name="input.g.page1.l_sum"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bggoseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggoseq
            #add-point:ON ACTION controlp INFIELD bggoseq name="input.c.page1.bggoseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggoseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggoseq2
            #add-point:ON ACTION controlp INFIELD bggoseq2 name="input.c.page1.bggoseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo039
            #add-point:ON ACTION controlp INFIELD bggo039 name="input.c.page1.bggo039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo012
            #add-point:ON ACTION controlp INFIELD bggo012 name="input.c.page1.bggo012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo012_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo012_desc
            #add-point:ON ACTION controlp INFIELD bggo012_desc name="input.c.page1.bggo012_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo013
            #add-point:ON ACTION controlp INFIELD bggo013 name="input.c.page1.bggo013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo013_desc
            #add-point:ON ACTION controlp INFIELD bggo013_desc name="input.c.page1.bggo013_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo014
            #add-point:ON ACTION controlp INFIELD bggo014 name="input.c.page1.bggo014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo014_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo014_desc
            #add-point:ON ACTION controlp INFIELD bggo014_desc name="input.c.page1.bggo014_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo015
            #add-point:ON ACTION controlp INFIELD bggo015 name="input.c.page1.bggo015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo015_desc
            #add-point:ON ACTION controlp INFIELD bggo015_desc name="input.c.page1.bggo015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo016
            #add-point:ON ACTION controlp INFIELD bggo016 name="input.c.page1.bggo016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo016_desc
            #add-point:ON ACTION controlp INFIELD bggo016_desc name="input.c.page1.bggo016_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo017
            #add-point:ON ACTION controlp INFIELD bggo017 name="input.c.page1.bggo017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo017_desc
            #add-point:ON ACTION controlp INFIELD bggo017_desc name="input.c.page1.bggo017_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo018
            #add-point:ON ACTION controlp INFIELD bggo018 name="input.c.page1.bggo018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo018_desc
            #add-point:ON ACTION controlp INFIELD bggo018_desc name="input.c.page1.bggo018_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo019
            #add-point:ON ACTION controlp INFIELD bggo019 name="input.c.page1.bggo019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo019_desc
            #add-point:ON ACTION controlp INFIELD bggo019_desc name="input.c.page1.bggo019_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo020
            #add-point:ON ACTION controlp INFIELD bggo020 name="input.c.page1.bggo020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo020_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo020_desc
            #add-point:ON ACTION controlp INFIELD bggo020_desc name="input.c.page1.bggo020_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo021
            #add-point:ON ACTION controlp INFIELD bggo021 name="input.c.page1.bggo021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo021_desc
            #add-point:ON ACTION controlp INFIELD bggo021_desc name="input.c.page1.bggo021_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo022
            #add-point:ON ACTION controlp INFIELD bggo022 name="input.c.page1.bggo022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo022_desc
            #add-point:ON ACTION controlp INFIELD bggo022_desc name="input.c.page1.bggo022_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo023
            #add-point:ON ACTION controlp INFIELD bggo023 name="input.c.page1.bggo023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo023_desc
            #add-point:ON ACTION controlp INFIELD bggo023_desc name="input.c.page1.bggo023_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo024
            #add-point:ON ACTION controlp INFIELD bggo024 name="input.c.page1.bggo024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo024_desc
            #add-point:ON ACTION controlp INFIELD bggo024_desc name="input.c.page1.bggo024_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo100
            #add-point:ON ACTION controlp INFIELD bggo100 name="input.c.page1.bggo100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo008
            #add-point:ON ACTION controlp INFIELD bggo008 name="input.c.page1.bggo008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo106
            #add-point:ON ACTION controlp INFIELD bggo106 name="input.c.page1.bggo106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo1062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1062
            #add-point:ON ACTION controlp INFIELD bggo1062 name="input.c.page1.bggo1062"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo1063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1063
            #add-point:ON ACTION controlp INFIELD bggo1063 name="input.c.page1.bggo1063"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo1064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1064
            #add-point:ON ACTION controlp INFIELD bggo1064 name="input.c.page1.bggo1064"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo1065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1065
            #add-point:ON ACTION controlp INFIELD bggo1065 name="input.c.page1.bggo1065"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo1066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1066
            #add-point:ON ACTION controlp INFIELD bggo1066 name="input.c.page1.bggo1066"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo1067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1067
            #add-point:ON ACTION controlp INFIELD bggo1067 name="input.c.page1.bggo1067"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo1068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1068
            #add-point:ON ACTION controlp INFIELD bggo1068 name="input.c.page1.bggo1068"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo1069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo1069
            #add-point:ON ACTION controlp INFIELD bggo1069 name="input.c.page1.bggo1069"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo10610
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo10610
            #add-point:ON ACTION controlp INFIELD bggo10610 name="input.c.page1.bggo10610"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo10611
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo10611
            #add-point:ON ACTION controlp INFIELD bggo10611 name="input.c.page1.bggo10611"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo10612
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo10612
            #add-point:ON ACTION controlp INFIELD bggo10612 name="input.c.page1.bggo10612"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bggo10613
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bggo10613
            #add-point:ON ACTION controlp INFIELD bggo10613 name="input.c.page1.bggo10613"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_sum
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sum
            #add-point:ON ACTION controlp INFIELD l_sum name="input.c.page1.l_sum"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bggo_d[l_ac].* = g_bggo_d_t.*
               CLOSE abgt740_bcl
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
               LET g_errparam.extend = g_bggo_d[l_ac].bggo008 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bggo_d[l_ac].* = g_bggo_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
         
               #將遮罩欄位還原
               CALL abgt740_bggo_t_mask_restore('restore_mask_o')
         
               UPDATE bggo_t SET (bggo001,bggo002,bggo003,bggo005,bggo006,bggo007,bggoseq,bggoseq2,bggo039, 
                   bggo012,bggo013,bggo014,bggo015,bggo016,bggo017,bggo018,bggo019,bggo020,bggo021,bggo022, 
                   bggo023,bggo024,bggo100,bggo008,bggo106) = (g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003, 
                   g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007,g_bggo_d[l_ac].bggoseq,g_bggo_d[l_ac].bggoseq2, 
                   g_bggo_d[l_ac].bggo039,g_bggo_d[l_ac].bggo012,g_bggo_d[l_ac].bggo013,g_bggo_d[l_ac].bggo014, 
                   g_bggo_d[l_ac].bggo015,g_bggo_d[l_ac].bggo016,g_bggo_d[l_ac].bggo017,g_bggo_d[l_ac].bggo018, 
                   g_bggo_d[l_ac].bggo019,g_bggo_d[l_ac].bggo020,g_bggo_d[l_ac].bggo021,g_bggo_d[l_ac].bggo022, 
                   g_bggo_d[l_ac].bggo023,g_bggo_d[l_ac].bggo024,g_bggo_d[l_ac].bggo100,g_bggo_d[l_ac].bggo008, 
                   g_bggo_d[l_ac].bggo106)
                WHERE bggoent = g_enterprise AND bggo001 = g_bggo_m.bggo001 
                 AND bggo002 = g_bggo_m.bggo002 
                 AND bggo003 = g_bggo_m.bggo003 
                 AND bggo005 = g_bggo_m.bggo005 
                 AND bggo006 = g_bggo_m.bggo006 
                 AND bggo007 = g_bggo_m.bggo007 
 
                 AND bggo008 = g_bggo_d_t.bggo008 #項次   
                 AND bggoseq = g_bggo_d_t.bggoseq  
                 AND bggoseq2 = g_bggo_d_t.bggoseq2  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bggo_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "bggo_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bggo_m.bggo001
               LET gs_keys_bak[1] = g_bggo001_t
               LET gs_keys[2] = g_bggo_m.bggo002
               LET gs_keys_bak[2] = g_bggo002_t
               LET gs_keys[3] = g_bggo_m.bggo003
               LET gs_keys_bak[3] = g_bggo003_t
               LET gs_keys[4] = g_bggo_m.bggo005
               LET gs_keys_bak[4] = g_bggo005_t
               LET gs_keys[5] = g_bggo_m.bggo006
               LET gs_keys_bak[5] = g_bggo006_t
               LET gs_keys[6] = g_bggo_m.bggo007
               LET gs_keys_bak[6] = g_bggo007_t
               LET gs_keys[7] = g_bggo_d[g_detail_idx].bggo008
               LET gs_keys_bak[7] = g_bggo_d_t.bggo008
               LET gs_keys[8] = g_bggo_d[g_detail_idx].bggoseq
               LET gs_keys_bak[8] = g_bggo_d_t.bggoseq
               LET gs_keys[9] = g_bggo_d[g_detail_idx].bggoseq2
               LET gs_keys_bak[9] = g_bggo_d_t.bggoseq2
               CALL abgt740_update_b('bggo_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_bggo_m),util.JSON.stringify(g_bggo_d_t)
                     LET g_log2 = util.JSON.stringify(g_bggo_m),util.JSON.stringify(g_bggo_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgt740_bggo_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_bggo_m.bggo001
               LET ls_keys[ls_keys.getLength()+1] = g_bggo_m.bggo002
               LET ls_keys[ls_keys.getLength()+1] = g_bggo_m.bggo003
               LET ls_keys[ls_keys.getLength()+1] = g_bggo_m.bggo005
               LET ls_keys[ls_keys.getLength()+1] = g_bggo_m.bggo006
               LET ls_keys[ls_keys.getLength()+1] = g_bggo_m.bggo007
 
               LET ls_keys[ls_keys.getLength()+1] = g_bggo_d_t.bggo008
               LET ls_keys[ls_keys.getLength()+1] = g_bggo_d_t.bggoseq
               LET ls_keys[ls_keys.getLength()+1] = g_bggo_d_t.bggoseq2
 
               CALL abgt740_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE abgt740_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bggo_d[l_ac].* = g_bggo_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE abgt740_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_bggo_d.getLength() = 0 THEN
               NEXT FIELD bggo008
            END IF
            #add-point:input段after input  name="input.body.after_input"
           
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bggo_d[li_reproduce_target].* = g_bggo_d[li_reproduce].*
 
               LET g_bggo_d[li_reproduce_target].bggo008 = NULL
               LET g_bggo_d[li_reproduce_target].bggoseq = NULL
               LET g_bggo_d[li_reproduce_target].bggoseq2 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bggo_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bggo_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      DISPLAY ARRAY g_bggo2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abgt740_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL abgt740_idx_chk()
            CALL abgt740_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page3自定義行為 name="input.body3.action"

         #end add-point
         
      END DISPLAY
 
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD bggo001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bggoseq
 
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
 
{<section id="abgt740.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abgt740_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
  
   #最大週期數
   SELECT MAX(bgac004) INTO g_max_period FROM bgac_t
    WHERE bgacent = g_enterprise 
      AND bgac001= (SELECT bgaa002 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bggo_m.bggo002) 
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL abgt740_b_fill(g_wc2) #第一階單身填充
      CALL abgt740_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgt740_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"

   #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼
    SELECT bgaa002,bgaa003,bgaa008,bgaa009 INTO g_bgaa.*
      FROM bgaa_t
     WHERE bgaaent = g_enterprise
       AND bgaa001 = g_bggo_m.bggo002
   SELECT DISTINCT bgai008 INTO g_bggo_m.bggo011 FROM bgai_t
    WHERE bgaient=g_enterprise AND bgai001=g_bggo_m.bggo002 AND bgai002=g_bggo_m.bggo004
   LET g_bggo_m.l_bgaa002 = g_bgaa.bgaa002 #預算週期
   LET g_bggo_m.l_bgaa003 = g_bgaa.bgaa003 #預算幣別
   LET g_bggo_m.bggo002_desc = s_desc_get_budget_desc(g_bggo_m.bggo002)
   LET g_bggo_m.bggo007_desc = s_desc_get_department_desc(g_bggo_m.bggo007)
   CALL s_desc_get_bgai002_desc(g_bggo_m.bggo001,g_bggo_m.bggo004) RETURNING g_bggo_m.bggo004_desc      
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_bggo_m.bggo002
   LET g_ref_fields[2] = g_bggo_m.bggo004
   CALL ap_ref_array2(g_ref_fields,"SELECT bgail004 FROM bgail_t WHERE bgailent="||g_enterprise||" AND bgail001=? AND bgail002=? AND bgail003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bggo_m.bggo004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_bggo_m.bggo004_desc             
   
   CALL abgt740_set_bggo_visible()
   #當期別不為13期時，影藏13期的數量、單價、銷售金額欄位
   IF g_max_period < 13 THEN
      CALL cl_set_comp_visible("bggo10613,bggo106131,",FALSE)
   ELSE
      CALL cl_set_comp_visible("bggo10613,bggo106131,",TRUE)
   END IF
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_bggo_m.bggo002,g_bggo_m.bggo002_desc,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo004_desc, 
       g_bggo_m.bggo005,g_bggo_m.bggo001,g_bggo_m.l_bgaa002,g_bggo_m.l_bgaa003,g_bggo_m.bggo011,g_bggo_m.bggo007, 
       g_bggo_m.bggo007_desc,g_bggo_m.bggo006,g_bggo_m.bggostus
 
   CALL abgt740_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION abgt740_ref_show()
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
   FOR l_ac = 1 TO g_bggo_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="abgt740.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgt740_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE bggo_t.bggo001 
   DEFINE l_oldno     LIKE bggo_t.bggo001 
   DEFINE l_newno02     LIKE bggo_t.bggo002 
   DEFINE l_oldno02     LIKE bggo_t.bggo002 
   DEFINE l_newno03     LIKE bggo_t.bggo003 
   DEFINE l_oldno03     LIKE bggo_t.bggo003 
   DEFINE l_newno04     LIKE bggo_t.bggo005 
   DEFINE l_oldno04     LIKE bggo_t.bggo005 
   DEFINE l_newno05     LIKE bggo_t.bggo006 
   DEFINE l_oldno05     LIKE bggo_t.bggo006 
   DEFINE l_newno06     LIKE bggo_t.bggo007 
   DEFINE l_oldno06     LIKE bggo_t.bggo007 
 
   DEFINE l_master    RECORD LIKE bggo_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bggo_t.* #此變數樣板目前無使用
 
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
 
   IF g_bggo_m.bggo001 IS NULL
      OR g_bggo_m.bggo002 IS NULL
      OR g_bggo_m.bggo003 IS NULL
      OR g_bggo_m.bggo005 IS NULL
      OR g_bggo_m.bggo006 IS NULL
      OR g_bggo_m.bggo007 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_bggo001_t = g_bggo_m.bggo001
   LET g_bggo002_t = g_bggo_m.bggo002
   LET g_bggo003_t = g_bggo_m.bggo003
   LET g_bggo005_t = g_bggo_m.bggo005
   LET g_bggo006_t = g_bggo_m.bggo006
   LET g_bggo007_t = g_bggo_m.bggo007
 
   
   LET g_bggo_m.bggo001 = ""
   LET g_bggo_m.bggo002 = ""
   LET g_bggo_m.bggo003 = ""
   LET g_bggo_m.bggo005 = ""
   LET g_bggo_m.bggo006 = ""
   LET g_bggo_m.bggo007 = ""
 
   LET g_master_insert = FALSE
   CALL abgt740_set_entry('a')
   CALL abgt740_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_bggo_m.bggo002_desc = ''
   DISPLAY BY NAME g_bggo_m.bggo002_desc
   LET g_bggo_m.bggo007_desc = ''
   DISPLAY BY NAME g_bggo_m.bggo007_desc
 
   
   CALL abgt740_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_bggo_m.* TO NULL
      INITIALIZE g_bggo_d TO NULL
 
      CALL abgt740_show()
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
   CALL abgt740_set_act_visible()
   CALL abgt740_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bggo001_t = g_bggo_m.bggo001
   LET g_bggo002_t = g_bggo_m.bggo002
   LET g_bggo003_t = g_bggo_m.bggo003
   LET g_bggo005_t = g_bggo_m.bggo005
   LET g_bggo006_t = g_bggo_m.bggo006
   LET g_bggo007_t = g_bggo_m.bggo007
 
   
   #組合新增資料的條件
   LET g_add_browse = " bggoent = " ||g_enterprise|| " AND",
                      " bggo001 = '", g_bggo_m.bggo001, "' "
                      ," AND bggo002 = '", g_bggo_m.bggo002, "' "
                      ," AND bggo003 = '", g_bggo_m.bggo003, "' "
                      ," AND bggo005 = '", g_bggo_m.bggo005, "' "
                      ," AND bggo006 = '", g_bggo_m.bggo006, "' "
                      ," AND bggo007 = '", g_bggo_m.bggo007, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt740_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL abgt740_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL abgt740_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abgt740_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bggo_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abgt740_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bggo_t
    WHERE bggoent = g_enterprise AND bggo001 = g_bggo001_t
    AND bggo002 = g_bggo002_t
    AND bggo003 = g_bggo003_t
    AND bggo005 = g_bggo005_t
    AND bggo006 = g_bggo006_t
    AND bggo007 = g_bggo007_t
 
       INTO TEMP abgt740_detail
   
   #將key修正為調整後   
   UPDATE abgt740_detail 
      #更新key欄位
      SET bggo001 = g_bggo_m.bggo001
          , bggo002 = g_bggo_m.bggo002
          , bggo003 = g_bggo_m.bggo003
          , bggo005 = g_bggo_m.bggo005
          , bggo006 = g_bggo_m.bggo006
          , bggo007 = g_bggo_m.bggo007
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO bggo_t SELECT * FROM abgt740_detail
   
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
   DROP TABLE abgt740_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bggo001_t = g_bggo_m.bggo001
   LET g_bggo002_t = g_bggo_m.bggo002
   LET g_bggo003_t = g_bggo_m.bggo003
   LET g_bggo005_t = g_bggo_m.bggo005
   LET g_bggo006_t = g_bggo_m.bggo006
   LET g_bggo007_t = g_bggo_m.bggo007
 
   
   DROP TABLE abgt740_detail
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgt740_delete()
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
   
   IF g_bggo_m.bggo001 IS NULL
   OR g_bggo_m.bggo002 IS NULL
   OR g_bggo_m.bggo003 IS NULL
   OR g_bggo_m.bggo005 IS NULL
   OR g_bggo_m.bggo006 IS NULL
   OR g_bggo_m.bggo007 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN abgt740_cl USING g_enterprise,g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt740_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt740_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt740_master_referesh USING g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005, 
       g_bggo_m.bggo006,g_bggo_m.bggo007 INTO g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005, 
       g_bggo_m.bggo001,g_bggo_m.bggo011,g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus
   
   #遮罩相關處理
   LET g_bggo_m_mask_o.* =  g_bggo_m.*
   CALL abgt740_bggo_t_mask()
   LET g_bggo_m_mask_n.* =  g_bggo_m.*
   
   CALL abgt740_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgt740_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
 
      #end add-point
      
      DELETE FROM bggo_t WHERE bggoent = g_enterprise AND bggo001 = g_bggo_m.bggo001
                                                               AND bggo002 = g_bggo_m.bggo002
                                                               AND bggo003 = g_bggo_m.bggo003
                                                               AND bggo005 = g_bggo_m.bggo005
                                                               AND bggo006 = g_bggo_m.bggo006
                                                               AND bggo007 = g_bggo_m.bggo007
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
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
      #   CLOSE abgt740_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_bggo_d.clear() 
 
     
      CALL abgt740_ui_browser_refresh()  
      #CALL abgt740_ui_headershow()  
      #CALL abgt740_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgt740_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abgt740_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abgt740_cl
 
   #功能已完成,通報訊息中心
   CALL abgt740_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abgt740.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgt740_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_sql      STRING
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
 
   #end add-point
   
   #先清空單身變數內容
   CALL g_bggo_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT bggoseq,bggoseq2,bggo039,bggo012,bggo013,bggo014,bggo015,bggo016,bggo017, 
       bggo018,bggo019,bggo020,bggo021,bggo022,bggo023,bggo024,bggo100,bggo008,bggo106 FROM bggo_t", 
          
               "",
               
               
               " WHERE bggoent= ? AND bggo001=? AND bggo002=? AND bggo003=? AND bggo005=? AND bggo006=? AND bggo007=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bggo_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #重寫SQL,一行顯示12期資料，不考慮期別
   LET g_sql = "SELECT  DISTINCT bggoseq,bggoseq2,bggo039,bggo012,bggo013,bggo014,bggo015,bggo016,bggo017, 
       bggo018,bggo019,bggo020,bggo021,bggo022,bggo023,bggo024,bggo100,'0',bggo106,bggo025,bggo026, 
       bggo027,bggo028,bggo029,bggo030,bggo031,bggo032,bggo033,bggo034 FROM bggo_t",   
               "",
               
               
               " WHERE bggo106 <>'0' AND bggoent= ? AND bggo001=? AND bggo002=? AND bggo003=? AND bggo005=? AND bggo006=? AND bggo007=?"  
   
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bggo_t")
   END IF
   LET l_sql = g_sql
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF abgt740_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY bggo_t.bggo008,bggo_t.bggoseq,bggo_t.bggoseq2"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         LET g_sql = l_sql," ORDER BY bggo_t.bggoseq"
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgt740_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abgt740_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005, 
          g_bggo_m.bggo006,g_bggo_m.bggo007 INTO g_bggo_d[l_ac].bggoseq,g_bggo_d[l_ac].bggoseq2,g_bggo_d[l_ac].bggo039, 
          g_bggo_d[l_ac].bggo012,g_bggo_d[l_ac].bggo013,g_bggo_d[l_ac].bggo014,g_bggo_d[l_ac].bggo015, 
          g_bggo_d[l_ac].bggo016,g_bggo_d[l_ac].bggo017,g_bggo_d[l_ac].bggo018,g_bggo_d[l_ac].bggo019, 
          g_bggo_d[l_ac].bggo020,g_bggo_d[l_ac].bggo021,g_bggo_d[l_ac].bggo022,g_bggo_d[l_ac].bggo023, 
          g_bggo_d[l_ac].bggo024,g_bggo_d[l_ac].bggo100,g_bggo_d[l_ac].bggo008,g_bggo_d[l_ac].bggo106  
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
         CALL abgt740_get_num_and_price()
         #說明
         CALL abgt740_detail_desc()
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
 
            CALL g_bggo_d.deleteElement(g_bggo_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   IF g_bggo_d.getLength() > 0 THEN
      IF g_cnt > 0 THEN
         IF g_cnt > g_bggo_d.getLength() THEN
            LET l_cnt = 1
         ELSE
            LET l_cnt = g_cnt
         END IF
      ELSE
         LET l_cnt = 1
      END IF
      CALL abgt740_b_fill2(l_cnt)
      #IF cl_null(g_bggo_d[l_ac].bggoseq) THEN
      #   CALL g_bggo_d.deleteElement(g_bggo_d.getLength())
      #END IF
   END IF

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bggo_d.getLength()
      LET g_bggo_d_mask_o[l_ac].* =  g_bggo_d[l_ac].*
      CALL abgt740_bggo_t_mask()
      LET g_bggo_d_mask_n[l_ac].* =  g_bggo_d[l_ac].*
   END FOR
   
 
 
   FREE abgt740_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abgt740_idx_chk()
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
      IF g_detail_idx > g_bggo_d.getLength() THEN
         LET g_detail_idx = g_bggo_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_bggo_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bggo_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgt740_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_bgaa010      LIKE bgaa_t.bgaa010
   DEFINE l_bgaa011      LIKE bgaa_t.bgaa011
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_dnstep_wc    STRING
   DEFINE l_ooed004      LIKE ooed_t.ooed004
   DEFINE l_sql,l_sql1,l_sql2  STRING
   DEFINE l_amt          LIKE bggo_t.bggo106
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_sum          LIKE bggo_t.bggo106
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_bggo_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   IF pi_idx <=0 THEN
      RETURN
   END IF
   LET l_sum = 0
   CALL g_bggo2_d.clear()
   
   #最上层组织和版本
   SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t 
    WHERE bgaaent=g_enterprise AND bgaa001=g_bggo_m.bggo002                

   LET l_sql1 = " SELECT DISTINCT bggo007,bggo012,bggo013,bggo014,bggo015,bggo016, ",
                "                 bggo017,bggo018,bggo019,bggo020,bggo021,bggo022, ",
                "                 bggo023,bggo024,bggo100  ",
                "  FROM bggo_t                             ",   
                " WHERE bggoent = ",g_enterprise,"         ",
                "   AND bggo002 = '",g_bggo_m.bggo002,"'   ",
                "   AND bggo003 = '",g_bggo_m.bggo003,"'   ",
                "   AND bggo007=?                          ",
                "   AND bggo039 = '",g_bggo_d[pi_idx].bggo039,"'  ", #預算細項
                "   AND bggo100 = '",g_bggo_d[pi_idx].bggo100,"'  ", #幣別
                "   AND bggostus IN ('Y','FC')                    "
    #将核算项条件加入where条件
    #部门
    IF NOT cl_null(g_bggo_d[pi_idx].bggo013) THEN
       LET l_sql1=l_sql1," AND bggo013='",g_bggo_d[pi_idx].bggo013,"'"
    END IF
    #利润成本中心
    IF NOT cl_null(g_bggo_d[pi_idx].bggo014) THEN
       LET l_sql1=l_sql1," AND bggo014='",g_bggo_d[pi_idx].bggo014,"'"
    END IF
    #区域
    IF NOT cl_null(g_bggo_d[pi_idx].bggo015) THEN
       LET l_sql1=l_sql1," AND bggo015='",g_bggo_d[pi_idx].bggo015,"'"
    END IF
    #收付款客商
    IF NOT cl_null(g_bggo_d[pi_idx].bggo016) THEN
       LET l_sql1=l_sql1," AND bggo016='",g_bggo_d[pi_idx].bggo016,"'"
    END IF
    #账款客商
    IF NOT cl_null(g_bggo_d[pi_idx].bggo017) THEN
       LET l_sql1=l_sql1," AND bggo017='",g_bggo_d[pi_idx].bggo017,"'"
    END IF
    #客群
    IF NOT cl_null(g_bggo_d[pi_idx].bggo018) THEN
       LET l_sql1=l_sql1," AND bggo018='",g_bggo_d[pi_idx].bggo018,"'"
    END IF
    #产品类别
    IF NOT cl_null(g_bggo_d[pi_idx].bggo019) THEN
       LET l_sql1=l_sql1," AND bggo019='",g_bggo_d[pi_idx].bggo019,"'"
    END IF
    #经营方式
    IF NOT cl_null(g_bggo_d[pi_idx].bggo022) THEN
       LET l_sql1=l_sql1," AND bggo022='",g_bggo_d[pi_idx].bggo022,"'"
    END IF
    #通路
    IF NOT cl_null(g_bggo_d[pi_idx].bggo023) THEN
       LET l_sql1=l_sql1," AND bggo023='",g_bggo_d[pi_idx].bggo023,"'"
    END IF
    #品牌
    IF NOT cl_null(g_bggo_d[pi_idx].bggo024) THEN
       LET l_sql1=l_sql1," AND bggo024='",g_bggo_d[pi_idx].bggo024,"'"
    END IF
    #人员
    IF NOT cl_null(g_bggo_d[pi_idx].bggo012) THEN
       LET l_sql1=l_sql1," AND bggo012='",g_bggo_d[pi_idx].bggo012,"'"
    END IF
    #专案
    IF NOT cl_null(g_bggo_d[pi_idx].bggo020) THEN
       LET l_sql1=l_sql1," AND bggo020='",g_bggo_d[pi_idx].bggo020,"'"
    END IF
    #WBS
    IF NOT cl_null(g_bggo_d[pi_idx].bggo021) THEN
       LET l_sql1=l_sql1," AND bggo021='",g_bggo_d[pi_idx].bggo021,"'"
    END IF

   LET l_sql2 = " ORDER BY bggo007,bggo012,bggo013,bggo014,bggo015,bggo016, ",              
                "          bggo017,bggo018,bggo019,bggo020,bggo021,bggo022, ",    
                "          bggo023,bggo024,bggo100                          "                        
   
   #最下层组织，抓取abgt730资料
   LET l_sql=l_sql1, " AND bggo001='20'   AND bggo006='1' ",l_sql2
   PREPARE abgt740_b_fill2_pr2 FROM l_sql
   DECLARE abgt740_b_fill2_cs2 CURSOR FOR abgt740_b_fill2_pr2
   
   #不是最下层组织，抓取abgt740
   LET l_sql=l_sql1,"   AND bggo001='30'  AND bggo006='2'",l_sql2
   PREPARE abgt740_b_fill2_pr3 FROM l_sql
   DECLARE abgt740_b_fill2_cs3 CURSOR FOR abgt740_b_fill2_pr3   
   
   #按照預算組織+核算項+幣别+期别抓取金额
   LET l_sql="SELECT SUM(bggo106)",
             "  FROM bggo_t ",
              " WHERE bggoent=",g_enterprise,
              "   AND bggo001=? AND bggo006 = ? ",
              "   AND bggo002='",g_bggo_m.bggo002,"'",
              "   AND bggo003='",g_bggo_m.bggo003,"'",
              "   AND bggo039='",g_bggo_d[pi_idx].bggo039,"'",
              "   AND bggo100='",g_bggo_d[pi_idx].bggo100,"'",
              "   AND bggostus IN ('Y','FC')",
              "   AND bggo007=?",
              "   AND bggo012=? AND bggo013=? AND bggo014=? ",
              "   AND bggo015=? AND bggo016=? AND bggo017=? ",
              "   AND bggo018=? AND bggo019=? AND bggo020=? ",
              "   AND bggo021=? AND bggo022=? AND bggo023=? ",
              "   AND bggo024=?  AND bggo100=? AND bggo008=? "  
   PREPARE abgt740_b_fill2_pr4 FROM l_sql
   
   LET l_ac2 = 1
   IF NOT cl_null(l_bgaa010) THEN   
      #抓取预算组织的下层组织
      LET l_sql="SELECT ooed004 FROM ooed_t ",
                " WHERE ooedent=",g_enterprise,
                "   AND ooed001='4' ",
                "   AND ooed002='",l_bgaa011,"'",
                "   AND ooed003='",l_bgaa010,"'",
                "   AND ooed005='",g_bggo_m.bggo007,"'"
      PREPARE abgt740_b_fill2_pr1 FROM l_sql
      DECLARE abgt740_b_fill2_cs1 CURSOR FOR abgt740_b_fill2_pr1
      FOREACH abgt740_b_fill2_cs1 INTO l_ooed004
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF         
         #判断该下层组织是否为最下层组织,如果是最下层组织，抓取abgt730资料，如果不是，抓取abgt740
         LET l_cnt=0
         SELECT COUNT(1) INTO l_cnt FROM ooed_t
          WHERE ooedent=g_enterprise AND ooed001='4'
            AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
            AND ooed005=l_ooed004
         IF cl_null(l_ooed004) THEN LET l_ooed004 = g_bggo_m.bggo007 END IF
         IF l_cnt = 0 OR l_ooed004 = g_bggo_m.bggo007  THEN #最下層組織
            FOREACH abgt740_b_fill2_cs2 USING l_ooed004
               INTO g_bggo2_d[l_ac2].bggo007 ,g_bggo2_d[l_ac2].bggo0121,g_bggo2_d[l_ac2].bggo0131,
                    g_bggo2_d[l_ac2].bggo0141,g_bggo2_d[l_ac2].bggo0151,g_bggo2_d[l_ac2].bggo0161,
                    g_bggo2_d[l_ac2].bggo0171,g_bggo2_d[l_ac2].bggo0181,g_bggo2_d[l_ac2].bggo0191,
                    g_bggo2_d[l_ac2].bggo0201,g_bggo2_d[l_ac2].bggo0211,g_bggo2_d[l_ac2].bggo0221,
                    g_bggo2_d[l_ac2].bggo0231,g_bggo2_d[l_ac2].bggo0241,g_bggo2_d[l_ac2].bggo1001
                
               CALL abgt740_detail_desc2(l_ac2)
               FOR l_i = 1 TO g_max_period EXECUTE abgt740_b_fill2_pr4 
                  USING '20','1',g_bggo2_d[l_ac2].bggo007,g_bggo2_d[l_ac2].bggo0121,g_bggo2_d[l_ac2].bggo0131,
                           g_bggo2_d[l_ac2].bggo0141,g_bggo2_d[l_ac2].bggo0151,g_bggo2_d[l_ac2].bggo0161,
                           g_bggo2_d[l_ac2].bggo0171,g_bggo2_d[l_ac2].bggo0181,g_bggo2_d[l_ac2].bggo0191,
                           g_bggo2_d[l_ac2].bggo0201,g_bggo2_d[l_ac2].bggo0211,g_bggo2_d[l_ac2].bggo0221,
                           g_bggo2_d[l_ac2].bggo0231,g_bggo2_d[l_ac2].bggo0241,g_bggo2_d[l_ac2].bggo1001,
                           l_i
                  INTO l_amt
                  IF cl_null(l_amt) THEN LET l_amt = 0 END IF
                  CASE l_i                    
                     WHEN 1
                        LET g_bggo2_d[l_ac2].bggo1061 = l_amt
                        LET l_sum = l_sum + l_amt
                     WHEN 2
                        LET g_bggo2_d[l_ac2].bggo1062 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                     WHEN 3
                        LET g_bggo2_d[l_ac2].bggo1063 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                     WHEN 4
                        LET g_bggo2_d[l_ac2].bggo1064 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                     WHEN 5
                        LET g_bggo2_d[l_ac2].bggo1065 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                     WHEN 6
                        LET g_bggo2_d[l_ac2].bggo1066 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                     WHEN 7
                        LET g_bggo2_d[l_ac2].bggo1067 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                     WHEN 8
                        LET g_bggo2_d[l_ac2].bggo1068 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                     WHEN 9
                        LET g_bggo2_d[l_ac2].bggo1069 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                     WHEN 10
                        LET g_bggo2_d[l_ac2].bggo10610 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                     WHEN 11
                        LET g_bggo2_d[l_ac2].bggo10611 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                     WHEN 12
                        LET g_bggo2_d[l_ac2].bggo10612 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                     WHEN 13
                        LET g_bggo2_d[l_ac2].bggo10613 = l_amt 
                        LET l_sum = l_sum + l_amt                        
                  END CASE                  
               END FOR  
               LET g_bggo2_d[l_ac2].l_sum = l_sum
               LET l_sum = 0
               LET l_ac2 = l_ac2 +1                  
            END FOREACH
         ELSE                   
            FOREACH abgt740_b_fill2_cs3 USING l_ooed004  #不是最下层组织，抓取abgt740
               INTO g_bggo2_d[l_ac2].bggo007 ,g_bggo2_d[l_ac2].bggo0121,g_bggo2_d[l_ac2].bggo0131,
                    g_bggo2_d[l_ac2].bggo0141,g_bggo2_d[l_ac2].bggo0151,g_bggo2_d[l_ac2].bggo0161,
                    g_bggo2_d[l_ac2].bggo0171,g_bggo2_d[l_ac2].bggo0181,g_bggo2_d[l_ac2].bggo0191,
                    g_bggo2_d[l_ac2].bggo0201,g_bggo2_d[l_ac2].bggo0211,g_bggo2_d[l_ac2].bggo0221,
                    g_bggo2_d[l_ac2].bggo0231,g_bggo2_d[l_ac2].bggo0241,g_bggo2_d[l_ac2].bggo1001
               FOR l_i = 1 TO g_max_period EXECUTE abgt740_b_fill2_pr4 
                  USING '30','2',g_bggo2_d[l_ac2].bggo007,g_bggo2_d[l_ac2].bggo0121,g_bggo2_d[l_ac2].bggo0131,
                                 g_bggo2_d[l_ac2].bggo0141,g_bggo2_d[l_ac2].bggo0151,g_bggo2_d[l_ac2].bggo0161,
                                 g_bggo2_d[l_ac2].bggo0171,g_bggo2_d[l_ac2].bggo0181,g_bggo2_d[l_ac2].bggo0191,
                                 g_bggo2_d[l_ac2].bggo0201,g_bggo2_d[l_ac2].bggo0211,g_bggo2_d[l_ac2].bggo0221,
                                 g_bggo2_d[l_ac2].bggo0231,g_bggo2_d[l_ac2].bggo0241,g_bggo2_d[l_ac2].bggo1001,
                             l_i
                  INTO l_amt
                  IF cl_null(l_amt) THEN LET l_amt = 0 END IF
                  CALL abgt740_detail_desc2(l_ac2)
                  CASE l_i                    
                     WHEN 1
                        LET g_bggo2_d[l_ac2].bggo1061 = l_amt
                        LET l_sum = l_sum + l_amt
                     WHEN 2
                        LET g_bggo2_d[l_ac2].bggo1062 = l_amt 
                        LET l_sum = l_sum + l_amt                         
                     WHEN 3
                        LET g_bggo2_d[l_ac2].bggo1063 = l_amt 
                        LET l_sum = l_sum + l_amt                         
                     WHEN 4
                        LET g_bggo2_d[l_ac2].bggo1064 = l_amt 
                        LET l_sum = l_sum + l_amt                         
                     WHEN 5
                        LET g_bggo2_d[l_ac2].bggo1065 = l_amt 
                        LET l_sum = l_sum + l_amt                         
                     WHEN 6
                        LET g_bggo2_d[l_ac2].bggo1066 = l_amt 
                        LET l_sum = l_sum + l_amt                         
                     WHEN 7
                        LET g_bggo2_d[l_ac2].bggo1067 = l_amt 
                        LET l_sum = l_sum + l_amt                         
                     WHEN 8
                        LET g_bggo2_d[l_ac2].bggo1068 = l_amt 
                        LET l_sum = l_sum + l_amt                         
                     WHEN 9
                        LET g_bggo2_d[l_ac2].bggo1069 = l_amt 
                        LET l_sum = l_sum + l_amt                         
                     WHEN 10
                        LET g_bggo2_d[l_ac2].bggo10610 = l_amt 
                        LET l_sum = l_sum + l_amt                         
                     WHEN 11
                        LET g_bggo2_d[l_ac2].bggo10611 = l_amt 
                        LET l_sum = l_sum + l_amt                         
                     WHEN 12
                        LET g_bggo2_d[l_ac2].bggo10612 = l_amt 
                        LET l_sum = l_sum + l_amt                         
                     WHEN 13
                        LET g_bggo2_d[l_ac2].bggo10613 = l_amt 
                         LET l_sum = l_sum + l_amt                         
                  END CASE 
               END FOR  
               LET g_bggo2_d[l_ac2].l_sum = l_sum
               LET l_sum = 0
               LET l_ac2 = l_ac2 +1                  
            END FOREACH
         END IF
      END FOREACH  
   ELSE
      IF cl_null(l_ooed004) THEN LET l_ooed004 = g_bggo_m.bggo007 END IF
      FOREACH abgt740_b_fill2_cs2 USING l_ooed004
         INTO g_bggo2_d[l_ac2].bggo007 ,g_bggo2_d[l_ac2].bggo0121,g_bggo2_d[l_ac2].bggo0131,
              g_bggo2_d[l_ac2].bggo0141,g_bggo2_d[l_ac2].bggo0151,g_bggo2_d[l_ac2].bggo0161,
              g_bggo2_d[l_ac2].bggo0171,g_bggo2_d[l_ac2].bggo0181,g_bggo2_d[l_ac2].bggo0191,
              g_bggo2_d[l_ac2].bggo0201,g_bggo2_d[l_ac2].bggo0211,g_bggo2_d[l_ac2].bggo0221,
              g_bggo2_d[l_ac2].bggo0231,g_bggo2_d[l_ac2].bggo0241,g_bggo2_d[l_ac2].bggo1001
              
         FOR l_i = 1 TO g_max_period EXECUTE abgt740_b_fill2_pr4 
            USING '20','1',g_bggo2_d[l_ac2].bggo007,g_bggo2_d[l_ac2].bggo0121,g_bggo2_d[l_ac2].bggo0131,
                        g_bggo2_d[l_ac2].bggo0141,g_bggo2_d[l_ac2].bggo0151,g_bggo2_d[l_ac2].bggo0161,
                        g_bggo2_d[l_ac2].bggo0171,g_bggo2_d[l_ac2].bggo0181,g_bggo2_d[l_ac2].bggo0191,
                        g_bggo2_d[l_ac2].bggo0201,g_bggo2_d[l_ac2].bggo0211,g_bggo2_d[l_ac2].bggo0221,
                        g_bggo2_d[l_ac2].bggo0231,g_bggo2_d[l_ac2].bggo0241,g_bggo2_d[l_ac2].bggo1001,
                        l_i
            INTO l_amt
            IF cl_null(l_amt) THEN LET l_amt = 0 END IF
            CALL abgt740_detail_desc2(l_ac2)
            CASE l_i                    
               WHEN 1
                  LET g_bggo2_d[l_ac2].bggo1061 = l_amt
                  LET l_sum = l_sum + l_amt
               WHEN 2
                  LET g_bggo2_d[l_ac2].bggo1062 = l_amt 
                  LET l_sum = l_sum + l_amt                  
               WHEN 3
                  LET g_bggo2_d[l_ac2].bggo1063 = l_amt 
                  LET l_sum = l_sum + l_amt                  
               WHEN 4
                  LET g_bggo2_d[l_ac2].bggo1064 = l_amt 
                  LET l_sum = l_sum + l_amt                  
               WHEN 5
                  LET g_bggo2_d[l_ac2].bggo1065 = l_amt 
                  LET l_sum = l_sum + l_amt                  
               WHEN 6
                  LET g_bggo2_d[l_ac2].bggo1066 = l_amt 
                  LET l_sum = l_sum + l_amt                  
               WHEN 7
                  LET g_bggo2_d[l_ac2].bggo1067 = l_amt 
                  LET l_sum = l_sum + l_amt                  
               WHEN 8
                  LET g_bggo2_d[l_ac2].bggo1068 = l_amt 
                  LET l_sum = l_sum + l_amt                  
               WHEN 9
                  LET g_bggo2_d[l_ac2].bggo1069 = l_amt 
                  LET l_sum = l_sum + l_amt                  
               WHEN 10
                  LET g_bggo2_d[l_ac2].bggo10610 = l_amt 
                  LET l_sum = l_sum + l_amt                  
               WHEN 11
                  LET g_bggo2_d[l_ac2].bggo10611 = l_amt 
                  LET l_sum = l_sum + l_amt                  
               WHEN 12
                  LET g_bggo2_d[l_ac2].bggo10612 = l_amt 
                  LET l_sum = l_sum + l_amt                  
               WHEN 13
                  LET g_bggo2_d[l_ac2].bggo10613 = l_amt 
                  LET l_sum = l_sum + l_amt                  
            END CASE 
         END FOR  
         LET g_bggo2_d[l_ac2].l_sum = l_sum
         LET l_sum = 0
         LET l_ac2 = l_ac2 +1                  
      END FOREACH      
   END IF
   CALL g_bggo2_d.deleteElement(g_bggo2_d.getLength())
   LET l_ac2 = l_ac2 - 1
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION abgt740_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM bggo_t
    WHERE bggoent = g_enterprise AND bggo001 = g_bggo_m.bggo001 AND
                              bggo002 = g_bggo_m.bggo002 AND
                              bggo003 = g_bggo_m.bggo003 AND
                              bggo005 = g_bggo_m.bggo005 AND
                              bggo006 = g_bggo_m.bggo006 AND
                              bggo007 = g_bggo_m.bggo007 AND
 
          bggo008 = g_bggo_d_t.bggo008
      AND bggoseq = g_bggo_d_t.bggoseq
      AND bggoseq2 = g_bggo_d_t.bggoseq2
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bggo_t:",SQLERRMESSAGE 
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
 
{<section id="abgt740.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgt740_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="abgt740.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgt740_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="abgt740.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgt740_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="abgt740.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION abgt740_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_bggo_d[l_ac].bggo008 = g_bggo_d_t.bggo008 
      AND g_bggo_d[l_ac].bggoseq = g_bggo_d_t.bggoseq 
      AND g_bggo_d[l_ac].bggoseq2 = g_bggo_d_t.bggoseq2 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abgt740_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abgt740.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgt740_lock_b(ps_table,ps_page)
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
   #CALL abgt740_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt740.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgt740_unlock_b(ps_table,ps_page)
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
 
{<section id="abgt740.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgt740_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bggo001,bggo002,bggo003,bggo005,bggo006,bggo007",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
       CALL cl_set_comp_entry("bggo006",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt740.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgt740_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bggo001,bggo002,bggo003,bggo005,bggo006,bggo007",FALSE)
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
 
{<section id="abgt740.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgt740_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgt740_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abgt740_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange", TRUE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt740.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abgt740_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_bggo_m.bggostus NOT MATCHES "[NDR]" THEN   
      CALL cl_set_act_visible('modify,modify_detail,delete',FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt740.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abgt740_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt740.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abgt740_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt740.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgt740_default_search()
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
      LET ls_wc = ls_wc, " bggo001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bggo002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bggo003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " bggo005 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " bggo006 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " bggo007 = '", g_argv[06], "' AND "
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
 
{<section id="abgt740.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abgt740_fill_chk(ps_idx)
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
 
{<section id="abgt740.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION abgt740_modify_detail_chk(ps_record)
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
         LET ls_return = "bggoseq"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abgt740.mask_functions" >}
&include "erp/abg/abgt740_mask.4gl"
 
{</section>}
 
{<section id="abgt740.state_change" >}
    
 
{</section>}
 
{<section id="abgt740.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgt740_set_pk_array()
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
   LET g_pk_array[1].values = g_bggo_m.bggo001
   LET g_pk_array[1].column = 'bggo001'
   LET g_pk_array[2].values = g_bggo_m.bggo002
   LET g_pk_array[2].column = 'bggo002'
   LET g_pk_array[3].values = g_bggo_m.bggo003
   LET g_pk_array[3].column = 'bggo003'
   LET g_pk_array[4].values = g_bggo_m.bggo005
   LET g_pk_array[4].column = 'bggo005'
   LET g_pk_array[5].values = g_bggo_m.bggo006
   LET g_pk_array[5].column = 'bggo006'
   LET g_pk_array[6].values = g_bggo_m.bggo007
   LET g_pk_array[6].column = 'bggo007'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt740.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgt740_msgcentre_notify(lc_state)
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
   CALL abgt740_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bggo_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt740.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預算編號檢核
# Memo...........:
# Usage..........: CALL abgt740_bggo002_bggo003_chk(p_bggo002,p_bggo003)
# Input parameter: p_bggo002 預算編號
#                : p_bggo003 版本
# Date & Author..: 2016/12/12 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt740_bggo002_bggo003_chk(p_bggo002,p_bggo003)
DEFINE p_bggo002     LIKE bggo_t.bggo002  #預算編號
DEFINE p_bggo003     LIKE bggo_t.bggo003  #版本
DEFINE r_errno       LIKE gzze_t.gzze001
DEFINE r_success     LIKE type_t.num5
DEFINE l_cnt         LIKE type_t.num5

   LET r_errno = NULL LET r_success = TRUE LET l_cnt = 0
  
   IF NOT cl_null(p_bggo002)THEN       #單獨檢查預算編號
      SELECT COUNT(1) INTO l_cnt FROM bggo_t
       WHERE bggoent = g_enterprise
         AND bggo002 = p_bggo002
     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
     IF l_cnt = 0  THEN
        LET r_success = FALSE
        LET r_errno = g_errno
        RETURN r_success,r_errno
     END IF     
   END IF
   
   IF NOT cl_null(p_bggo002) AND NOT cl_null(p_bggo003) THEN      
      SELECT COUNT(1) INTO l_cnt FROM bggo_t
       WHERE bggoent = g_enterprise
         AND bggo002 = p_bggo002
         AND bggo003 = p_bggo003
     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
     IF l_cnt = 0  THEN
        LET r_success = FALSE
        LET r_errno = g_errno
        RETURN r_success,r_errno
     END IF     
   END IF

   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 根據樣表設定欄位隱顯
# Memo...........:
# Usage..........: CALL abgt740_set_bggo_visible()
# Date & Author..: 2016/12/12 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt740_set_bggo_visible()
DEFINE l_sql         STRING
DEFINE l_bgaw002 LIKE bgaw_t.bgaw002
DEFINE l_bgaw005 LIKE bgaw_t.bgaw005
DEFINE l_title STRING
   
   LET g_group = 'bggo039'
   LET l_title = ''
   CALL cl_set_comp_visible("bggo012_desc,bggo013_desc,bggo014_desc,bggo015_desc",FALSE)
   CALL cl_set_comp_visible("bggo0121_desc,bggo0131_desc,bggo0141_desc,bggo0151_desc",FALSE)
   CALL cl_set_comp_visible("bggo016_desc,bggo017_desc,bggo018_desc,bggo019_desc,bggo020_desc",FALSE)
   CALL cl_set_comp_visible("bggo0161_desc,bggo0171_desc,bggo0181_desc,bggo0191_desc,bggo0201_desc",FALSE)
   CALL cl_set_comp_visible("bggo021_desc,bggo022_desc,bggo023_desc,bggo024_desc",FALSE)
   CALL cl_set_comp_visible("bggo0211_desc,bggo0221_desc,bggo0231_desc,bggo0241_desc",FALSE)

   LET l_sql = " SELECT bgaw002,bgaw005                 ",
               "  FROM bgaw_t                           ",
               " WHERE bgawent = '",g_enterprise,"'     ",
               "   AND bgaw001 = '",g_bggo_m.bggo011,"' ",
               "   ORDER BY bgaw002                     "
   PREPARE abgt740_bgaw005_p FROM l_sql
   DECLARE abgt740_bgaw005_c CURSOR FOR abgt740_bgaw005_p
   FOREACH abgt740_bgaw005_c INTO l_bgaw002,l_bgaw005 
      CASE l_bgaw002 
         WHEN 1  #預算組織
         WHEN 2  #預算細項
         WHEN 3  #部門
            IF l_bgaw005 = 'Y' THEN 
              CALL cl_set_comp_visible("bggo013_desc,bggo0131_desc",TRUE) 
              LET g_group = g_group,",bggo013 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF
     
         WHEN 4  #利潤成本中心
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo014_desc,bggo0141_desc",TRUE) 
               LET g_group = g_group,",bggo014 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF         
         WHEN 5  #區域
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo015_desc,bggo0151_desc",TRUE) 
               LET g_group = g_group,",bggo015 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF   
         WHEN 6  #收付款客商
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo016_desc,bggo0161_desc",TRUE) 
               LET g_group = g_group,",bggo016 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF      
         WHEN 7 #帳款客戶
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo017_desc,bggo0171_desc",TRUE) 
               LET g_group = g_group,",bggo017 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF
         WHEN 8 #客群
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo018_desc,bggo0181_desc",TRUE) 
               LET g_group = g_group,",bggo018 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF            
         WHEN 9 #產品類別
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo019_desc,bggo0191_desc",TRUE) 
               LET g_group = g_group,",bggo019 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF   
         WHEN 10 #經營方式
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo022_desc,bggo0221_desc",TRUE) 
               LET g_group = g_group,",bggo022 "
             ELSE
               LET g_group = g_group,",' ' "
            END IF               
         WHEN 11 #通路
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo023_desc,bggo0231_desc",TRUE) 
                LET g_group = g_group,",bggo023 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF  
         WHEN 12 #品牌
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo024_desc,bggo0241_desc",TRUE) 
               LET g_group = g_group,",bggo024 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF             
         WHEN 13 #人員
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo012_desc,bggo0121_desc",TRUE) 
               
               LET g_group = g_group,",bggo012 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF              
         WHEN 14 #專案編號
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo020_desc,bggo0201_desc",TRUE) 
               LET g_group = g_group,",bggo020 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF  
         WHEN 15 #WBS
            IF l_bgaw005 = 'Y' THEN 
               CALL cl_set_comp_visible("bggo021_desc,bggo0211_desc",TRUE) 
               LET g_group = g_group,",bggo021 "
            ELSE
               LET g_group = g_group,",' ' "
            END IF                          
      END CASE
   END FOREACH   

END FUNCTION

################################################################################
# Descriptions...: 決定第二單身有哪些核算項需開啟
# Memo...........:
# Usage..........: CALL abgt740_set_bggo_visible2()
# Date & Author..: 2016/12/13 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt740_set_bggo_visible2()
DEFINE l_sql         STRING
DEFINE l_field       STRING
DEFINE l_ooef001_str STRING
DEFINE l_bggo011 LIKE bggo_t.bggo011
DEFINE l_bgaw005   LiKE bgaw_t.bgaw005 #使用否
DEFINE l_bgaw0021  LIKE bgaw_t.bgaw002
DEFINE l_bgaw002 RECORD
          flag3   LIKE type_t.chr1,
          flag4   LIKE type_t.chr1,
          flag5   LIKE type_t.chr1,
          flag6   LIKE type_t.chr1,
          flag7   LIKE type_t.chr1,
          flag8   LIKE type_t.chr1,
          flag9   LIKE type_t.chr1,
          flag10  LIKE type_t.chr1,
          flag11  LIKE type_t.chr1,
          flag12  LIKE type_t.chr1,
          flag13  LIKE type_t.chr1,
          flag14  LIKE type_t.chr1,
          flag15  LIKE type_t.chr1      
   END RECORD

   LET l_field = 'bggo017'
   CALL cl_set_comp_visible("bggo0121_desc,bggo0131_desc,bggo0141_desc,bggo0151_desc",FALSE)
   CALL cl_set_comp_visible("bggo0161_desc,bggo0171_desc,bggo0181_desc,bggo0191_desc,bggo0201_desc",FALSE)
   CALL cl_set_comp_visible("bggo0211_desc,bggo0221_desc,bggo0231_desc,bggo0241_desc",FALSE)
   LET l_bgaw002.flag3  = 'N'  LET l_bgaw002.flag4  = 'N' LET l_bgaw002.flag5  = 'N' LET l_bgaw002.flag6  = 'N'
   LET l_bgaw002.flag7  = 'N'  LET l_bgaw002.flag8  = 'N' LET l_bgaw002.flag9  = 'N' LET l_bgaw002.flag10 = 'N'
   LET l_bgaw002.flag11 = 'N'  LET l_bgaw002.flag12 = 'N' LET l_bgaw002.flag13 = 'N' LET l_bgaw002.flag14 = 'N'
   LET l_bgaw002.flag15 = 'N'
   CALL s_abg2_get_budget_site('','',g_user,'01') RETURNING l_ooef001_str
   CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
   LET l_sql = " SELECT bgaw002,bgaw005     ",
               "  FROM bgaw_t               ",
               " WHERE bgawent = '",g_enterprise,"' AND bgaw001 = ? ",
               " ORDER BY bgaw002                                   "
   PREPARE abgt740_bgaw_p FROM l_sql
   DECLARE abgt740_bgaw_c CURSOR FOR abgt740_bgaw_p

   #取得畫面上條件的樣表
   LET l_sql = " SELECT DISTINCT bggo011 FROM bggo_t     ",
               "  WHERE bggoent = ",g_enterprise,"       ",
               "    AND bggo002 = '",g_bggo_m.bggo002,"' ",
               "    AND bggo003 = '",g_bggo_m.bggo003,"' ",
               "    AND bggo001 = '20'                   ",
               "    AND bggo007 IN ",l_ooef001_str
   PREPARE abgt740_bggo011_p FROM l_sql
   DECLARE abgt740_bggo011_c CURSOR FOR abgt740_bggo011_p
   FOREACH abgt740_bggo011_c INTO l_bggo011
      FOREACH abgt740_bgaw_p USING l_bggo011 INTO l_bgaw0021,l_bgaw005 
         CASE l_bgaw0021 
            WHEN 1  #預算組織
            WHEN 2  #預算細項
            WHEN 3  #部門
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag3 = 'N'  THEN             
                 CALL cl_set_comp_visible("bggo0131_desc",TRUE)   
                 LET l_bgaw002.flag3 = 'Y'
                 LET l_field = l_field,",bggo013 " 
               ELSE 
                 LET l_field = l_field,",'' " 
               END IF
         
            WHEN 4  #利潤成本中心
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag4 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo0141_desc",TRUE) 
                  LET l_bgaw002.flag4 = 'Y'
                  LET l_field = l_field,",bggo014 "  
               ELSE 
                 LET l_field = l_field,",'' " 
               END IF         
            WHEN 5  #區域
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag5 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo0151_desc",TRUE) 
                   LET l_bgaw002.flag5 = 'Y'
                   LET l_field = l_field,",bggo015 "
               ELSE 
                 LET l_field = l_field,",'' " 
               END IF   
            WHEN 6  #收付款客商
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag6 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo0161_desc",TRUE) 
                  LET l_bgaw002.flag6 = 'Y'
                  LET l_field = l_field,",bggo016 "
              ELSE 
                 LET l_field = l_field,",'' " 
               END IF      
            WHEN 7 #帳款客戶
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag7 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo0171_desc",TRUE) 
                  LET l_bgaw002.flag7 = 'Y'
                  LET l_field = l_field,",bggo017 "
               ELSE 
                 LET l_field = l_field,",'' " 
               END IF
            WHEN 8 #客群
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag8 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo0181_desc",TRUE) 
                  LET l_bgaw002.flag8 = 'Y'
                  LET l_field = l_field,",bggo018 "
               ELSE 
                 LET l_field = l_field,",'' " 
               END IF            
            WHEN 9 #產品類別
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag9 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo0191_desc",TRUE) 
                  LET l_bgaw002.flag9 = 'Y'
                  LET l_field = l_field,",bggo019 "
              ELSE 
                 LET l_field = l_field,",'' " 
               END IF   
            WHEN 10 #經營方式
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag10 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo0221_desc",TRUE) 
                  LET l_bgaw002.flag10 = 'Y'
                  LET l_field = l_field,",bggo022 "
              ELSE 
                 LET l_field = l_field,",'' " 
               END IF               
            WHEN 11 #通路
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag11 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo0231_desc",TRUE) 
                  LET l_bgaw002.flag11 = 'Y'
                  LET l_field = l_field,",bggo023 "
              ELSE 
                 LET l_field = l_field,",'' " 
               END IF  
            WHEN 12 #品牌
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag12 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo0241_desc",TRUE) 
                  LET l_bgaw002.flag12 = 'Y'
                  LET l_field = l_field,",bggo024 "
               ELSE 
                 LET l_field = l_field,",'' " 
               END IF             
            WHEN 13 #人員
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag13 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo0121_desc",TRUE) 
                  LET l_bgaw002.flag13 = 'Y'
                  LET l_field = l_field,",bggo012 "
               ELSE 
                 LET l_field = l_field,",'' " 
               END IF              
            WHEN 14 #專案編號
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag14 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo020_desc",TRUE) 
                  LET l_bgaw002.flag14 = 'Y'
                  LET l_field = l_field,",bggo020 "
               END IF  
            WHEN 15 #WBS
               IF l_bgaw005 = 'Y' AND l_bgaw002.flag15 = 'N' THEN 
                  CALL cl_set_comp_visible("bggo021_desc",TRUE) 
                  LET l_bgaw002.flag15 = 'Y'
                  LET l_field = l_field,",bggo021 "
               ELSE 
                 LET l_field = l_field,",'' " 
               END IF                          
         END CASE      
      END FOREACH         
   END FOREACH

   RETURN l_field   


END FUNCTION

################################################################################
# Descriptions...: 依單頭條件自動產生單身
# Memo...........:
# Usage..........: CALL abgt740_auto_ins_detail()
# Date & Author..: 2016/12/14 By 05016
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt740_auto_ins_detail()
   DEFINE l_dnstep_str STRING
   DEFINE l_bggo RECORD  #人工費用預算明細檔
       bggoent LIKE bggo_t.bggoent, #企業編號
       bggo001 LIKE bggo_t.bggo001, #來源作業
       bggo002 LIKE bggo_t.bggo002, #預算編號
       bggo003 LIKE bggo_t.bggo003, #版本
       bggo004 LIKE bggo_t.bggo004, #管理組織
       bggo005 LIKE bggo_t.bggo005, #人工來源
       bggo006 LIKE bggo_t.bggo006, #資料來源
       bggo007 LIKE bggo_t.bggo007, #預算組織
       bggo008 LIKE bggo_t.bggo008, #期別
       bggoseq LIKE bggo_t.bggoseq, #項次
       bggoseq2 LIKE bggo_t.bggoseq2, #項序
       bggo009 LIKE bggo_t.bggo009, #工資項目
       bggo010 LIKE bggo_t.bggo010, #組合 key
       bggo011 LIKE bggo_t.bggo011, #預算樣表
       bggo012 LIKE bggo_t.bggo012, #人員
       bggo013 LIKE bggo_t.bggo013, #部門
       bggo014 LIKE bggo_t.bggo014, #成本利潤中心
       bggo015 LIKE bggo_t.bggo015, #區域
       bggo016 LIKE bggo_t.bggo016, #收付款供應商
       bggo017 LIKE bggo_t.bggo017, #帳款客商
       bggo018 LIKE bggo_t.bggo018, #客群
       bggo019 LIKE bggo_t.bggo019, #產品類別
       bggo020 LIKE bggo_t.bggo020, #專案編號
       bggo021 LIKE bggo_t.bggo021, #WBS
       bggo022 LIKE bggo_t.bggo022, #經營方式
       bggo023 LIKE bggo_t.bggo023, #通路
       bggo024 LIKE bggo_t.bggo024, #品牌
       bggo025 LIKE bggo_t.bggo025, #自由核算項一
       bggo026 LIKE bggo_t.bggo026, #自由核算項二
       bggo027 LIKE bggo_t.bggo027, #自由核算項三
       bggo028 LIKE bggo_t.bggo028, #自由核算項四
       bggo029 LIKE bggo_t.bggo029, #自由核算項五
       bggo030 LIKE bggo_t.bggo030, #自由核算項六
       bggo031 LIKE bggo_t.bggo031, #自由核算項七
       bggo032 LIKE bggo_t.bggo032, #自由核算項八
       bggo033 LIKE bggo_t.bggo033, #自由核算項九
       bggo034 LIKE bggo_t.bggo034, #自由核算項十
       bggo035 LIKE bggo_t.bggo035, #用工人數
       bggo036 LIKE bggo_t.bggo036, #薪資基準
       bggo037 LIKE bggo_t.bggo037, #上層組織
       bggo038 LIKE bggo_t.bggo038, #憑證單號
       bggo039 LIKE bggo_t.bggo039, #借方預算細項
       bggo040 LIKE bggo_t.bggo040, #貸方預算細項
       bggo041 LIKE bggo_t.bggo041, #工資方案
       bggo042 LIKE bggo_t.bggo042, #職級
       bggo043 LIKE bggo_t.bggo043, #職等
       bggo044 LIKE bggo_t.bggo044, #用工屬性
       bggo100 LIKE bggo_t.bggo100, #幣別
       bggo101 LIKE bggo_t.bggo101, #匯率
       bggo103 LIKE bggo_t.bggo103, #預算金額
       bggo104 LIKE bggo_t.bggo104, #本層調整金額
       bggo105 LIKE bggo_t.bggo105, #上層調整金額
       bggo106 LIKE bggo_t.bggo106, #核准金額
       bggostus LIKE bggo_t.bggostus #狀態碼   
END RECORD

DEFINE l_sql       STRING
DEFINE l_bggo039   LIKE bggo_t.bggo039
DEFINE l_count     LIKE type_t.num10
DEFINE r_success   LIKE type_t.num5
DEFINE l_seq       LIKE bggo_t.bggoseq
DEFINE l_bggo008   LIKE bggo_t.bggo008
DEFINE l_dnstep_wc STRING
DEFINE l_i         LIKE type_t.num5 
DEFINE l_bgaa010      LIKE bgaa_t.bgaa010
DEFINE l_bgaa011      LIKE bgaa_t.bgaa011

   WHENEVER ERROR CONTINUE   
   SELECT DISTINCT bgai008 INTO l_bggo.bggo011 FROM bgai_t
    WHERE bgaient=g_enterprise AND bgai001=g_bggo_m.bggo002 AND bgai002=g_bggo_m.bggo004
   
   
   LET r_success = TRUE LET l_seq = 0
   #1.先取得組織範圍:自己bggo004+自己的下層l_dnstep_str
   LET l_dnstep_str = NULL
   CALL s_abgt026_get_dnstep_site(g_bggo_m.bggo002,'','',g_bggo_m.bggo007)
      RETURNING l_dnstep_str
   IF cl_null(l_dnstep_str)THEN LET l_dnstep_str = g_bggo_m.bggo007 END IF
   CALL s_fin_get_wc_str(l_dnstep_str) RETURNING l_dnstep_wc
  
  #上层组织
   SELECT bgaa011,bgaa010 INTO l_bgaa011,l_bgaa010 FROM bgaa_t 
    WHERE bgaaent=g_enterprise AND bgaa001=g_bggo_m.bggo002
   IF NOT cl_null(l_bgaa011) THEN
      LET l_bggo.bggo037 = l_bgaa011
   ELSE
      SELECT ooed005 INTO l_bggo.bggo037 FROM ooed_t
       WHERE ooedent=g_enterprise AND ooed001='4'
         AND ooed002=l_bgaa011 AND ooed003=l_bgaa010
         AND ooed004= g_bggo_m.bggo007
      IF cl_null(l_bggo.bggo037) THEN
         LET l_bggo.bggo037 = g_bggo_m.bggo007
      END IF
   END IF
   
   LET l_bggo.bggoseq = 0
   
   LET l_sql = " SELECT DISTINCT ",g_group
   LET l_sql = l_sql,",bggo100,bggo101                         ",
              " FROM bggo_t WHERE bggoent = '",g_enterprise,"' ",
              "  AND bggo001 = '20' ",
              "  AND bggo002 = '",g_bggo_m.bggo002,"'          ",
              "  AND bggo003 = '",g_bggo_m.bggo003,"'          ",
              "  AND bggo006 = '1'                             ",
              "  AND bggo007 IN ",l_dnstep_wc,
              " ORDER BY ",g_group,",bggo100,bggo101           "
   PREPARE abgt740_bggo_ins_p FROM l_sql
   DECLARE abgt740_bggo_ins_c CURSOR FROM l_sql
   FOREACH abgt740_bggo_ins_c INTO l_bggo.bggo039,l_bggo.bggo013,l_bggo.bggo014,l_bggo.bggo015,l_bggo.bggo016,
                                   l_bggo.bggo017,l_bggo.bggo018,l_bggo.bggo019,l_bggo.bggo022,l_bggo.bggo023,
                                   l_bggo.bggo024,l_bggo.bggo012,l_bggo.bggo020,l_bggo.bggo021,l_bggo.bggo100,
                                   l_bggo.bggo101,l_bggo.bggo106
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH: abgt740_bggo_ins_c ",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF         
      LET l_sql = " SELECT SUM(bggo103),SUM(bggo106) FROM bggo_t          ",
                  "  WHERE bggoent = '",g_enterprise,"'      ",
                  "    AND bggo001 = '20' ",
                  "    AND bggo002 = '",g_bggo_m.bggo002,"'  ",
                  "    AND bggo003 = '",g_bggo_m.bggo003,"'  ",
                  "    AND bggo100 = '",l_bggo.bggo100,"'    ",
                  "    AND bggo039 = ?   AND bggo008 = ?     "
      IF NOT cl_null(l_bggo.bggo013) THEN LET l_sql = l_sql," AND bggo013 = '",l_bggo.bggo013,"' " END IF
      IF NOT cl_null(l_bggo.bggo014) THEN LET l_sql = l_sql," AND bggo014 = '",l_bggo.bggo014,"' " END IF
      IF NOT cl_null(l_bggo.bggo015) THEN LET l_sql = l_sql," AND bggo015 = '",l_bggo.bggo015,"' " END IF
      IF NOT cl_null(l_bggo.bggo016) THEN LET l_sql = l_sql," AND bggo016 = '",l_bggo.bggo016,"' " END IF              
      IF NOT cl_null(l_bggo.bggo017) THEN LET l_sql = l_sql," AND bggo017 = '",l_bggo.bggo017,"' " END IF
      IF NOT cl_null(l_bggo.bggo018) THEN LET l_sql = l_sql," AND bggo018 = '",l_bggo.bggo018,"' " END IF
      IF NOT cl_null(l_bggo.bggo019) THEN LET l_sql = l_sql," AND bggo019 = '",l_bggo.bggo019,"' " END IF
      IF NOT cl_null(l_bggo.bggo022) THEN LET l_sql = l_sql," AND bggo022 = '",l_bggo.bggo022,"' " END IF
      IF NOT cl_null(l_bggo.bggo023) THEN LET l_sql = l_sql," AND bggo023 = '",l_bggo.bggo023,"' " END IF
      IF NOT cl_null(l_bggo.bggo024) THEN LET l_sql = l_sql," AND bggo024 = '",l_bggo.bggo024,"' " END IF
      IF NOT cl_null(l_bggo.bggo012) THEN LET l_sql = l_sql," AND bggo012 = '",l_bggo.bggo012,"' " END IF
      IF NOT cl_null(l_bggo.bggo020) THEN LET l_sql = l_sql," AND bggo020 = '",l_bggo.bggo020,"' " END IF              
      IF NOT cl_null(l_bggo.bggo021) THEN LET l_sql = l_sql," AND bggo021 = '",l_bggo.bggo021,"' " END IF 
      PREPARE abgt740_bggo106_sum FROM l_sql            
      
      LET l_bggo.bggoseq = l_bggo.bggoseq + 1      
      FOR l_i = 1 TO g_max_period
         LET l_bggo.bggo103 = 0
         LET l_bggo.bggo106 = 0  
         EXECUTE abgt740_bggo106_sum USING l_bggo.bggo039,l_i 

         INTO l_bggo.bggo103,l_bggo.bggo106
         IF cl_null(l_bggo.bggo106) THEN LET l_bggo.bggo106 = 0 END IF
         
         INSERT INTO bggo_t
                    (bggoent,bggo001,bggo002,bggo003,bggo004,bggo005,
                     bggo006,bggo007,bggo008,bggoseq,bggoseq2,
                     bggo012,bggo013,bggo014,bggo015,bggo016,
                     bggo017,bggo018,bggo019,bggo020,bggo021,
                     bggo022,bggo023,bggo024,bggo025,bggo026,
                     bggo027,bggo028,bggo029,bggo030,bggo031,
                     bggo032,bggo033,bggo034,bggo039,bggo100,
                     bggo101,bggo106,bggostus,bggo011,bggo037,
                     bggo040,bggo103)
         VALUES (g_enterprise  ,'30'          ,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,'1',
                 '2'           ,g_bggo_m.bggo007,l_i           ,l_bggo.bggoseq  ,'0'           ,
                 l_bggo.bggo012,l_bggo.bggo013  ,l_bggo.bggo014,l_bggo.bggo015  ,l_bggo.bggo016,
                 l_bggo.bggo017,l_bggo.bggo018  ,l_bggo.bggo019,l_bggo.bggo020  ,l_bggo.bggo021,
                 l_bggo.bggo022,l_bggo.bggo023  ,l_bggo.bggo024,' '             ,' '           ,
                 ' '           ,' '             ,' '           ,' '             ,' '           ,
                 ' '           ,' '             ,' '           ,l_bggo.bggo039  ,l_bggo.bggo100,
                 l_bggo.bggo101,l_bggo.bggo106  ,'N'           ,l_bggo.bggo011  ,l_bggo.bggo037,
                 ' '           ,l_bggo.bggo103)                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins bggo",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END FOR
   END FOREACH
   RETURN r_success
     
END FUNCTION

################################################################################
# Descriptions...: 取得期別和金額
# Memo...........:
# Usage..........: CALL abgt740_get_num_and_price()
# Date & Author..: 2016/12/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt740_get_num_and_price()
DEFINE l_sql          STRING
DEFINE l_bggo008      LIKE bggo_t.bggo008
DEFINE l_bggo106      LIKE bggo_t.bggo106
DEFINE l_sum          LIKE bggo_t.bggo106
   
   IF l_ac < 1 THEN
      RETURN
   END IF
   LET l_sum = 0
   LET l_sql = "  SELECT bggo008,bggo106 FROM bggo_t      ",
               "  WHERE bggoent = '",g_enterprise,"'     ",
               "    AND bggo002 = '",g_bggo_m.bggo002,"' AND bggo003 = '",g_bggo_m.bggo003,"' ",
               "    AND bggo004 = '",g_bggo_m.bggo004,"' AND bggo007 = '",g_bggo_m.bggo007,"' ",
               "    AND bggo001 = '30'   AND bggoseq = '",g_bggo_d[l_ac].bggoseq,"'  "
   PREPARE abgt740_sel_amt_pr FROM l_sql              
   DECLARE abgt740_sel_amt_cs CURSOR FOR abgt740_sel_amt_pr   
   FOREACH abgt740_sel_amt_cs INTO l_bggo008,l_bggo106
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF      
      CASE l_bggo008
         WHEN 1
            LET g_bggo_d[l_ac].bggo106 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 2
            LET g_bggo_d[l_ac].bggo1062 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 3
            LET g_bggo_d[l_ac].bggo1063 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 4
            LET g_bggo_d[l_ac].bggo1064 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 5
            LET g_bggo_d[l_ac].bggo1065 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 6
            LET g_bggo_d[l_ac].bggo1066 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 7
            LET g_bggo_d[l_ac].bggo1067 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 8
            LET g_bggo_d[l_ac].bggo1068 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 9
            LET g_bggo_d[l_ac].bggo1069 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 10
            LET g_bggo_d[l_ac].bggo10610 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 11
            LET g_bggo_d[l_ac].bggo10611 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 12
            LET g_bggo_d[l_ac].bggo10612 = l_bggo106
            LET l_sum = l_sum + l_bggo106
         WHEN 13
            LET g_bggo_d[l_ac].bggo10613 = l_bggo106
            LET l_sum = l_sum + l_bggo106
      END CASE   
   END FOREACH
   LET g_bggo_d[l_ac].l_sum = l_sum

END FUNCTION

################################################################################
# Descriptions...: 單身說明
# Memo...........:
# Usage..........: CALL abgt740_detail_desc()
# Date & Author..: 2016/12/16 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt740_detail_desc()
   
   
   #部門
   CALL s_desc_get_department_desc(g_bggo_d[l_ac].bggo013) RETURNING g_bggo_d[l_ac].bggo013_desc
   LET g_bggo_d[l_ac].bggo013_desc=g_bggo_d[l_ac].bggo013,"  ",g_bggo_d[l_ac].bggo013_desc
   #成本利潤中心
   CALL s_desc_get_department_desc(g_bggo_d[l_ac].bggo014) RETURNING g_bggo_d[l_ac].bggo014_desc
   LET g_bggo_d[l_ac].bggo014_desc=g_bggo_d[l_ac].bggo014,"  ",g_bggo_d[l_ac].bggo014_desc   
   #区域
   CALL s_desc_get_acc_desc('287',g_bggo_d[l_ac].bggo015) RETURNING g_bggo_d[l_ac].bggo015_desc
   LET g_bggo_d[l_ac].bggo015_desc=g_bggo_d[l_ac].bggo015,"  ",g_bggo_d[l_ac].bggo015_desc
   #收付款客商
   CALL s_desc_get_bgap001_desc(g_bggo_d[l_ac].bggo016) RETURNING g_bggo_d[l_ac].bggo016_desc
   LET g_bggo_d[l_ac].bggo016_desc=g_bggo_d[l_ac].bggo016,"  ",g_bggo_d[l_ac].bggo016_desc
   #账款客商
   CALL s_desc_get_bgap001_desc(g_bggo_d[l_ac].bggo017) RETURNING g_bggo_d[l_ac].bggo017_desc
   LET g_bggo_d[l_ac].bggo017_desc=g_bggo_d[l_ac].bggo017,"  ",g_bggo_d[l_ac].bggo017_desc
   #客群
   CALL s_desc_get_acc_desc('281',g_bggo_d[l_ac].bggo018) RETURNING g_bggo_d[l_ac].bggo018_desc
   LET g_bggo_d[l_ac].bggo018_desc=g_bggo_d[l_ac].bggo018,"  ",g_bggo_d[l_ac].bggo018_desc
   #产品类别
   CALL s_desc_get_rtaxl003_desc(g_bggo_d[l_ac].bggo019) RETURNING g_bggo_d[l_ac].bggo019_desc
   LET g_bggo_d[l_ac].bggo019_desc=g_bggo_d[l_ac].bggo019,"  ",g_bggo_d[l_ac].bggo019_desc
   #通路
   CALL s_desc_get_oojdl003_desc(g_bggo_d[l_ac].bggo023) RETURNING g_bggo_d[l_ac].bggo023_desc
   LET g_bggo_d[l_ac].bggo023_desc=g_bggo_d[l_ac].bggo023,"  ",g_bggo_d[l_ac].bggo023_desc
   #品牌
   CALL s_desc_get_acc_desc('2002',g_bggo_d[l_ac].bggo024) RETURNING g_bggo_d[l_ac].bggo024_desc
   LET g_bggo_d[l_ac].bggo024_desc=g_bggo_d[l_ac].bggo024,"  ",g_bggo_d[l_ac].bggo024_desc
   #人员
   CALL s_desc_get_person_desc(g_bggo_d[l_ac].bggo012) RETURNING g_bggo_d[l_ac].bggo012_desc
   LET g_bggo_d[l_ac].bggo012_desc=g_bggo_d[l_ac].bggo012,"  ",g_bggo_d[l_ac].bggo012_desc
   #专案
   CALL s_desc_get_oojdl003_desc(g_bggo_d[l_ac].bggo020) RETURNING g_bggo_d[l_ac].bggo020_desc
   LET g_bggo_d[l_ac].bggo020_desc=g_bggo_d[l_ac].bggo020,"  ",g_bggo_d[l_ac].bggo020_desc
   #WBS
   CALL s_desc_get_wbs_desc(g_bggo_d[l_ac].bggo020,g_bggo_d[l_ac].bggo021) RETURNING g_bggo_d[l_ac].bggo021_desc
   LET g_bggo_d[l_ac].bggo021_desc=g_bggo_d[l_ac].bggo021,"  ",g_bggo_d[l_ac].bggo021_desc

END FUNCTION

################################################################################
# Descriptions...: 單身說明2
# Memo...........:
# Usage..........: CALL abgt740_detail_desc2()
# Date & Author..: 2016/12/19 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt740_detail_desc2(p_ac)
DEFINE p_ac LIKE type_t.num5  
   #部門
   CALL s_desc_get_department_desc(g_bggo2_d[p_ac].bggo0131) RETURNING g_bggo2_d[p_ac].bggo0131_desc
   LET g_bggo2_d[p_ac].bggo0131_desc=g_bggo2_d[p_ac].bggo0131,"  ",g_bggo2_d[p_ac].bggo0131_desc
   #成本利潤中心
   CALL s_desc_get_department_desc(g_bggo2_d[p_ac].bggo0141) RETURNING g_bggo2_d[p_ac].bggo0141_desc
   LET g_bggo2_d[p_ac].bggo0141_desc=g_bggo2_d[p_ac].bggo0141,"  ",g_bggo2_d[p_ac].bggo0141_desc   
   #区域
   CALL s_desc_get_acc_desc('287',g_bggo2_d[p_ac].bggo0151) RETURNING g_bggo2_d[p_ac].bggo0151_desc
   LET g_bggo2_d[p_ac].bggo0151_desc=g_bggo2_d[p_ac].bggo0151,"  ",g_bggo2_d[p_ac].bggo0151_desc
   #收付款客商
   CALL s_desc_get_bgap001_desc(g_bggo2_d[p_ac].bggo0161) RETURNING g_bggo2_d[p_ac].bggo0161_desc
   LET g_bggo2_d[p_ac].bggo0161_desc=g_bggo2_d[p_ac].bggo0161,"  ",g_bggo2_d[p_ac].bggo0161_desc
   #账款客商
   CALL s_desc_get_bgap001_desc(g_bggo2_d[p_ac].bggo0171) RETURNING g_bggo2_d[p_ac].bggo0171_desc
   LET g_bggo2_d[p_ac].bggo0171_desc=g_bggo2_d[p_ac].bggo0171,"  ",g_bggo2_d[p_ac].bggo0171_desc
   #客群
   CALL s_desc_get_acc_desc('281',g_bggo2_d[p_ac].bggo0181) RETURNING g_bggo2_d[p_ac].bggo0181_desc
   LET g_bggo2_d[p_ac].bggo0181_desc=g_bggo2_d[p_ac].bggo0181,"  ",g_bggo2_d[p_ac].bggo0181_desc
   #产品类别
   CALL s_desc_get_rtaxl003_desc(g_bggo2_d[p_ac].bggo0191) RETURNING g_bggo2_d[p_ac].bggo0191_desc
   LET g_bggo2_d[p_ac].bggo0191_desc=g_bggo2_d[p_ac].bggo0191,"  ",g_bggo2_d[p_ac].bggo0191_desc
   #通路
   CALL s_desc_get_oojdl003_desc(g_bggo2_d[p_ac].bggo0231) RETURNING g_bggo2_d[p_ac].bggo0231_desc
   LET g_bggo2_d[p_ac].bggo0231_desc=g_bggo2_d[p_ac].bggo0231,"  ",g_bggo2_d[p_ac].bggo0231_desc
   #品牌
   CALL s_desc_get_acc_desc('2002',g_bggo2_d[p_ac].bggo0241) RETURNING g_bggo2_d[p_ac].bggo0241_desc
   LET g_bggo2_d[p_ac].bggo0241_desc=g_bggo2_d[p_ac].bggo0241,"  ",g_bggo2_d[p_ac].bggo0241_desc
   #人员
   CALL s_desc_get_person_desc(g_bggo2_d[p_ac].bggo0121) RETURNING g_bggo2_d[p_ac].bggo0121_desc
   LET g_bggo2_d[p_ac].bggo0121_desc=g_bggo2_d[p_ac].bggo0121,"  ",g_bggo2_d[p_ac].bggo0121_desc
   #专案
   CALL s_desc_get_oojdl003_desc(g_bggo2_d[p_ac].bggo0201) RETURNING g_bggo2_d[p_ac].bggo0201_desc
   LET g_bggo2_d[p_ac].bggo0201_desc=g_bggo2_d[p_ac].bggo0201,"  ",g_bggo2_d[p_ac].bggo0201_desc
   #WBS
   CALL s_desc_get_wbs_desc(g_bggo2_d[p_ac].bggo0201,g_bggo2_d[p_ac].bggo0211) RETURNING g_bggo2_d[p_ac].bggo0211_desc
   LET g_bggo2_d[p_ac].bggo0211_desc=g_bggo2_d[p_ac].bggo0211,"  ",g_bggo2_d[p_ac].bggo0211_desc

END FUNCTION

################################################################################
# Descriptions...: 狀態變更
# Memo...........:
# Usage..........: CALL abgt740_statechange()
# Date & Author..: 2016/12/19 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt740_statechange()
 DEFINE lc_state LIKE type_t.chr5
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_bgaa011    LIKE bgaa_t.bgaa011
   
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bggo_m.bggo001 IS NULL
   OR g_bggo_m.bggo002 IS NULL
   OR g_bggo_m.bggo003 IS NULL
   OR g_bggo_m.bggo004 IS NULL
   OR g_bggo_m.bggo005 IS NULL
   OR g_bggo_m.bggo006 IS NULL
   OR g_bggo_m.bggo007 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN abgt740_cl USING g_enterprise,g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007
   
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt740_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE abgt740_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt740_master_referesh USING g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo005, 
       g_bggo_m.bggo006,g_bggo_m.bggo007 INTO g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005, 
       g_bggo_m.bggo001,g_bggo_m.bggo011,g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus
   
   DISPLAY BY NAME  g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005, 
       g_bggo_m.bggo001,g_bggo_m.bggo011,g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus
 
   CASE g_bggo_m.bggostus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "FC"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   IF g_bggo_m.bggostus = 'X' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00044'
      LET g_errparam.extend = g_bggo_m.bggo002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE abgt740_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #最上層組織才可使用終審功能
   LET l_bgaa011 = NULL
   SELECT bgaa011 INTO l_bgaa011 FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_bggo_m.bggo002
   IF g_bggo_m.bggo007 <> l_bgaa011 AND g_bggo_m.bggostus = 'FC' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'abg-00020'
      LET g_errparam.extend = g_bggo_m.bggo002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE abgt740_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bggo_m.bggostus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "FC"
               HIDE OPTION "final_confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"

      CALL cl_set_act_visible("signing,withdraw",FALSE) 
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed,final_confirmed,unfinal_confirmed",TRUE) 
      CASE g_bggo_m.bggostus
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unfinal_confirmed",FALSE)
            IF l_bgaa011 <> g_bggo_m.bggo007 THEN
               CALL cl_set_act_visible("final_confirmed",FALSE)
            END IF
            
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,final_confirmed,unfinal_confirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "FC"
            CALL cl_set_act_visible("invalid,final_confirmed,confirmed,unconfirmed",FALSE)            
            IF l_bgaa011 <> g_bggo_m.bggo007 THEN
               CALL cl_set_act_visible("unfinal_confirmed",FALSE)
            END IF
         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"
            CALL cl_set_act_visible("confirmed ",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,unfinal_confirmed",FALSE)
         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed,unfinal_confirmed",FALSE)
         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed,unfinal_confirmed",FALSE)
         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,unfinal_confirmed",FALSE)
      END CASE
     
      LET l_success=TRUE 
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT abgt740_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abgt740_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT abgt740_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE abgt740_cl
            RETURN
         END IF
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            CALL cl_err_collect_init()
            #取消审核检查
            CALL s_abgt740_unconfirm_chk(g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,
                                         g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007) 
            RETURNING l_success
            #end add-point
         END IF
         EXIT MENU
         
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #审核
            CALL cl_err_collect_init()
            IF l_success = TRUE THEN
               CALL s_abgt740_confirm_chk(g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,
                                          g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007,g_bggo_m.bggostus) 
               RETURNING g_sub_success
            END IF
            #end add-point
         END IF
         EXIT MENU
         
      ON ACTION final_confirmed
         IF cl_auth_chk_act("final_confirmed") THEN
            LET lc_state = "FC"
            #add-point:action控制 name="statechange.final_confirmed"
            CALL cl_err_collect_init()
            #终审检查
            CALL s_abgt740_final_confirm_chk(g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,
                                             g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007) 
            RETURNING l_success
            #更新该组织tree 所有组织的状态为终审FC
            IF l_success = TRUE THEN
               CALL s_abgt740_final_update_stus(g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,
                                                g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007,lc_state)
               RETURNING l_success
            END IF
            #end add-point
         END IF
         EXIT MENU
      
      ON ACTION unfinal_confirmed
         IF cl_auth_chk_act("unfinal_confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.final_confirmed"
            CALL cl_err_collect_init()
            #取消终审检查
            CALL s_abgt740_unfinal_confirm_chk(g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,
                                               g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007) 
            RETURNING l_success
            #更新该组织tree 所有组织的状态为审核Y
            IF l_success = TRUE THEN
               CALL s_abgt740_final_update_stus(g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,
                                                g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007,lc_state)
               RETURNING l_success
            END IF
            #end add-point
         END IF
         EXIT MENU
         
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"

            #end add-point
         END IF
         EXIT MENU
      
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"

            #end add-point
         END IF
         EXIT MENU
      
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
                     
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "FC"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_bggo_m.bggostus = lc_state OR cl_null(lc_state) THEN
      CLOSE abgt740_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #判断执行结果，当失败时，回滚数据库
   CALL cl_err_collect_show()
   IF l_success = FALSE  THEN
      CALL s_transaction_end('N','0')
      CLOSE abgt740_cl
      RETURN
   END IF
   #end add-point
   
   LET g_bggo_m.bggostus = lc_state
   
   #異動狀態碼欄位
   UPDATE bggo_t 
      SET (bggostus) 
        = (g_bggo_m.bggostus)
    WHERE bggoent = g_enterprise
      AND bggo001 = g_bggo_m.bggo001
      AND bggo002 = g_bggo_m.bggo002 
      AND bggo003 = g_bggo_m.bggo003 
      AND bggo004 = g_bggo_m.bggo004 
      AND bggo005 = g_bggo_m.bggo005 
      AND bggo006 = g_bggo_m.bggo006
      AND bggo007 = g_bggo_m.bggo007
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,g_bggo_m.bggo005, 
                      g_bggo_m.bggo001,g_bggo_m.bggo011,g_bggo_m.bggo007,g_bggo_m.bggo006,g_bggo_m.bggostus

   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE abgt740_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt740_msgcentre_notify('statechange:'||lc_state)
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL abgt740_draw_out()
# Date & Author..: 2016/12/19 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt740_draw_out()
 #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL abgt740_ui_headershow()  
   CALL abgt740_ui_detailshow()
 
 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: BPM提交
# Memo...........:
# Usage..........: CALL abgt740_send()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/20 By 05016
# Modify.........: 
################################################################################
PRIVATE FUNCTION abgt740_send()
 DEFINE l_success    LIKE type_t.num5
   DEFINE l_success1   LIKE type_t.num5
   
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
  
   CALL abgt740_set_pk_array()
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_bggo_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_bggo_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   #確認前檢核段 
   CALL cl_err_collect_init()
   #审核检查
   IF l_success = TRUE THEN
      CALL s_abgt740_confirm_chk(g_bggo_m.bggo001,g_bggo_m.bggo002,g_bggo_m.bggo003,g_bggo_m.bggo004,
                                 g_bggo_m.bggo005,g_bggo_m.bggo006,g_bggo_m.bggo007,g_bggo_m.bggostus) 
      RETURNING l_success
   END IF
   
   CALL cl_err_collect_show()
   IF l_success = FALSE THEN
      RETURN FALSE
   END IF
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL abgt740_ui_headershow()
   CALL abgt740_ui_detailshow()
 
   RETURN TRUE
END FUNCTION

 
{</section>}
 
