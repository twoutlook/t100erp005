#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt027.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-06-22 09:22:34), PR版次:0007(2016-11-09 15:19:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: abgt027
#+ Description: 年度預算項目維護作業
#+ Creator....: 04152(2016-06-07 15:52:55)
#+ Modifier...: 04152 -SD/PR- 08729
 
{</section>}
 
{<section id="abgt027.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160818-00017#3  2016/08/24   By 07900     删除修改未重新判断状态码
#160905-00002#2  2016/09/05   By Hans      SQL無ENT補上
#160920-00019#3  2016/09/20   By 08732     交易對象開窗調整為q_pmaa001_25
#161006-00005#11 2016/10/26   By 08732     組織類型與職能開窗調整
#160822-00012#3  2016/10/31   By 08729     新舊值調整
#161104-00024#8  2016/11/09   By 08171     程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義(包含INSERT)
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
PRIVATE type type_g_bgbi_m        RECORD
       bgbi002 LIKE bgbi_t.bgbi002, 
   bgbi002_desc LIKE type_t.chr80, 
   bgbi003 LIKE bgbi_t.bgbi003, 
   bgbi045 LIKE bgbi_t.bgbi045, 
   bgbi045_desc LIKE type_t.chr80, 
   bgbi004 LIKE bgbi_t.bgbi004, 
   bgbi004_desc LIKE type_t.chr80, 
   bgbi005 LIKE bgbi_t.bgbi005, 
   bgbi005_desc LIKE type_t.chr80, 
   l_bgaa002 LIKE type_t.chr10, 
   bgbi017 LIKE bgbi_t.bgbi017, 
   bgbi046 LIKE bgbi_t.bgbi046, 
   bgbi044 LIKE bgbi_t.bgbi044, 
   bgbistus LIKE bgbi_t.bgbistus
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_bgbi_d        RECORD
       bgbiseq LIKE bgbi_t.bgbiseq, 
   bgbi038 LIKE bgbi_t.bgbi038, 
   bgbi038_desc LIKE type_t.chr500, 
   bgbi007 LIKE bgbi_t.bgbi007, 
   bgbi007_desc LIKE type_t.chr500, 
   bgbi008 LIKE bgbi_t.bgbi008, 
   bgbi008_desc LIKE type_t.chr500, 
   bgbi009 LIKE bgbi_t.bgbi009, 
   bgbi009_desc LIKE type_t.chr500, 
   bgbi010 LIKE bgbi_t.bgbi010, 
   bgbi010_desc LIKE type_t.chr500, 
   bgbi011 LIKE bgbi_t.bgbi011, 
   bgbi011_desc LIKE type_t.chr500, 
   bgbi012 LIKE bgbi_t.bgbi012, 
   bgbi012_desc LIKE type_t.chr500, 
   bgbi013 LIKE bgbi_t.bgbi013, 
   bgbi013_desc LIKE type_t.chr500, 
   bgbi014 LIKE bgbi_t.bgbi014, 
   bgbi014_desc LIKE type_t.chr500, 
   bgbi015 LIKE bgbi_t.bgbi015, 
   bgbi015_desc LIKE type_t.chr500, 
   bgbi016 LIKE bgbi_t.bgbi016, 
   bgbi016_desc LIKE type_t.chr500, 
   bgbi039 LIKE bgbi_t.bgbi039, 
   bgbi039_desc LIKE type_t.chr500, 
   bgbi040 LIKE bgbi_t.bgbi040, 
   bgbi040_desc LIKE type_t.chr500, 
   bgbi041 LIKE bgbi_t.bgbi041, 
   bgbi041_desc LIKE type_t.chr500, 
   bgbi028 LIKE bgbi_t.bgbi028, 
   bgbi028_desc LIKE type_t.chr500, 
   bgbi029 LIKE bgbi_t.bgbi029, 
   bgbi029_desc LIKE type_t.chr500, 
   bgbi030 LIKE bgbi_t.bgbi030, 
   bgbi030_desc LIKE type_t.chr500, 
   bgbi031 LIKE bgbi_t.bgbi031, 
   bgbi031_desc LIKE type_t.chr500, 
   bgbi032 LIKE bgbi_t.bgbi032, 
   bgbi032_desc LIKE type_t.chr500, 
   bgbi033 LIKE bgbi_t.bgbi033, 
   bgbi033_desc LIKE type_t.chr500, 
   bgbi034 LIKE bgbi_t.bgbi034, 
   bgbi034_desc LIKE type_t.chr500, 
   bgbi035 LIKE bgbi_t.bgbi035, 
   bgbi035_desc LIKE type_t.chr500, 
   bgbi036 LIKE bgbi_t.bgbi036, 
   bgbi036_desc LIKE type_t.chr500, 
   bgbi037 LIKE bgbi_t.bgbi037, 
   bgbi037_desc LIKE type_t.chr500, 
   bgbi023 LIKE bgbi_t.bgbi023, 
   bgbi0232 LIKE type_t.num20_6, 
   bgbi0233 LIKE type_t.num20_6, 
   bgbi0234 LIKE type_t.num20_6, 
   bgbi0235 LIKE type_t.num20_6, 
   bgbi0236 LIKE type_t.num20_6, 
   bgbi0237 LIKE type_t.num20_6, 
   bgbi0238 LIKE type_t.num20_6, 
   bgbi0239 LIKE type_t.num20_6, 
   bgbi02310 LIKE type_t.num20_6, 
   bgbi02311 LIKE type_t.num20_6, 
   bgbi02312 LIKE type_t.num20_6, 
   bgbi02313 LIKE type_t.num20_6, 
   l_sum LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_bgbi2_d RECORD
       bgbiseq LIKE bgbi_t.bgbiseq, 
   bgbiownid LIKE bgbi_t.bgbiownid, 
   bgbiownid_desc LIKE type_t.chr500, 
   bgbiowndp LIKE bgbi_t.bgbiowndp, 
   bgbiowndp_desc LIKE type_t.chr500, 
   bgbicrtid LIKE bgbi_t.bgbicrtid, 
   bgbicrtid_desc LIKE type_t.chr500, 
   bgbicrtdp LIKE bgbi_t.bgbicrtdp, 
   bgbicrtdp_desc LIKE type_t.chr500, 
   bgbicrtdt DATETIME YEAR TO SECOND, 
   bgbimodid LIKE bgbi_t.bgbimodid, 
   bgbimodid_desc LIKE type_t.chr500, 
   bgbimoddt DATETIME YEAR TO SECOND, 
   bgbicnfid LIKE bgbi_t.bgbicnfid, 
   bgbicnfid_desc LIKE type_t.chr500, 
   bgbicnfdt DATETIME YEAR TO SECOND
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bgaa            RECORD
                            bgaa002   LIKE bgaa_t.bgaa002,
                            bgaa003   LIKE bgaa_t.bgaa003,
                            bgaa008   LIKE bgaa_t.bgaa008,
                            bgaa009   LIKE bgaa_t.bgaa009,   #現金變動碼參照表
                            bgaa012   LIKE bgaa_t.bgaa012
                         END RECORD
DEFINE g_glaa            RECORD
          glaacomp          LIKE glaa_t.glaacomp,
          glaa004           LIKE glaa_t.glaa004,
          glaa015           LIKE glaa_t.glaa015,
          glaa019           LIKE glaa_t.glaa019,
          glaa024           LIKE glaa_t.glaa024,
          glaa102           LIKE glaa_t.glaa102,
          glaa121           LIKE glaa_t.glaa121,
          glaa001           LIKE glaa_t.glaa001,
          glaa016           LIKE glaa_t.glaa016,
          glaa020           LIKE glaa_t.glaa020
                         END RECORD
DEFINE g_glad            RECORD
          glad0171          LIKE  glad_t.glad0171,
          glad0172          LIKE  glad_t.glad0172,
          glad0181          LIKE  glad_t.glad0181,
          glad0182          LIKE  glad_t.glad0182,
          glad0191          LIKE  glad_t.glad0191,
          glad0192          LIKE  glad_t.glad0192,
          glad0201          LIKE  glad_t.glad0201,
          glad0202          LIKE  glad_t.glad0202,
          glad0211          LIKE  glad_t.glad0211,
          glad0212          LIKE  glad_t.glad0212,
          glad0221          LIKE  glad_t.glad0221,
          glad0222          LIKE  glad_t.glad0222,
          glad0231          LIKE  glad_t.glad0231,
          glad0232          LIKE  glad_t.glad0232,
          glad0241          LIKE  glad_t.glad0241,
          glad0242          LIKE  glad_t.glad0242,
          glad0251          LIKE  glad_t.glad0251,
          glad0252          LIKE  glad_t.glad0252,
          glad0261          LIKE  glad_t.glad0261,
          glad0262          LIKE  glad_t.glad0262
                         END RECORD
DEFINE g_glaald          LIKE glaa_t.glaald
DEFINE g_glac002         LIKE glac_t.glac002    #項目對應會科
DEFINE g_bgbi043         LIKE bgbi_t.bgbi043    #匯率
DEFINE g_userorga        STRING   #161006-00005#11   add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_bgbi_m          type_g_bgbi_m
DEFINE g_bgbi_m_t        type_g_bgbi_m
DEFINE g_bgbi_m_o        type_g_bgbi_m
DEFINE g_bgbi_m_mask_o   type_g_bgbi_m #轉換遮罩前資料
DEFINE g_bgbi_m_mask_n   type_g_bgbi_m #轉換遮罩後資料
 
   DEFINE g_bgbi002_t LIKE bgbi_t.bgbi002
DEFINE g_bgbi003_t LIKE bgbi_t.bgbi003
DEFINE g_bgbi004_t LIKE bgbi_t.bgbi004
DEFINE g_bgbi005_t LIKE bgbi_t.bgbi005
DEFINE g_bgbi044_t LIKE bgbi_t.bgbi044
DEFINE g_bgbistus_t LIKE bgbi_t.bgbistus
 
 
DEFINE g_bgbi_d          DYNAMIC ARRAY OF type_g_bgbi_d
DEFINE g_bgbi_d_t        type_g_bgbi_d
DEFINE g_bgbi_d_o        type_g_bgbi_d
DEFINE g_bgbi_d_mask_o   DYNAMIC ARRAY OF type_g_bgbi_d #轉換遮罩前資料
DEFINE g_bgbi_d_mask_n   DYNAMIC ARRAY OF type_g_bgbi_d #轉換遮罩後資料
DEFINE g_bgbi2_d   DYNAMIC ARRAY OF type_g_bgbi2_d
DEFINE g_bgbi2_d_t type_g_bgbi2_d
DEFINE g_bgbi2_d_o type_g_bgbi2_d
DEFINE g_bgbi2_d_mask_o   DYNAMIC ARRAY OF type_g_bgbi2_d #轉換遮罩前資料
DEFINE g_bgbi2_d_mask_n   DYNAMIC ARRAY OF type_g_bgbi2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_bgbi002 LIKE bgbi_t.bgbi002,
      b_bgbi003 LIKE bgbi_t.bgbi003,
      b_bgbi004 LIKE bgbi_t.bgbi004,
      b_bgbi005 LIKE bgbi_t.bgbi005,
      b_bgbi044 LIKE bgbi_t.bgbi044,
      b_bgbistus LIKE bgbi_t.bgbistus
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
 
{<section id="abgt027.main" >}
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
   LET g_forupd_sql = " SELECT bgbi002,'',bgbi003,bgbi045,'',bgbi004,'',bgbi005,'','',bgbi017,bgbi046, 
       bgbi044,bgbistus", 
                      " FROM bgbi_t",
                      " WHERE bgbient= ? AND bgbi002=? AND bgbi003=? AND bgbi004=? AND bgbi005=? AND  
                          bgbi044=? AND bgbistus=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   #161006-00005#11  add ---s
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_sons_str() RETURNING g_userorga
   CALL s_fin_get_wc_str(g_userorga) RETURNING g_userorga
   #161006-00005#11  add ---e
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt027_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.bgbi002,t0.bgbi003,t0.bgbi045,t0.bgbi004,t0.bgbi005,t0.bgbi017,t0.bgbi046, 
       t0.bgbi044,t0.bgbistus",
               " FROM bgbi_t t0",
               
               " WHERE t0.bgbient = " ||g_enterprise|| " AND t0.bgbi002 = ? AND t0.bgbi003 = ? AND t0.bgbi004 = ? AND t0.bgbi005 = ? AND t0.bgbi044 = ? AND t0.bgbistus = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgt027_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgt027 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgt027_init()   
 
      #進入選單 Menu (="N")
      CALL abgt027_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgt027
      
   END IF 
   
   CLOSE abgt027_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgt027.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgt027_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('bgbistus','13','N,Y,X')
 
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('bgbistus','13','N,Y')
   CALL cl_set_combo_scc_part('b_bgbistus','13','N,Y')
   #資料來源
   CALL cl_set_combo_scc('bgbi044','9989')
   CALL cl_set_combo_scc('b_bgbi044','9989')
   #經營方式
   CALL cl_set_combo_scc('bgbi039','6013')
   CALL cl_set_combo_scc('bgbi039_desc','6013')
   CALL abgt027_create_tmp()
   #end add-point
   
   CALL abgt027_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="abgt027.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION abgt027_ui_dialog()
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
         INITIALIZE g_bgbi_m.* TO NULL
         CALL g_bgbi_d.clear()
         CALL g_bgbi2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL abgt027_init()
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
               CALL abgt027_idx_chk()
               CALL abgt027_fetch('') # reload data
               LET g_detail_idx = 1
               CALL abgt027_ui_detailshow() #Setting the current row 
         
            ON ACTION qbefield_user   #欄位隱藏設定 
               LET g_action_choice="qbefield_user"
               CALL cl_ui_qbefield_user()
         
         END DISPLAY
        
         DISPLAY ARRAY g_bgbi_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL abgt027_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgt027_ui_detailshow()
               
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
                              #此段落i02,i07樣板使用, 但目前不支援批次修改狀態, 先註解
			   ##此段落由子樣板a22產生
               ##目前選取的stus為N
               #IF . = "N" THEN
               #                     CALL cl_set_act_visible('unconfirmed',FALSE)
                  CALL cl_set_act_visible('confirmed',TRUE)
                  CALL cl_set_act_visible('invalid',TRUE)
 
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
        
         DISPLAY ARRAY g_bgbi2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL abgt027_idx_chk()
               CALL abgt027_ui_detailshow()
               
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
            CALL abgt027_browser_fill("")
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
               CALL abgt027_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL abgt027_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL abgt027_filter()
               EXIT DIALOG
 
 
 
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL abgt027_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt027_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL abgt027_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt027_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL abgt027_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt027_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL abgt027_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt027_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL abgt027_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL abgt027_idx_chk()
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
                  LET g_export_node[1] = base.typeInfo.create(g_bgbi_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_bgbi2_d)
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
               NEXT FIELD bgbiseq
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
               CALL abgt027_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL abgt027_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL abgt027_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION abgt027_01
            LET g_action_choice="abgt027_01"
            IF cl_auth_chk_act("abgt027_01") THEN
               
               #add-point:ON ACTION abgt027_01 name="menu.abgt027_01"
               #預算總額分配
               CALL s_transaction_begin()
               CALL abgt027_01('A',g_bgbi_d.getLength(),g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbistus,'')
                    RETURNING g_sub_success
               IF g_sub_success THEN
                  CALL s_transaction_end('Y',0)
                  CALL abgt027_show()
               ELSE
                  CALL s_transaction_end('N',0)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL abgt027_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL abgt027_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION statechange
            LET g_action_choice="statechange"
               
               #add-point:ON ACTION statechange name="menu.statechange"
               CALL abgt027_statechange()
               #根據資料狀態切換action狀態
               CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
               CALL abgt027_set_act_visible()   
               CALL abgt027_set_act_no_visible()
               IF NOT (g_bgbi_m.bgbi002 IS NULL
                 OR g_bgbi_m.bgbi003 IS NULL
                 OR g_bgbi_m.bgbi004 IS NULL
                 OR g_bgbi_m.bgbi005 IS NULL
                 OR g_bgbi_m.bgbi044 IS NULL
                 ) THEN
                  #組合條件
                  LET g_add_browse = " bgbient = '" ||g_enterprise|| "' AND",
                                     " bgbi002 = '", g_bgbi_m.bgbi002, "' "
                                     ," AND bgbi003 = '", g_bgbi_m.bgbi003, "' "
                                     ," AND bgbi004 = '", g_bgbi_m.bgbi004, "' "
                                     ," AND bgbi005 = '", g_bgbi_m.bgbi005, "' "
                                     ," AND bgbi044 = '", g_bgbi_m.bgbi044, "' "
                  #填到對應位置
                  CALL abgt027_browser_fill("")
               END IF
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL abgt027_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgt027_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgt027_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL abgt027_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL abgt027_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL abgt027_set_pk_array()
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
 
{<section id="abgt027.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION abgt027_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt027.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION abgt027_browser_fill(ps_page_action)
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
   LET g_wc = g_wc," AND bgbi044='1' "
   CALL s_chr_replace(g_wc2,'_desc','',0) RETURNING g_wc2
   #end add-point    
 
   LET l_searchcol = "bgbi002,bgbi003,bgbi004,bgbi005,bgbi044,bgbistus"
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
      LET l_sub_sql = " SELECT DISTINCT bgbi002 ",
                      ", bgbi003 ",
                      ", bgbi004 ",
                      ", bgbi005 ",
                      ", bgbi044 ",
                      ", bgbistus ",
 
                      " FROM bgbi_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE bgbient = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("bgbi_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT bgbi002 ",
                      ", bgbi003 ",
                      ", bgbi004 ",
                      ", bgbi005 ",
                      ", bgbi044 ",
                      ", bgbistus ",
 
                      " FROM bgbi_t ",
                      " ",
                      " ", 
 
 
                      " WHERE bgbient = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("bgbi_t")
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
      INITIALIZE g_bgbi_m.* TO NULL
      CALL g_bgbi_d.clear()        
      CALL g_bgbi2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.bgbi002,t0.bgbi003,t0.bgbi004,t0.bgbi005,t0.bgbi044,t0.bgbistus Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.bgbi002,t0.bgbi003,t0.bgbi004,t0.bgbi005,t0.bgbi044,t0.bgbistus", 
 
                " FROM bgbi_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.bgbient = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("bgbi_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"bgbi_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_bgbi002,g_browser[g_cnt].b_bgbi003,g_browser[g_cnt].b_bgbi004, 
          g_browser[g_cnt].b_bgbi005,g_browser[g_cnt].b_bgbi044,g_browser[g_cnt].b_bgbistus 
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
         CALL abgt027_browser_mask()
         
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
   
   IF cl_null(g_browser[g_cnt].b_bgbi002) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_bgbi_m.* TO NULL
      CALL g_bgbi_d.clear()
      CALL g_bgbi2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL abgt027_fetch('')
   
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
 
{<section id="abgt027.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION abgt027_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_bgbi_m.bgbi002 = g_browser[g_current_idx].b_bgbi002   
   LET g_bgbi_m.bgbi003 = g_browser[g_current_idx].b_bgbi003   
   LET g_bgbi_m.bgbi004 = g_browser[g_current_idx].b_bgbi004   
   LET g_bgbi_m.bgbi005 = g_browser[g_current_idx].b_bgbi005   
   LET g_bgbi_m.bgbi044 = g_browser[g_current_idx].b_bgbi044   
   LET g_bgbi_m.bgbistus = g_browser[g_current_idx].b_bgbistus   
 
   EXECUTE abgt027_master_referesh USING g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005, 
       g_bgbi_m.bgbi044,g_bgbi_m.bgbistus INTO g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004, 
       g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
   CALL abgt027_show()
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION abgt027_ui_detailshow()
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
 
{<section id="abgt027.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION abgt027_ui_browser_refresh()
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
      IF g_browser[l_i].b_bgbi002 = g_bgbi_m.bgbi002 
         AND g_browser[l_i].b_bgbi003 = g_bgbi_m.bgbi003 
         AND g_browser[l_i].b_bgbi004 = g_bgbi_m.bgbi004 
         AND g_browser[l_i].b_bgbi005 = g_bgbi_m.bgbi005 
         AND g_browser[l_i].b_bgbi044 = g_bgbi_m.bgbi044 
         AND g_browser[l_i].b_bgbistus = g_bgbi_m.bgbistus 
 
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
 
{<section id="abgt027.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgt027_construct()
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
   INITIALIZE g_bgbi_m.* TO NULL
   CALL g_bgbi_d.clear()
   CALL g_bgbi2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON bgbi002,bgbi003,bgbi045,bgbi004,bgbi005,bgbi017,bgbi046,bgbi044,bgbistus 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi002
            #add-point:BEFORE FIELD bgbi002 name="construct.b.bgbi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi002
            
            #add-point:AFTER FIELD bgbi002 name="construct.a.bgbi002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi002
            #add-point:ON ACTION controlp INFIELD bgbi002 name="construct.c.bgbi002"
            #C開窗-預算編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgaa001()
            DISPLAY g_qryparam.return1 TO bgbi002
            NEXT FIELD bgbi002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi003
            #add-point:BEFORE FIELD bgbi003 name="construct.b.bgbi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi003
            
            #add-point:AFTER FIELD bgbi003 name="construct.a.bgbi003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi003
            #add-point:ON ACTION controlp INFIELD bgbi003 name="construct.c.bgbi003"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi045
            #add-point:BEFORE FIELD bgbi045 name="construct.b.bgbi045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi045
            
            #add-point:AFTER FIELD bgbi045 name="construct.a.bgbi045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbi045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi045
            #add-point:ON ACTION controlp INFIELD bgbi045 name="construct.c.bgbi045"
            #C開窗-管理組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgai002()
            DISPLAY g_qryparam.return1 TO bgbi045
            NEXT FIELD bgbi045
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi004
            #add-point:BEFORE FIELD bgbi004 name="construct.b.bgbi004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi004
            
            #add-point:AFTER FIELD bgbi004 name="construct.a.bgbi004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbi004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi004
            #add-point:ON ACTION controlp INFIELD bgbi004 name="construct.c.bgbi004"
            #C開窗-預算組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = "ooef205 = 'Y'"   #161006-00005#11   mark
            #CALL q_ooef001()                         #161006-00005#11   mark
            #161006-00005#11  add---s
            LET g_qryparam.where = " ooef001 IN ",g_userorga
            CALL q_ooef001_77()
            #161006-00005#11   add---e
            DISPLAY g_qryparam.return1 TO bgbi004
            NEXT FIELD bgbi004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi005
            #add-point:BEFORE FIELD bgbi005 name="construct.b.bgbi005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi005
            
            #add-point:AFTER FIELD bgbi005 name="construct.a.bgbi005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbi005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi005
            #add-point:ON ACTION controlp INFIELD bgbi005 name="construct.c.bgbi005"
            #C開窗-預算細項
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgae001()
            DISPLAY g_qryparam.return1 TO bgbi005
            NEXT FIELD bgbi005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi017
            #add-point:BEFORE FIELD bgbi017 name="construct.b.bgbi017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi017
            
            #add-point:AFTER FIELD bgbi017 name="construct.a.bgbi017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbi017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi017
            #add-point:ON ACTION controlp INFIELD bgbi017 name="construct.c.bgbi017"
            #開窗c段-預算幣別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO bgbi017
            NEXT FIELD bgbi017
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi046
            #add-point:BEFORE FIELD bgbi046 name="construct.b.bgbi046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi046
            
            #add-point:AFTER FIELD bgbi046 name="construct.a.bgbi046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbi046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi046
            #add-point:ON ACTION controlp INFIELD bgbi046 name="construct.c.bgbi046"
            #C開窗-預算樣表
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bgaw001()
            DISPLAY g_qryparam.return1 TO bgbi046
            NEXT FIELD bgbi046
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi044
            #add-point:BEFORE FIELD bgbi044 name="construct.b.bgbi044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi044
            
            #add-point:AFTER FIELD bgbi044 name="construct.a.bgbi044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbi044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi044
            #add-point:ON ACTION controlp INFIELD bgbi044 name="construct.c.bgbi044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbistus
            #add-point:BEFORE FIELD bgbistus name="construct.b.bgbistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbistus
            
            #add-point:AFTER FIELD bgbistus name="construct.a.bgbistus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgbistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbistus
            #add-point:ON ACTION controlp INFIELD bgbistus name="construct.c.bgbistus"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON bgbi038,bgbi038_desc,bgbi007,bgbi007_desc,bgbi008,bgbi008_desc,bgbi009, 
          bgbi009_desc,bgbi010,bgbi010_desc,bgbi011,bgbi011_desc,bgbi012,bgbi012_desc,bgbi013,bgbi013_desc, 
          bgbi014,bgbi014_desc,bgbi015,bgbi015_desc,bgbi016,bgbi016_desc,bgbi039,bgbi039_desc,bgbi040, 
          bgbi040_desc,bgbi041,bgbi041_desc,bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,bgbi033,bgbi034, 
          bgbi035,bgbi036,bgbi037,bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,bgbicrtdt,bgbimodid,bgbimoddt, 
          bgbicnfid,bgbicnfdt
           FROM s_detail1[1].bgbi038,s_detail1[1].bgbi038_desc,s_detail1[1].bgbi007,s_detail1[1].bgbi007_desc, 
               s_detail1[1].bgbi008,s_detail1[1].bgbi008_desc,s_detail1[1].bgbi009,s_detail1[1].bgbi009_desc, 
               s_detail1[1].bgbi010,s_detail1[1].bgbi010_desc,s_detail1[1].bgbi011,s_detail1[1].bgbi011_desc, 
               s_detail1[1].bgbi012,s_detail1[1].bgbi012_desc,s_detail1[1].bgbi013,s_detail1[1].bgbi013_desc, 
               s_detail1[1].bgbi014,s_detail1[1].bgbi014_desc,s_detail1[1].bgbi015,s_detail1[1].bgbi015_desc, 
               s_detail1[1].bgbi016,s_detail1[1].bgbi016_desc,s_detail1[1].bgbi039,s_detail1[1].bgbi039_desc, 
               s_detail1[1].bgbi040,s_detail1[1].bgbi040_desc,s_detail1[1].bgbi041,s_detail1[1].bgbi041_desc, 
               s_detail1[1].bgbi028,s_detail1[1].bgbi029,s_detail1[1].bgbi030,s_detail1[1].bgbi031,s_detail1[1].bgbi032, 
               s_detail1[1].bgbi033,s_detail1[1].bgbi034,s_detail1[1].bgbi035,s_detail1[1].bgbi036,s_detail1[1].bgbi037, 
               s_detail2[1].bgbiownid,s_detail2[1].bgbiowndp,s_detail2[1].bgbicrtid,s_detail2[1].bgbicrtdp, 
               s_detail2[1].bgbicrtdt,s_detail2[1].bgbimodid,s_detail2[1].bgbimoddt,s_detail2[1].bgbicnfid, 
               s_detail2[1].bgbicnfdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<bgbicrtdt>>----
         AFTER FIELD bgbicrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<bgbimoddt>>----
         AFTER FIELD bgbimoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgbicnfdt>>----
         AFTER FIELD bgbicnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<bgbipstdt>>----
 
 
 
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi038
            #add-point:BEFORE FIELD bgbi038 name="construct.b.page1.bgbi038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi038
            
            #add-point:AFTER FIELD bgbi038 name="construct.a.page1.bgbi038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi038
            #add-point:ON ACTION controlp INFIELD bgbi038 name="construct.c.page1.bgbi038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi038_desc
            #add-point:BEFORE FIELD bgbi038_desc name="construct.b.page1.bgbi038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi038_desc
            
            #add-point:AFTER FIELD bgbi038_desc name="construct.a.page1.bgbi038_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi038_desc
            #add-point:ON ACTION controlp INFIELD bgbi038_desc name="construct.c.page1.bgbi038_desc"
            #開窗c段-現金變動碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()
            DISPLAY g_qryparam.return1 TO bgbi038
            DISPLAY g_qryparam.return1 TO bgbi038_desc
            NEXT FIELD bgbi038_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi007
            #add-point:BEFORE FIELD bgbi007 name="construct.b.page1.bgbi007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi007
            
            #add-point:AFTER FIELD bgbi007 name="construct.a.page1.bgbi007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi007
            #add-point:ON ACTION controlp INFIELD bgbi007 name="construct.c.page1.bgbi007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi007_desc
            #add-point:BEFORE FIELD bgbi007_desc name="construct.b.page1.bgbi007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi007_desc
            
            #add-point:AFTER FIELD bgbi007_desc name="construct.a.page1.bgbi007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi007_desc
            #add-point:ON ACTION controlp INFIELD bgbi007_desc name="construct.c.page1.bgbi007_desc"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO bgbi007
            DISPLAY g_qryparam.return1 TO bgbi007_desc
            NEXT FIELD bgbi007_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi008
            #add-point:BEFORE FIELD bgbi008 name="construct.b.page1.bgbi008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi008
            
            #add-point:AFTER FIELD bgbi008 name="construct.a.page1.bgbi008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi008
            #add-point:ON ACTION controlp INFIELD bgbi008 name="construct.c.page1.bgbi008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi008_desc
            #add-point:BEFORE FIELD bgbi008_desc name="construct.b.page1.bgbi008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi008_desc
            
            #add-point:AFTER FIELD bgbi008_desc name="construct.a.page1.bgbi008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi008_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi008_desc
            #add-point:ON ACTION controlp INFIELD bgbi008_desc name="construct.c.page1.bgbi008_desc"
            #成本利潤中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO bgbi008
            DISPLAY g_qryparam.return1 TO bgbi008_desc
            NEXT FIELD bgbi008_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi009
            #add-point:BEFORE FIELD bgbi009 name="construct.b.page1.bgbi009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi009
            
            #add-point:AFTER FIELD bgbi009 name="construct.a.page1.bgbi009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi009
            #add-point:ON ACTION controlp INFIELD bgbi009 name="construct.c.page1.bgbi009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi009_desc
            #add-point:BEFORE FIELD bgbi009_desc name="construct.b.page1.bgbi009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi009_desc
            
            #add-point:AFTER FIELD bgbi009_desc name="construct.a.page1.bgbi009_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi009_desc
            #add-point:ON ACTION controlp INFIELD bgbi009_desc name="construct.c.page1.bgbi009_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO bgbi009
            DISPLAY g_qryparam.return1 TO bgbi009_desc
            NEXT FIELD bgbi009_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi010
            #add-point:BEFORE FIELD bgbi010 name="construct.b.page1.bgbi010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi010
            
            #add-point:AFTER FIELD bgbi010 name="construct.a.page1.bgbi010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi010
            #add-point:ON ACTION controlp INFIELD bgbi010 name="construct.c.page1.bgbi010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi010_desc
            #add-point:BEFORE FIELD bgbi010_desc name="construct.b.page1.bgbi010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi010_desc
            
            #add-point:AFTER FIELD bgbi010_desc name="construct.a.page1.bgbi010_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi010_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi010_desc
            #add-point:ON ACTION controlp INFIELD bgbi010_desc name="construct.c.page1.bgbi010_desc"
            #交易客商
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()    #160920-00019#3--mark
            CALL q_pmaa001_25()  #160920-00019#3--add
            DISPLAY g_qryparam.return1 TO bgbi010
            DISPLAY g_qryparam.return1 TO bgbi010_desc
            NEXT FIELD bgbi010_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi011
            #add-point:BEFORE FIELD bgbi011 name="construct.b.page1.bgbi011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi011
            
            #add-point:AFTER FIELD bgbi011 name="construct.a.page1.bgbi011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi011
            #add-point:ON ACTION controlp INFIELD bgbi011 name="construct.c.page1.bgbi011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi011_desc
            #add-point:BEFORE FIELD bgbi011_desc name="construct.b.page1.bgbi011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi011_desc
            
            #add-point:AFTER FIELD bgbi011_desc name="construct.a.page1.bgbi011_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi011_desc
            #add-point:ON ACTION controlp INFIELD bgbi011_desc name="construct.c.page1.bgbi011_desc"
            #收款客商
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmac002_1()
            DISPLAY g_qryparam.return1 TO bgbi011
            DISPLAY g_qryparam.return1 TO bgbi011_desc
            NEXT FIELD bgbi011_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi012
            #add-point:BEFORE FIELD bgbi012 name="construct.b.page1.bgbi012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi012
            
            #add-point:AFTER FIELD bgbi012 name="construct.a.page1.bgbi012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi012
            #add-point:ON ACTION controlp INFIELD bgbi012 name="construct.c.page1.bgbi012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi012_desc
            #add-point:BEFORE FIELD bgbi012_desc name="construct.b.page1.bgbi012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi012_desc
            
            #add-point:AFTER FIELD bgbi012_desc name="construct.a.page1.bgbi012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi012_desc
            #add-point:ON ACTION controlp INFIELD bgbi012_desc name="construct.c.page1.bgbi012_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO bgbi012
            DISPLAY g_qryparam.return1 TO bgbi012_desc
            NEXT FIELD bgbi012_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi013
            #add-point:BEFORE FIELD bgbi013 name="construct.b.page1.bgbi013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi013
            
            #add-point:AFTER FIELD bgbi013 name="construct.a.page1.bgbi013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi013
            #add-point:ON ACTION controlp INFIELD bgbi013 name="construct.c.page1.bgbi013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi013_desc
            #add-point:BEFORE FIELD bgbi013_desc name="construct.b.page1.bgbi013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi013_desc
            
            #add-point:AFTER FIELD bgbi013_desc name="construct.a.page1.bgbi013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi013_desc
            #add-point:ON ACTION controlp INFIELD bgbi013_desc name="construct.c.page1.bgbi013_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO bgbi013
            DISPLAY g_qryparam.return1 TO bgbi013_desc
            NEXT FIELD bgbi013_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi014
            #add-point:BEFORE FIELD bgbi014 name="construct.b.page1.bgbi014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi014
            
            #add-point:AFTER FIELD bgbi014 name="construct.a.page1.bgbi014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi014
            #add-point:ON ACTION controlp INFIELD bgbi014 name="construct.c.page1.bgbi014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi014_desc
            #add-point:BEFORE FIELD bgbi014_desc name="construct.b.page1.bgbi014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi014_desc
            
            #add-point:AFTER FIELD bgbi014_desc name="construct.a.page1.bgbi014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi014_desc
            #add-point:ON ACTION controlp INFIELD bgbi014_desc name="construct.c.page1.bgbi014_desc"
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO bgbi014
            DISPLAY g_qryparam.return1 TO bgbi014_desc
            NEXT FIELD bgbi014_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi015
            #add-point:BEFORE FIELD bgbi015 name="construct.b.page1.bgbi015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi015
            
            #add-point:AFTER FIELD bgbi015 name="construct.a.page1.bgbi015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi015
            #add-point:ON ACTION controlp INFIELD bgbi015 name="construct.c.page1.bgbi015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi015_desc
            #add-point:BEFORE FIELD bgbi015_desc name="construct.b.page1.bgbi015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi015_desc
            
            #add-point:AFTER FIELD bgbi015_desc name="construct.a.page1.bgbi015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi015_desc
            #add-point:ON ACTION controlp INFIELD bgbi015_desc name="construct.c.page1.bgbi015_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO bgbi015
            DISPLAY g_qryparam.return1 TO bgbi015_desc
            NEXT FIELD bgbi015_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi016
            #add-point:BEFORE FIELD bgbi016 name="construct.b.page1.bgbi016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi016
            
            #add-point:AFTER FIELD bgbi016 name="construct.a.page1.bgbi016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi016
            #add-point:ON ACTION controlp INFIELD bgbi016 name="construct.c.page1.bgbi016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi016_desc
            #add-point:BEFORE FIELD bgbi016_desc name="construct.b.page1.bgbi016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi016_desc
            
            #add-point:AFTER FIELD bgbi016_desc name="construct.a.page1.bgbi016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi016_desc
            #add-point:ON ACTION controlp INFIELD bgbi016_desc name="construct.c.page1.bgbi016_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO bgbi016
            DISPLAY g_qryparam.return1 TO bgbi016_desc
            NEXT FIELD bgbi016_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi039
            #add-point:BEFORE FIELD bgbi039 name="construct.b.page1.bgbi039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi039
            
            #add-point:AFTER FIELD bgbi039 name="construct.a.page1.bgbi039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi039
            #add-point:ON ACTION controlp INFIELD bgbi039 name="construct.c.page1.bgbi039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi039_desc
            #add-point:BEFORE FIELD bgbi039_desc name="construct.b.page1.bgbi039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi039_desc
            
            #add-point:AFTER FIELD bgbi039_desc name="construct.a.page1.bgbi039_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi039_desc
            #add-point:ON ACTION controlp INFIELD bgbi039_desc name="construct.c.page1.bgbi039_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi040
            #add-point:BEFORE FIELD bgbi040 name="construct.b.page1.bgbi040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi040
            
            #add-point:AFTER FIELD bgbi040 name="construct.a.page1.bgbi040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi040
            #add-point:ON ACTION controlp INFIELD bgbi040 name="construct.c.page1.bgbi040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi040_desc
            #add-point:BEFORE FIELD bgbi040_desc name="construct.b.page1.bgbi040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi040_desc
            
            #add-point:AFTER FIELD bgbi040_desc name="construct.a.page1.bgbi040_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi040_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi040_desc
            #add-point:ON ACTION controlp INFIELD bgbi040_desc name="construct.c.page1.bgbi040_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO bgbi040
            DISPLAY g_qryparam.return1 TO bgbi040_desc
            NEXT FIELD bgbi040_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi041
            #add-point:BEFORE FIELD bgbi041 name="construct.b.page1.bgbi041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi041
            
            #add-point:AFTER FIELD bgbi041 name="construct.a.page1.bgbi041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi041
            #add-point:ON ACTION controlp INFIELD bgbi041 name="construct.c.page1.bgbi041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi041_desc
            #add-point:BEFORE FIELD bgbi041_desc name="construct.b.page1.bgbi041_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi041_desc
            
            #add-point:AFTER FIELD bgbi041_desc name="construct.a.page1.bgbi041_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi041_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi041_desc
            #add-point:ON ACTION controlp INFIELD bgbi041_desc name="construct.c.page1.bgbi041_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO bgbi041
            DISPLAY g_qryparam.return1 TO bgbi041_desc
            NEXT FIELD bgbi041_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi028
            #add-point:BEFORE FIELD bgbi028 name="construct.b.page1.bgbi028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi028
            
            #add-point:AFTER FIELD bgbi028 name="construct.a.page1.bgbi028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi028
            #add-point:ON ACTION controlp INFIELD bgbi028 name="construct.c.page1.bgbi028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi029
            #add-point:BEFORE FIELD bgbi029 name="construct.b.page1.bgbi029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi029
            
            #add-point:AFTER FIELD bgbi029 name="construct.a.page1.bgbi029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi029
            #add-point:ON ACTION controlp INFIELD bgbi029 name="construct.c.page1.bgbi029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi030
            #add-point:BEFORE FIELD bgbi030 name="construct.b.page1.bgbi030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi030
            
            #add-point:AFTER FIELD bgbi030 name="construct.a.page1.bgbi030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi030
            #add-point:ON ACTION controlp INFIELD bgbi030 name="construct.c.page1.bgbi030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi031
            #add-point:BEFORE FIELD bgbi031 name="construct.b.page1.bgbi031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi031
            
            #add-point:AFTER FIELD bgbi031 name="construct.a.page1.bgbi031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi031
            #add-point:ON ACTION controlp INFIELD bgbi031 name="construct.c.page1.bgbi031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi032
            #add-point:BEFORE FIELD bgbi032 name="construct.b.page1.bgbi032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi032
            
            #add-point:AFTER FIELD bgbi032 name="construct.a.page1.bgbi032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi032
            #add-point:ON ACTION controlp INFIELD bgbi032 name="construct.c.page1.bgbi032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi033
            #add-point:BEFORE FIELD bgbi033 name="construct.b.page1.bgbi033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi033
            
            #add-point:AFTER FIELD bgbi033 name="construct.a.page1.bgbi033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi033
            #add-point:ON ACTION controlp INFIELD bgbi033 name="construct.c.page1.bgbi033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi034
            #add-point:BEFORE FIELD bgbi034 name="construct.b.page1.bgbi034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi034
            
            #add-point:AFTER FIELD bgbi034 name="construct.a.page1.bgbi034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi034
            #add-point:ON ACTION controlp INFIELD bgbi034 name="construct.c.page1.bgbi034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi035
            #add-point:BEFORE FIELD bgbi035 name="construct.b.page1.bgbi035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi035
            
            #add-point:AFTER FIELD bgbi035 name="construct.a.page1.bgbi035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi035
            #add-point:ON ACTION controlp INFIELD bgbi035 name="construct.c.page1.bgbi035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi036
            #add-point:BEFORE FIELD bgbi036 name="construct.b.page1.bgbi036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi036
            
            #add-point:AFTER FIELD bgbi036 name="construct.a.page1.bgbi036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi036
            #add-point:ON ACTION controlp INFIELD bgbi036 name="construct.c.page1.bgbi036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi037
            #add-point:BEFORE FIELD bgbi037 name="construct.b.page1.bgbi037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi037
            
            #add-point:AFTER FIELD bgbi037 name="construct.a.page1.bgbi037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.bgbi037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi037
            #add-point:ON ACTION controlp INFIELD bgbi037 name="construct.c.page1.bgbi037"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgbiownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbiownid
            #add-point:ON ACTION controlp INFIELD bgbiownid name="construct.c.page2.bgbiownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO bgbiownid
            NEXT FIELD bgbiownid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbiownid
            #add-point:BEFORE FIELD bgbiownid name="construct.b.page2.bgbiownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbiownid
            
            #add-point:AFTER FIELD bgbiownid name="construct.a.page2.bgbiownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgbiowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbiowndp
            #add-point:ON ACTION controlp INFIELD bgbiowndp name="construct.c.page2.bgbiowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()
            DISPLAY g_qryparam.return1 TO bgbiowndp
            NEXT FIELD bgbiowndp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbiowndp
            #add-point:BEFORE FIELD bgbiowndp name="construct.b.page2.bgbiowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbiowndp
            
            #add-point:AFTER FIELD bgbiowndp name="construct.a.page2.bgbiowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgbicrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbicrtid
            #add-point:ON ACTION controlp INFIELD bgbicrtid name="construct.c.page2.bgbicrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO bgbicrtid
            NEXT FIELD bgbicrtid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbicrtid
            #add-point:BEFORE FIELD bgbicrtid name="construct.b.page2.bgbicrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbicrtid
            
            #add-point:AFTER FIELD bgbicrtid name="construct.a.page2.bgbicrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.bgbicrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbicrtdp
            #add-point:ON ACTION controlp INFIELD bgbicrtdp name="construct.c.page2.bgbicrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()
            DISPLAY g_qryparam.return1 TO bgbicrtdp
            NEXT FIELD bgbicrtdp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbicrtdp
            #add-point:BEFORE FIELD bgbicrtdp name="construct.b.page2.bgbicrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbicrtdp
            
            #add-point:AFTER FIELD bgbicrtdp name="construct.a.page2.bgbicrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbicrtdt
            #add-point:BEFORE FIELD bgbicrtdt name="construct.b.page2.bgbicrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgbimodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbimodid
            #add-point:ON ACTION controlp INFIELD bgbimodid name="construct.c.page2.bgbimodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO bgbimodid
            NEXT FIELD bgbimodid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbimodid
            #add-point:BEFORE FIELD bgbimodid name="construct.b.page2.bgbimodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbimodid
            
            #add-point:AFTER FIELD bgbimodid name="construct.a.page2.bgbimodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbimoddt
            #add-point:BEFORE FIELD bgbimoddt name="construct.b.page2.bgbimoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.bgbicnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbicnfid
            #add-point:ON ACTION controlp INFIELD bgbicnfid name="construct.c.page2.bgbicnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO bgbicnfid
            NEXT FIELD bgbicnfid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbicnfid
            #add-point:BEFORE FIELD bgbicnfid name="construct.b.page2.bgbicnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbicnfid
            
            #add-point:AFTER FIELD bgbicnfid name="construct.a.page2.bgbicnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbicnfdt
            #add-point:BEFORE FIELD bgbicnfdt name="construct.b.page2.bgbicnfdt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         CALL cl_set_comp_visible("bgbi007_desc,bgbi008_desc,bgbi009_desc,bgbi010_desc",TRUE)
         CALL cl_set_comp_visible("bgbi011_desc,bgbi012_desc,bgbi013_desc,bgbi014_desc,bgbi015_desc",TRUE)
         CALL cl_set_comp_visible("bgbi016_desc,bgbi039_desc,bgbi010_desc,bgbi041_desc",TRUE)
         CALL cl_set_comp_visible("bgbi028_desc,bgbi029_desc,bgbi030_desc,bgbi031_desc,bgbi032_desc",TRUE)
         CALL cl_set_comp_visible("bgbi033_desc,bgbi034_desc,bgbi035_desc,bgbi036_desc,bgbi037_desc",TRUE) 
         LET l_ac = 1
         LET g_bgbi_d[l_ac].bgbi038 = ' '
         DISPLAY ARRAY g_bgbi_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
 
{<section id="abgt027.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION abgt027_filter()
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
      CONSTRUCT g_wc_filter ON bgbi002,bgbi003,bgbi004,bgbi005,bgbi044,bgbistus
                          FROM s_browse[1].b_bgbi002,s_browse[1].b_bgbi003,s_browse[1].b_bgbi004,s_browse[1].b_bgbi005, 
                              s_browse[1].b_bgbi044,s_browse[1].b_bgbistus
 
         BEFORE CONSTRUCT
               DISPLAY abgt027_filter_parser('bgbi002') TO s_browse[1].b_bgbi002
            DISPLAY abgt027_filter_parser('bgbi003') TO s_browse[1].b_bgbi003
            DISPLAY abgt027_filter_parser('bgbi004') TO s_browse[1].b_bgbi004
            DISPLAY abgt027_filter_parser('bgbi005') TO s_browse[1].b_bgbi005
            DISPLAY abgt027_filter_parser('bgbi044') TO s_browse[1].b_bgbi044
            DISPLAY abgt027_filter_parser('bgbistus') TO s_browse[1].b_bgbistus
      
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
 
      CALL abgt027_filter_show('bgbi002')
   CALL abgt027_filter_show('bgbi003')
   CALL abgt027_filter_show('bgbi004')
   CALL abgt027_filter_show('bgbi005')
   CALL abgt027_filter_show('bgbi044')
   CALL abgt027_filter_show('bgbistus')
 
END FUNCTION
 
{</section>}
 
{<section id="abgt027.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION abgt027_filter_parser(ps_field)
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
 
{<section id="abgt027.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION abgt027_filter_show(ps_field)
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
   LET ls_condition = abgt027_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abgt027.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION abgt027_query()
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
   CALL g_bgbi_d.clear()
   CALL g_bgbi2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL abgt027_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL abgt027_browser_fill(g_wc)
      CALL abgt027_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL abgt027_browser_fill("F")
   
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
      CALL abgt027_fetch("F") 
   END IF
   
   CALL abgt027_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION abgt027_fetch(p_flag)
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
   
   LET g_bgbi_m.bgbi002 = g_browser[g_current_idx].b_bgbi002
   LET g_bgbi_m.bgbi003 = g_browser[g_current_idx].b_bgbi003
   LET g_bgbi_m.bgbi004 = g_browser[g_current_idx].b_bgbi004
   LET g_bgbi_m.bgbi005 = g_browser[g_current_idx].b_bgbi005
   LET g_bgbi_m.bgbi044 = g_browser[g_current_idx].b_bgbi044
   LET g_bgbi_m.bgbistus = g_browser[g_current_idx].b_bgbistus
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE abgt027_master_referesh USING g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005, 
       g_bgbi_m.bgbi044,g_bgbi_m.bgbistus INTO g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004, 
       g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgbi_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_bgbi_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_bgbi_m_mask_o.* =  g_bgbi_m.*
   CALL abgt027_bgbi_t_mask()
   LET g_bgbi_m_mask_n.* =  g_bgbi_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt027_set_act_visible()
   CALL abgt027_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_bgbi_m_t.* = g_bgbi_m.*
   LET g_bgbi_m_o.* = g_bgbi_m.*
   
   #重新顯示   
   CALL abgt027_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgt027.insert" >}
#+ 資料新增
PRIVATE FUNCTION abgt027_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_bgbi_d.clear()
   CALL g_bgbi2_d.clear()
 
 
   INITIALIZE g_bgbi_m.* TO NULL             #DEFAULT 設定
   LET g_bgbi002_t = NULL
   LET g_bgbi003_t = NULL
   LET g_bgbi004_t = NULL
   LET g_bgbi005_t = NULL
   LET g_bgbi044_t = NULL
   LET g_bgbistus_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
            LET g_bgbi_m.bgbi044 = "1"
 
     
      #add-point:單頭預設值 name="insert.default"
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_bgbi_m_t.* = g_bgbi_m.*
      LET g_bgbi_m_o.* = g_bgbi_m.*
      
      LET g_bgbi_m.bgbistus = 'N'
      CASE g_bgbi_m.bgbistus
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
 
      CALL abgt027_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_bgbi_m.* TO NULL
         INITIALIZE g_bgbi_d TO NULL
         INITIALIZE g_bgbi2_d TO NULL
 
         CALL abgt027_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgbi_m.* = g_bgbi_m_t.*
         CALL abgt027_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_bgbi_d.clear()
      #CALL g_bgbi2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      CALL s_transaction_end('Y','0')
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL abgt027_set_act_visible()
   CALL abgt027_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgbi002_t = g_bgbi_m.bgbi002
   LET g_bgbi003_t = g_bgbi_m.bgbi003
   LET g_bgbi004_t = g_bgbi_m.bgbi004
   LET g_bgbi005_t = g_bgbi_m.bgbi005
   LET g_bgbi044_t = g_bgbi_m.bgbi044
   LET g_bgbistus_t = g_bgbi_m.bgbistus
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgbient = " ||g_enterprise|| " AND",
                      " bgbi002 = '", g_bgbi_m.bgbi002, "' "
                      ," AND bgbi003 = '", g_bgbi_m.bgbi003, "' "
                      ," AND bgbi004 = '", g_bgbi_m.bgbi004, "' "
                      ," AND bgbi005 = '", g_bgbi_m.bgbi005, "' "
                      ," AND bgbi044 = '", g_bgbi_m.bgbi044, "' "
                      ," AND bgbistus = '", g_bgbi_m.bgbistus, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt027_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL abgt027_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE abgt027_master_referesh USING g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005, 
       g_bgbi_m.bgbi044,g_bgbi_m.bgbistus INTO g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004, 
       g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
   
   #遮罩相關處理
   LET g_bgbi_m_mask_o.* =  g_bgbi_m.*
   CALL abgt027_bgbi_t_mask()
   LET g_bgbi_m_mask_n.* =  g_bgbi_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgbi_m.bgbi002,g_bgbi_m.bgbi002_desc,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi045_desc, 
       g_bgbi_m.bgbi004,g_bgbi_m.bgbi004_desc,g_bgbi_m.bgbi005,g_bgbi_m.bgbi005_desc,g_bgbi_m.l_bgaa002, 
       g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
   
   #功能已完成,通報訊息中心
   CALL abgt027_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.modify" >}
#+ 資料修改
PRIVATE FUNCTION abgt027_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   #保存單頭舊值
   LET g_bgbi_m_t.* = g_bgbi_m.*
   LET g_bgbi_m_o.* = g_bgbi_m.*
   #end add-point
   
   IF g_bgbi_m.bgbi002 IS NULL
   OR g_bgbi_m.bgbi003 IS NULL
   OR g_bgbi_m.bgbi004 IS NULL
   OR g_bgbi_m.bgbi005 IS NULL
   OR g_bgbi_m.bgbi044 IS NULL
   OR g_bgbi_m.bgbistus IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_bgbi002_t = g_bgbi_m.bgbi002
   LET g_bgbi003_t = g_bgbi_m.bgbi003
   LET g_bgbi004_t = g_bgbi_m.bgbi004
   LET g_bgbi005_t = g_bgbi_m.bgbi005
   LET g_bgbi044_t = g_bgbi_m.bgbi044
   LET g_bgbistus_t = g_bgbi_m.bgbistus
 
   CALL s_transaction_begin()
   
   OPEN abgt027_cl USING g_enterprise,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt027_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt027_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt027_master_referesh USING g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005, 
       g_bgbi_m.bgbi044,g_bgbi_m.bgbistus INTO g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004, 
       g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
   
   #遮罩相關處理
   LET g_bgbi_m_mask_o.* =  g_bgbi_m.*
   CALL abgt027_bgbi_t_mask()
   LET g_bgbi_m_mask_n.* =  g_bgbi_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL abgt027_show()
   WHILE TRUE
      LET g_bgbi002_t = g_bgbi_m.bgbi002
      LET g_bgbi003_t = g_bgbi_m.bgbi003
      LET g_bgbi004_t = g_bgbi_m.bgbi004
      LET g_bgbi005_t = g_bgbi_m.bgbi005
      LET g_bgbi044_t = g_bgbi_m.bgbi044
      LET g_bgbistus_t = g_bgbi_m.bgbistus
 
 
      #add-point:modify段修改前 name="modify.before_input"
      #160818-00017#3  2016/08/24 By 07900 --add--s--
      #檢查是否允許此動作
      IF NOT abgt027_action_chk() THEN
        # CALL s_transaction_end('N','0')
         RETURN
      END IF
      #160818-00017#3  2016/08/24 By 07900 --add--e--
      #end add-point
      
      CALL abgt027_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_bgbi_m.* = g_bgbi_m_t.*
         CALL abgt027_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_bgbi_m.bgbi002 != g_bgbi002_t 
      OR g_bgbi_m.bgbi003 != g_bgbi003_t 
      OR g_bgbi_m.bgbi004 != g_bgbi004_t 
      OR g_bgbi_m.bgbi005 != g_bgbi005_t 
      OR g_bgbi_m.bgbi044 != g_bgbi044_t 
      OR g_bgbi_m.bgbistus != g_bgbistus_t 
 
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
   CALL abgt027_set_act_visible()
   CALL abgt027_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " bgbient = " ||g_enterprise|| " AND",
                      " bgbi002 = '", g_bgbi_m.bgbi002, "' "
                      ," AND bgbi003 = '", g_bgbi_m.bgbi003, "' "
                      ," AND bgbi004 = '", g_bgbi_m.bgbi004, "' "
                      ," AND bgbi005 = '", g_bgbi_m.bgbi005, "' "
                      ," AND bgbi044 = '", g_bgbi_m.bgbi044, "' "
                      ," AND bgbistus = '", g_bgbi_m.bgbistus, "' "
 
   #填到對應位置
   CALL abgt027_browser_fill("")
 
   CALL abgt027_idx_chk()
 
   CLOSE abgt027_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt027_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="abgt027.input" >}
#+ 資料輸入
PRIVATE FUNCTION abgt027_input(p_cmd)
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
   DEFINE l_glae009              LIKE glae_t.glae009  #開窗查詢編號
   DEFINE l_wc                   STRING
   DEFINE l_sql                  STRING
   DEFINE l_write                LIKE type_t.chr1
   DEFINE l_bgbi023              LIKE bgbi_t.bgbi023
   DEFINE l_bgbi                 type_g_bgbi_d
   DEFINE l_bgbi2                type_g_bgbi2_d
   DEFINE l_tran_flag            LIKE type_t.chr1
   DEFINE l_flag                 LIKE type_t.chr1
   DEFINE l_orga                 STRING   #161006-00005#11   add
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
   DISPLAY BY NAME g_bgbi_m.bgbi002,g_bgbi_m.bgbi002_desc,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi045_desc, 
       g_bgbi_m.bgbi004,g_bgbi_m.bgbi004_desc,g_bgbi_m.bgbi005,g_bgbi_m.bgbi005_desc,g_bgbi_m.l_bgaa002, 
       g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
   
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
   LET g_forupd_sql = "SELECT bgbiseq,bgbi038,bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,bgbi012,bgbi013, 
       bgbi014,bgbi015,bgbi016,bgbi039,bgbi040,bgbi041,bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,bgbi033, 
       bgbi034,bgbi035,bgbi036,bgbi037,bgbi023,bgbiseq,bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,bgbicrtdt, 
       bgbimodid,bgbimoddt,bgbicnfid,bgbicnfdt FROM bgbi_t WHERE bgbient=? AND bgbi002=? AND bgbi003=?  
       AND bgbi004=? AND bgbi005=? AND bgbi044=? AND bgbistus=? AND bgbiseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   LET g_forupd_sql = "SELECT bgbiseq,bgbi038,",
                      "       bgbi007,bgbi008,bgbi009,bgbi010,",
                      "       bgbi011,bgbi012,bgbi013,bgbi014,bgbi015,",
                      "       bgbi016,bgbi039,bgbi040,bgbi041,",
                      "       bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,",
                      "       bgbi033,bgbi034,bgbi035,bgbi036,bgbi037,",
                      "       bgbi023,bgbi0232,bgbi0233,bgbi0234,bgbi0235,",
                      "       bgbi0236,bgbi0237,bgbi0238,bgbi0239,bgbi02310,",
                      "       bgbi02311,bgbi02312,bgbi02313,l_sum",
                      "  FROM abgt027_tmp",
                      " WHERE bgbient=? AND bgbi002=? AND bgbi003=? AND bgbi004=? AND bgbi005=?",
                      "   AND bgbi044=? AND bgbistus=? AND bgbiseq=? FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgt027_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL abgt027_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL abgt027_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005, 
       g_bgbi_m.l_bgaa002,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbistus
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   LET l_tran_flag = 'N'
   LET g_errshow = 1
   WHILE TRUE
      LET l_flag = 'N'
      IF l_tran_flag = 'Y' THEN 
         CALL s_transaction_begin()
      END IF
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="abgt027.input.head" >}
   
      #單頭段
      INPUT BY NAME g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005, 
          g_bgbi_m.l_bgaa002,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbistus 
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
         AFTER FIELD bgbi002
            
            #add-point:AFTER FIELD bgbi002 name="input.a.bgbi002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgbi_m.bgbi002) AND NOT cl_null(g_bgbi_m.bgbi003) AND NOT cl_null(g_bgbi_m.bgbi004) AND NOT cl_null(g_bgbi_m.bgbi005) AND NOT cl_null(g_bgbi_m.bgbi044) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgbi_m.bgbi002 != g_bgbi002_t  OR g_bgbi_m.bgbi003 != g_bgbi003_t  OR g_bgbi_m.bgbi004 != g_bgbi004_t  OR g_bgbi_m.bgbi005 != g_bgbi005_t  OR g_bgbi_m.bgbi044 != g_bgbi044_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgbi_t WHERE "||"bgbient = '" ||g_enterprise|| "' AND "||"bgbi002 = '"||g_bgbi_m.bgbi002 ||"' AND "|| "bgbi003 = '"||g_bgbi_m.bgbi003 ||"' AND "|| "bgbi004 = '"||g_bgbi_m.bgbi004 ||"' AND "|| "bgbi005 = '"||g_bgbi_m.bgbi005 ||"' AND "|| "bgbi044 = '"||g_bgbi_m.bgbi044 ||"' AND "|| "bgbistus = '"||g_bgbi_m.bgbistus ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bgbi_m.bgbi002) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbi_m.bgbi002 != g_bgbi002_t OR g_bgbi002_t IS NULL )) THEN  #160822-00012#3 mark
               IF g_bgbi_m.bgbi002 !=  g_bgbi_m_o.bgbi002 OR  cl_null(g_bgbi_m_o.bgbi002) THEN  #160822-00012#3 add
                  LET g_bgbi_m.bgbi005 = NULL
                  LET g_bgbi_m.bgbi004 = NULL
                  CALL abgt027_bgbi002_bgbi005_bgbi004_chk(g_bgbi_m.bgbi002,g_bgbi_m.bgbi005,g_bgbi_m.bgbi004)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
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
                     #LET g_bgbi_m.bgbi002 = g_bgbi002_t        #160822-00012#3 mark
                     LET g_bgbi_m.bgbi002 = g_bgbi_m_o.bgbi002  #160822-00012#3 add
                     LET g_bgbi_m.bgbi002_desc = s_desc_get_budget_desc(g_bgbi_m.bgbi002)
                     DISPLAY BY NAME g_bgbi_m.bgbi002_desc,g_bgbi_m.bgbi002
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_bgbi_m.bgbi002) AND NOT cl_null(g_bgbi_m.bgbi003) AND
                     NOT cl_null(g_bgbi_m.bgbi004) AND NOT cl_null(g_bgbi_m.bgbi005) THEN
                     CALL abgt027_insert_chk(g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005)
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_bgbi_m.bgbi002 = g_bgbi002_t        #160822-00012#3 mark
                        LET g_bgbi_m.bgbi002 = g_bgbi_m_o.bgbi002  #160822-00012#3 add
                        LET g_bgbi_m.bgbi002_desc = s_desc_get_budget_desc(g_bgbi_m.bgbi002)
                        DISPLAY BY NAME g_bgbi_m.bgbi002_desc,g_bgbi_m.bgbi002
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_bgbi_m.bgbi002_desc = s_desc_get_budget_desc(g_bgbi_m.bgbi002)
                  DISPLAY BY NAME g_bgbi_m.bgbi002,g_bgbi_m.bgbi002_desc
      
                  INITIALIZE g_bgaa.* TO NULL
                  #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼/使用科目預算
                  SELECT bgaa002,bgaa003,bgaa008,bgaa009,bgaa012 INTO g_bgaa.*
                    FROM bgaa_t
                   WHERE bgaaent = g_enterprise
                     AND bgaa001 = g_bgbi_m.bgbi002
                  LET g_bgbi_m.l_bgaa002 = g_bgaa.bgaa002
                  LET g_bgbi_m.bgbi017 = g_bgaa.bgaa003
                  DISPLAY BY NAME g_bgbi_m.l_bgaa002,g_bgbi_m.bgbi017
                  #取得abgi200匯率
                  CALL s_abg_get_rate(g_bgbi_m.bgbi002,g_today,g_bgbi_m.bgbi017)RETURNING g_sub_success,g_errno,g_bgbi043
                  #設定顯示13期否
                  CALL abgt027_set_entry_period(g_bgaa.bgaa002)
                  IF NOT cl_null(g_bgbi_m.bgbi002) AND NOT cl_null(g_bgbi_m.bgbi045)THEN
                     #抓取樣表編號>>去abgi090取
                     SELECT bgai008 INTO g_bgbi_m.bgbi046
                       FROM bgai_t
                      WHERE bgaient = g_enterprise
                        AND bgai001 = g_bgbi_m.bgbi002
                        AND bgai002 = g_bgbi_m.bgbi045
                     DISPLAY BY NAME g_bgbi_m.bgbi046
                     IF NOT cl_null(g_bgbi_m.bgbi046) THEN
                        #依照樣表設定核算像欄位隱顯
                        CALL abgt027_set_entry_bgbi046(g_bgbi_m.bgbi002,g_bgbi_m.bgbi045,g_bgbi_m.bgbi046)
                     END IF
      
                     IF g_bgaa.bgaa012 = 'Y' THEN #使用科目預算
                        LET g_glac002 = g_bgbi_m.bgbi005
                     ELSE
                        CALL abgt027_get_bgao003(g_bgaa.bgaa008,g_bgbi_m.bgbi005)RETURNING g_glac002
                     END IF
                  END IF
               END IF
            END IF
            LET g_bgbi_m_o.* = g_bgbi_m.*  #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi002
            #add-point:BEFORE FIELD bgbi002 name="input.b.bgbi002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi002
            #add-point:ON CHANGE bgbi002 name="input.g.bgbi002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_bgbi_m.bgbi003,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bgbi003
            END IF 
 
 
 
            #add-point:AFTER FIELD bgbi003 name="input.a.bgbi003"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgbi_m.bgbi002) AND NOT cl_null(g_bgbi_m.bgbi003) AND NOT cl_null(g_bgbi_m.bgbi004) AND NOT cl_null(g_bgbi_m.bgbi005) AND NOT cl_null(g_bgbi_m.bgbi044) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgbi_m.bgbi002 != g_bgbi002_t  OR g_bgbi_m.bgbi003 != g_bgbi003_t  OR g_bgbi_m.bgbi004 != g_bgbi004_t  OR g_bgbi_m.bgbi005 != g_bgbi005_t  OR g_bgbi_m.bgbi044 != g_bgbi044_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgbi_t WHERE "||"bgbient = '" ||g_enterprise|| "' AND "||"bgbi002 = '"||g_bgbi_m.bgbi002 ||"' AND "|| "bgbi003 = '"||g_bgbi_m.bgbi003 ||"' AND "|| "bgbi004 = '"||g_bgbi_m.bgbi004 ||"' AND "|| "bgbi005 = '"||g_bgbi_m.bgbi005 ||"' AND "|| "bgbi044 = '"||g_bgbi_m.bgbi044 ||"' AND "|| "bgbistus = '"||g_bgbi_m.bgbistus ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bgbi_m.bgbi002) AND NOT cl_null(g_bgbi_m.bgbi003) AND
               NOT cl_null(g_bgbi_m.bgbi004) AND NOT cl_null(g_bgbi_m.bgbi005) THEN
               CALL abgt027_insert_chk(g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005)
                    RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_bgbi_m.bgbi003 = g_bgbi003_t
                  DISPLAY BY NAME g_bgbi_m.bgbi003
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi003
            #add-point:BEFORE FIELD bgbi003 name="input.b.bgbi003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi003
            #add-point:ON CHANGE bgbi003 name="input.g.bgbi003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi045
            
            #add-point:AFTER FIELD bgbi045 name="input.a.bgbi045"
            IF NOT cl_null(g_bgbi_m.bgbi045) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbi_m.bgbi045 != g_bgbi_m_t.bgbi045 OR g_bgbi_m_t.bgbi045 IS NULL )) THEN #160822-00012#3 mark
               IF g_bgbi_m.bgbi045 != g_bgbi_m_o.bgbi045 OR cl_null(g_bgbi_m_o.bgbi045) THEN   #160822-00012#3 add
                  CALL abgt027_bgbi002_bgbi005_bgbi004_chk(g_bgbi_m.bgbi002,g_bgbi_m.bgbi005,g_bgbi_m.bgbi045)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
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
                     #LET g_bgbi_m.bgbi045 = g_bgbi_m_t.bgbi045  #160822-00012#3 mark
                     LET g_bgbi_m.bgbi045 = g_bgbi_m_o.bgbi045   #160822-00012#3 add
                     LET g_bgbi_m.bgbi045_desc = s_desc_get_department_desc(g_bgbi_m.bgbi045)
                     DISPLAY BY NAME g_bgbi_m.bgbi045_desc,g_bgbi_m.bgbi045
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_bgbi_m.bgbi002) AND NOT cl_null(g_bgbi_m.bgbi045)THEN
                     #抓取樣表編號>>去abgi090取
                     SELECT bgai008 INTO g_bgbi_m.bgbi046
                       FROM bgai_t
                      WHERE bgaient = g_enterprise
                        AND bgai001 = g_bgbi_m.bgbi002
                        AND bgai002 = g_bgbi_m.bgbi045
                     DISPLAY BY NAME g_bgbi_m.bgbi046
                     IF NOT cl_null(g_bgbi_m.bgbi046) THEN
                        #依照樣表設定核算像欄位隱顯
                        CALL abgt027_set_entry_bgbi046(g_bgbi_m.bgbi002,g_bgbi_m.bgbi045,g_bgbi_m.bgbi046)
                     END IF
      
                     IF g_bgaa.bgaa012 = 'Y' THEN #使用科目預算
                        LET g_glac002 = g_bgbi_m.bgbi005
                     ELSE
                        CALL abgt027_get_bgao003(g_bgaa.bgaa008,g_bgbi_m.bgbi005)RETURNING g_glac002
                     END IF
                  END IF
                  
                  LET g_bgbi_m.bgbi045_desc = s_desc_get_department_desc(g_bgbi_m.bgbi045)
                  DISPLAY BY NAME g_bgbi_m.bgbi045_desc
               END IF
            END IF
            LET g_bgbi_m_o.* = g_bgbi_m.*  #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi045
            #add-point:BEFORE FIELD bgbi045 name="input.b.bgbi045"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi045
            #add-point:ON CHANGE bgbi045 name="input.g.bgbi045"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi004
            
            #add-point:AFTER FIELD bgbi004 name="input.a.bgbi004"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgbi_m.bgbi002) AND NOT cl_null(g_bgbi_m.bgbi003) AND NOT cl_null(g_bgbi_m.bgbi004) AND NOT cl_null(g_bgbi_m.bgbi005) AND NOT cl_null(g_bgbi_m.bgbi044) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgbi_m.bgbi002 != g_bgbi002_t  OR g_bgbi_m.bgbi003 != g_bgbi003_t  OR g_bgbi_m.bgbi004 != g_bgbi004_t  OR g_bgbi_m.bgbi005 != g_bgbi005_t  OR g_bgbi_m.bgbi044 != g_bgbi044_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgbi_t WHERE "||"bgbient = '" ||g_enterprise|| "' AND "||"bgbi002 = '"||g_bgbi_m.bgbi002 ||"' AND "|| "bgbi003 = '"||g_bgbi_m.bgbi003 ||"' AND "|| "bgbi004 = '"||g_bgbi_m.bgbi004 ||"' AND "|| "bgbi005 = '"||g_bgbi_m.bgbi005 ||"' AND "|| "bgbi044 = '"||g_bgbi_m.bgbi044 ||"' AND "|| "bgbistus = '"||g_bgbi_m.bgbistus ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bgbi_m.bgbi004) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbi_m.bgbi004 != g_bgbi_m_t.bgbi004 OR g_bgbi_m_t.bgbi004 IS NULL )) THEN  #160822-00012#3 mark
               IF g_bgbi_m.bgbi004 != g_bgbi_m_o.bgbi004 OR cl_null(g_bgbi_m_o.bgbi004) THEN  #160822-00012#3 add
                  CALL abgt027_bgbi002_bgbi005_bgbi004_chk(g_bgbi_m.bgbi002,g_bgbi_m.bgbi005,g_bgbi_m.bgbi004)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
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
                     #LET g_bgbi_m.bgbi004 = g_bgbi_m_t.bgbi004  #160822-00012#3 mark
                     LET g_bgbi_m.bgbi004 = g_bgbi_m_o.bgbi004   #160822-00012#3 add
                     LET g_bgbi_m.bgbi004_desc = s_desc_get_department_desc(g_bgbi_m.bgbi004)
                     DISPLAY BY NAME g_bgbi_m.bgbi004_desc,g_bgbi_m.bgbi004
                     NEXT FIELD CURRENT
                  END IF
                  
                  #161006-00005#11   add---s               
                  #call function 檢核輸入的組織是不是預算組織  有效否
                  CALL s_abg_bgaj002_chk(g_bgbi_m.bgbi004)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_bgbi_m.bgbi004 = g_bgbi_m_t.bgbi004  #160822-00012#3 mark
                     LET g_bgbi_m.bgbi004 = g_bgbi_m_o.bgbi004   #160822-00012#3 add
                     LET g_bgbi_m.bgbi004_desc = s_desc_get_department_desc(g_bgbi_m.bgbi004)
                     DISPLAY BY NAME g_bgbi_m.bgbi004_desc,g_bgbi_m.bgbi004
                     NEXT FIELD CURRENT 
                  END IF
                  
                  #檢核輸入的預算組織  是不是存在預算編號底下的組織               
                  CALL s_abg_site_chk(g_bgbi_m.bgbi004)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_bgbi_m.bgbi004 = g_bgbi_m_t.bgbi004  #160822-00012#3 mark
                     LET g_bgbi_m.bgbi004 = g_bgbi_m_o.bgbi004   #160822-00012#3 add
                     LET g_bgbi_m.bgbi004_desc = s_desc_get_department_desc(g_bgbi_m.bgbi004)
                     DISPLAY BY NAME g_bgbi_m.bgbi004_desc,g_bgbi_m.bgbi004
                     NEXT FIELD CURRENT  
                  END IF
                  
                  IF NOT cl_null(g_bgbi_m.bgbi002) THEN
                     LET l_cnt = 0
                     SELECT count(1) INTO l_cnt FROM bgaj_t
                      WHERE bgajent = g_enterprise
                        AND bgaj001 = g_bgbi_m.bgbi002
                        AND bgaj002 = g_bgbi_m.bgbi004
                        AND bgajstus = 'Y'
                        
                     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                     IF l_cnt = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "abg-00079"
                        LET g_errparam.extend = g_bgbi_m.bgbi002,"+",g_bgbi_m.bgbi004
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_bgbi_m.bgbi004 = g_bgbi_m_t.bgbi004  #160822-00012#3 mark
                        LET g_bgbi_m.bgbi004 = g_bgbi_m_o.bgbi004   #160822-00012#3 add
                     LET g_bgbi_m.bgbi004_desc = s_desc_get_department_desc(g_bgbi_m.bgbi004)
                     DISPLAY BY NAME g_bgbi_m.bgbi004_desc,g_bgbi_m.bgbi004
                     NEXT FIELD CURRENT 
                     END IF
                  END IF
                  #161006-00005#11   add---e
                  
                  IF NOT cl_null(g_bgbi_m.bgbi002) AND NOT cl_null(g_bgbi_m.bgbi003)
                     AND NOT cl_null(g_bgbi_m.bgbi004) AND NOT cl_null(g_bgbi_m.bgbi005)THEN
                     CALL abgt027_insert_chk(g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005)
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_bgbi_m.bgbi004 = g_bgbi_m_t.bgbi004  #160822-00012#3 mark
                        LET g_bgbi_m.bgbi004 = g_bgbi_m_o.bgbi004   #160822-00012#3 add
                        LET g_bgbi_m.bgbi004_desc = s_desc_get_department_desc(g_bgbi_m.bgbi004)
                        DISPLAY BY NAME g_bgbi_m.bgbi004_desc,g_bgbi_m.bgbi004
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  LET g_bgbi_m.bgbi004_desc = s_desc_get_department_desc(g_bgbi_m.bgbi004)
                  DISPLAY BY NAME g_bgbi_m.bgbi004_desc,g_bgbi_m.bgbi004
                  
                  LET g_glaald = NULL
                  CALL abgt027_ld_info(g_bgbi_m.bgbi004) RETURNING g_glaald
               END IF
            END IF
            LET g_bgbi_m_o.* = g_bgbi_m.*  #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi004
            #add-point:BEFORE FIELD bgbi004 name="input.b.bgbi004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi004
            #add-point:ON CHANGE bgbi004 name="input.g.bgbi004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi005
            
            #add-point:AFTER FIELD bgbi005 name="input.a.bgbi005"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_bgbi_m.bgbi002) AND NOT cl_null(g_bgbi_m.bgbi003) AND NOT cl_null(g_bgbi_m.bgbi004) AND NOT cl_null(g_bgbi_m.bgbi005) AND NOT cl_null(g_bgbi_m.bgbi044) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_bgbi_m.bgbi002 != g_bgbi002_t  OR g_bgbi_m.bgbi003 != g_bgbi003_t  OR g_bgbi_m.bgbi004 != g_bgbi004_t  OR g_bgbi_m.bgbi005 != g_bgbi005_t  OR g_bgbi_m.bgbi044 != g_bgbi044_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bgbi_t WHERE "||"bgbient = '" ||g_enterprise|| "' AND "||"bgbi002 = '"||g_bgbi_m.bgbi002 ||"' AND "|| "bgbi003 = '"||g_bgbi_m.bgbi003 ||"' AND "|| "bgbi004 = '"||g_bgbi_m.bgbi004 ||"' AND "|| "bgbi005 = '"||g_bgbi_m.bgbi005 ||"' AND "|| "bgbi044 = '"||g_bgbi_m.bgbi044 ||"' AND "|| "bgbistus = '"||g_bgbi_m.bgbistus ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_bgbi_m.bgbi005) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_bgbi_m.bgbi005 != g_bgbi_m_t.bgbi005 OR g_bgbi_m_t.bgbi005 IS NULL )) THEN #160822-00012#3 mark
               IF g_bgbi_m.bgbi005 != g_bgbi_m_o.bgbi005 OR cl_null(g_bgbi_m_o.bgbi005) THEN    #160822-00012#3 add
                  CALL abgt027_bgbi002_bgbi005_bgbi004_chk(g_bgbi_m.bgbi002,g_bgbi_m.bgbi005,g_bgbi_m.bgbi004)
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
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
                     #LET g_bgbi_m.bgbi005 = g_bgbi_m_t.bgbi005  #160822-00012#3 mark
                     LET g_bgbi_m.bgbi005 = g_bgbi_m_o.bgbi005   #160822-00012#3 add
                     LET g_bgbi_m.bgbi005_desc = s_abg_bgae001_desc(g_bgaa.bgaa008,g_bgbi_m.bgbi005)
                     DISPLAY BY NAME g_bgbi_m.bgbi005,g_bgbi_m.bgbi005_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_bgbi_m.bgbi002) AND NOT cl_null(g_bgbi_m.bgbi003)
                     AND NOT cl_null(g_bgbi_m.bgbi004) AND NOT cl_null(g_bgbi_m.bgbi005)THEN
                     CALL abgt027_insert_chk(g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005)
                          RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_bgbi_m.bgbi005 = g_bgbi_m_t.bgbi005  #160822-00012#3 mark
                        LET g_bgbi_m.bgbi005 = g_bgbi_m_o.bgbi005   #160822-00012#3 add
                        LET g_bgbi_m.bgbi005_desc = s_abg_bgae001_desc(g_bgaa.bgaa008,g_bgbi_m.bgbi005)
                        DISPLAY BY NAME g_bgbi_m.bgbi005,g_bgbi_m.bgbi005_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_bgbi_m.bgbi005_desc = s_abg_bgae001_desc(g_bgaa.bgaa008,g_bgbi_m.bgbi005)
                  DISPLAY BY NAME g_bgbi_m.bgbi005,g_bgbi_m.bgbi005_desc
               END IF
            END IF
            LET g_bgbi_m_o.* = g_bgbi_m.*  #160822-00012#3 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi005
            #add-point:BEFORE FIELD bgbi005 name="input.b.bgbi005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi005
            #add-point:ON CHANGE bgbi005 name="input.g.bgbi005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_bgaa002
            #add-point:BEFORE FIELD l_bgaa002 name="input.b.l_bgaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_bgaa002
            
            #add-point:AFTER FIELD l_bgaa002 name="input.a.l_bgaa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_bgaa002
            #add-point:ON CHANGE l_bgaa002 name="input.g.l_bgaa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi017
            #add-point:BEFORE FIELD bgbi017 name="input.b.bgbi017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi017
            
            #add-point:AFTER FIELD bgbi017 name="input.a.bgbi017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi017
            #add-point:ON CHANGE bgbi017 name="input.g.bgbi017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi046
            #add-point:BEFORE FIELD bgbi046 name="input.b.bgbi046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi046
            
            #add-point:AFTER FIELD bgbi046 name="input.a.bgbi046"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi046
            #add-point:ON CHANGE bgbi046 name="input.g.bgbi046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbistus
            #add-point:BEFORE FIELD bgbistus name="input.b.bgbistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbistus
            
            #add-point:AFTER FIELD bgbistus name="input.a.bgbistus"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbistus
            #add-point:ON CHANGE bgbistus name="input.g.bgbistus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgbi002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi002
            #add-point:ON ACTION controlp INFIELD bgbi002 name="input.c.bgbi002"
            #i開窗-預算編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_m.bgbi002
            LET g_qryparam.where = "bgaastus = 'Y' AND bgaa006 = '2' "   #不使用預測才可以開
            CALL q_bgaa001()
            LET g_bgbi_m.bgbi002 = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_m.bgbi002
            NEXT FIELD bgbi002
            #END add-point
 
 
         #Ctrlp:input.c.bgbi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi003
            #add-point:ON ACTION controlp INFIELD bgbi003 name="input.c.bgbi003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbi045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi045
            #add-point:ON ACTION controlp INFIELD bgbi045 name="input.c.bgbi045"
            #i開窗-管理組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_m.bgbi045
            LET g_qryparam.where = " bgai001 = '",g_bgbi_m.bgbi002,"' "
            CALL q_bgai002()
            LET g_bgbi_m.bgbi045 = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_m.bgbi045
            NEXT FIELD bgbi045
            #END add-point
 
 
         #Ctrlp:input.c.bgbi004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi004
            #add-point:ON ACTION controlp INFIELD bgbi004 name="input.c.bgbi004"
            #i開窗-預算組織
            #161006-00005#11  add----s
            CALL s_fin_abg_center_sons_query(g_bgbi_m.bgbi002,'','')
            CALL s_fin_account_center_sons_str() RETURNING l_orga 
            CALL s_fin_get_wc_str(l_orga) RETURNING l_orga
            #161006-00005#11  add----e
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_m.bgbi004
            LET g_qryparam.where = " ooef001 IN (SELECT bgaj002 FROM bgaj_t ",
                                   "              WHERE bgajent = ooefent AND bgajent = ",g_enterprise,
                                   "                AND bgaj001 = '",g_bgbi_m.bgbi002,"' AND bgajstus = 'Y') ",
                                   " AND ooef001 IN ",g_userorga   #161006-00005#11   add
            #161006-00005#11  add---s
            IF NOT cl_null(g_bgbi_m.bgbi002) THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED, " AND ooef001 IN ",l_orga
            END IF
            CALL q_ooef001_77()
            #161006-00005#11   add---e                      
            #CALL q_ooef001()   #161006-00005#11   mark
            LET g_bgbi_m.bgbi004 = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_m.bgbi004
            NEXT FIELD bgbi004
            #END add-point
 
 
         #Ctrlp:input.c.bgbi005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi005
            #add-point:ON ACTION controlp INFIELD bgbi005 name="input.c.bgbi005"
            #i開窗-預算細項
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_m.bgbi005
            IF g_bgaa.bgaa012 = 'Y' THEN
               #抓取會計科目
               LET g_qryparam.where = " glac001 = '",g_bgaa.bgaa008,"' AND  glac003 <>'1' ", #glac001(會計科目參照表)/glac003(科>
                                      " AND glac002 IN (SELECT bgay003 FROM bgay_t ",        #存在可用樣表設定
                                      "                  WHERE bgayent = ",g_enterprise,
                                      "                    AND bgay001 = '",g_bgbi_m.bgbi002,"' ",
                                      "                    AND bgaystus = 'Y')  "
               CALL aglt310_04()
            ELSE
               #抓取預算項目
               LET g_qryparam.where = " bgae006 IN (SELECT bgaa008 FROM bgaa_t ",
                                      "              WHERE bgaaent = ",g_enterprise,
                                      "                AND bgaa001 = '",g_bgbi_m.bgbi002,"') ", #存在預算編號的預算項目參照表
                                      " AND bgae001 IN (SELECT bgay003 FROM bgay_t ",           #存在可用樣表設定
                                      "                  WHERE bgayent = ",g_enterprise,
                                      "                    AND bgay001 = '",g_bgbi_m.bgbi002,"' ",
                                      "                    AND bgaystus = 'Y')"
               CALL q_bgae001()
            END IF
            LET g_bgbi_m.bgbi005 = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_m.bgbi005
            NEXT FIELD bgbi005
            #END add-point
 
 
         #Ctrlp:input.c.l_bgaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_bgaa002
            #add-point:ON ACTION controlp INFIELD l_bgaa002 name="input.c.l_bgaa002"
 
            #END add-point
 
 
         #Ctrlp:input.c.bgbi017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi017
            #add-point:ON ACTION controlp INFIELD bgbi017 name="input.c.bgbi017"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbi046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi046
            #add-point:ON ACTION controlp INFIELD bgbi046 name="input.c.bgbi046"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbistus
            #add-point:ON ACTION controlp INFIELD bgbistus name="input.c.bgbistus"
            
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
            DISPLAY BY NAME g_bgbi_m.bgbi002             
                            ,g_bgbi_m.bgbi003   
                            ,g_bgbi_m.bgbi004   
                            ,g_bgbi_m.bgbi005   
                            ,g_bgbi_m.bgbi044   
                            ,g_bgbi_m.bgbistus   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
 
               #end add-point
            
               #將遮罩欄位還原
               CALL abgt027_bgbi_t_mask_restore('restore_mask_o')
            
               UPDATE bgbi_t SET (bgbi002,bgbi003,bgbi045,bgbi004,bgbi005,bgbi017,bgbi046,bgbi044,bgbistus) = (g_bgbi_m.bgbi002, 
                   g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi017, 
                   g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus)
                WHERE bgbient = g_enterprise AND bgbi002 = g_bgbi002_t
                  AND bgbi003 = g_bgbi003_t
                  AND bgbi004 = g_bgbi004_t
                  AND bgbi005 = g_bgbi005_t
                  AND bgbi044 = g_bgbi044_t
                  AND bgbistus = g_bgbistus_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgbi_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgbi_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgbi_m.bgbi002
               LET gs_keys_bak[1] = g_bgbi002_t
               LET gs_keys[2] = g_bgbi_m.bgbi003
               LET gs_keys_bak[2] = g_bgbi003_t
               LET gs_keys[3] = g_bgbi_m.bgbi004
               LET gs_keys_bak[3] = g_bgbi004_t
               LET gs_keys[4] = g_bgbi_m.bgbi005
               LET gs_keys_bak[4] = g_bgbi005_t
               LET gs_keys[5] = g_bgbi_m.bgbi044
               LET gs_keys_bak[5] = g_bgbi044_t
               LET gs_keys[6] = g_bgbi_m.bgbistus
               LET gs_keys_bak[6] = g_bgbistus_t
               LET gs_keys[7] = g_bgbi_d[g_detail_idx].bgbiseq
               LET gs_keys_bak[7] = g_bgbi_d_t.bgbiseq
               CALL abgt027_update_b('bgbi_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_bgbi_m_t)
                     #LET g_log2 = util.JSON.stringify(g_bgbi_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL abgt027_bgbi_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL abgt027_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_bgbi002_t = g_bgbi_m.bgbi002
           LET g_bgbi003_t = g_bgbi_m.bgbi003
           LET g_bgbi004_t = g_bgbi_m.bgbi004
           LET g_bgbi005_t = g_bgbi_m.bgbi005
           LET g_bgbi044_t = g_bgbi_m.bgbi044
           LET g_bgbistus_t = g_bgbi_m.bgbistus
 
           
           IF g_bgbi_d.getLength() = 0 THEN
              NEXT FIELD bgbiseq
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="abgt027.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_bgbi_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION abgt027_02
            LET g_action_choice="abgt027_02"
            IF cl_auth_chk_act("abgt027_02") THEN
               
               #add-point:ON ACTION abgt027_02 name="input.detail_input.page1.abgt027_02"
               #預算總額分配至單一項次
               
               #先找出目前是哪一筆的條件
               LET l_wc = " 1=1 "
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi038) THEN LET l_wc = l_wc, " AND bgbi038 = '",g_bgbi_d[g_detail_idx].bgbi038,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi007) THEN LET l_wc = l_wc, " AND bgbi007 = '",g_bgbi_d[g_detail_idx].bgbi007,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi008) THEN LET l_wc = l_wc, " AND bgbi008 = '",g_bgbi_d[g_detail_idx].bgbi008,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi009) THEN LET l_wc = l_wc, " AND bgbi009 = '",g_bgbi_d[g_detail_idx].bgbi009,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi010) THEN LET l_wc = l_wc, " AND bgbi010 = '",g_bgbi_d[g_detail_idx].bgbi010,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi011) THEN LET l_wc = l_wc, " AND bgbi011 = '",g_bgbi_d[g_detail_idx].bgbi011,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi012) THEN LET l_wc = l_wc, " AND bgbi012 = '",g_bgbi_d[g_detail_idx].bgbi012,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi013) THEN LET l_wc = l_wc, " AND bgbi013 = '",g_bgbi_d[g_detail_idx].bgbi013,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi014) THEN LET l_wc = l_wc, " AND bgbi014 = '",g_bgbi_d[g_detail_idx].bgbi014,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi015) THEN LET l_wc = l_wc, " AND bgbi015 = '",g_bgbi_d[g_detail_idx].bgbi015,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi016) THEN LET l_wc = l_wc, " AND bgbi016 = '",g_bgbi_d[g_detail_idx].bgbi016,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi039) THEN LET l_wc = l_wc, " AND bgbi039 = '",g_bgbi_d[g_detail_idx].bgbi039,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi040) THEN LET l_wc = l_wc, " AND bgbi040 = '",g_bgbi_d[g_detail_idx].bgbi040,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi041) THEN LET l_wc = l_wc, " AND bgbi041 = '",g_bgbi_d[g_detail_idx].bgbi041,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi028) THEN LET l_wc = l_wc, " AND bgbi028 = '",g_bgbi_d[g_detail_idx].bgbi028,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi029) THEN LET l_wc = l_wc, " AND bgbi029 = '",g_bgbi_d[g_detail_idx].bgbi029,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi030) THEN LET l_wc = l_wc, " AND bgbi030 = '",g_bgbi_d[g_detail_idx].bgbi030,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi031) THEN LET l_wc = l_wc, " AND bgbi031 = '",g_bgbi_d[g_detail_idx].bgbi031,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi032) THEN LET l_wc = l_wc, " AND bgbi032 = '",g_bgbi_d[g_detail_idx].bgbi032,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi033) THEN LET l_wc = l_wc, " AND bgbi033 = '",g_bgbi_d[g_detail_idx].bgbi033,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi034) THEN LET l_wc = l_wc, " AND bgbi034 = '",g_bgbi_d[g_detail_idx].bgbi034,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi035) THEN LET l_wc = l_wc, " AND bgbi035 = '",g_bgbi_d[g_detail_idx].bgbi035,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi036) THEN LET l_wc = l_wc, " AND bgbi036 = '",g_bgbi_d[g_detail_idx].bgbi036,"'" END IF
               IF NOT cl_null(g_bgbi_d[g_detail_idx].bgbi037) THEN LET l_wc = l_wc, " AND bgbi037 = '",g_bgbi_d[g_detail_idx].bgbi037,"'" END IF
               
               CALL s_transaction_begin()
               CALL abgt027_01('B',g_detail_idx,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbistus,l_wc)
                    RETURNING g_sub_success
               IF g_sub_success THEN
                  CALL s_transaction_end('Y',0)
                  CALL abgt027_show()
               ELSE
                  CALL s_transaction_end('N',0)
               END IF
               LET l_tran_flag = 'Y'
               LET l_flag = 'Y'
               EXIT DIALOG
               #END add-point
            END IF
 
 
 
 
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_bgbi_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL abgt027_b_fill(g_wc2) #test 
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
            CALL abgt027_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN abgt027_cl USING g_enterprise,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE abgt027_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt027_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_bgbi_d[l_ac].bgbiseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_bgbi_d_t.* = g_bgbi_d[l_ac].*  #BACKUP
               LET g_bgbi_d_o.* = g_bgbi_d[l_ac].*  #BACKUP
               CALL abgt027_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               CALL abgt027_set_no_entry_b(l_cmd)
               OPEN abgt027_bcl USING g_enterprise,g_bgbi_m.bgbi002,
                                                g_bgbi_m.bgbi003,
                                                g_bgbi_m.bgbi004,
                                                g_bgbi_m.bgbi005,
                                                g_bgbi_m.bgbi044,
                                                g_bgbi_m.bgbistus,
 
                                                g_bgbi_d_t.bgbiseq
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt027_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt027_bcl INTO
                     g_bgbi_d[l_ac].bgbiseq,g_bgbi_d[l_ac].bgbi038_desc,
                     g_bgbi_d[l_ac].bgbi007_desc,g_bgbi_d[l_ac].bgbi008_desc,g_bgbi_d[l_ac].bgbi009_desc,g_bgbi_d[l_ac].bgbi010_desc,
                     g_bgbi_d[l_ac].bgbi011_desc,g_bgbi_d[l_ac].bgbi012_desc,g_bgbi_d[l_ac].bgbi013_desc,g_bgbi_d[l_ac].bgbi014_desc,g_bgbi_d[l_ac].bgbi015_desc,
                     g_bgbi_d[l_ac].bgbi016_desc,g_bgbi_d[l_ac].bgbi039_desc,g_bgbi_d[l_ac].bgbi040_desc,g_bgbi_d[l_ac].bgbi041_desc,
                     g_bgbi_d[l_ac].bgbi028_desc,g_bgbi_d[l_ac].bgbi029_desc,g_bgbi_d[l_ac].bgbi030_desc,g_bgbi_d[l_ac].bgbi031_desc,g_bgbi_d[l_ac].bgbi032_desc,
                     g_bgbi_d[l_ac].bgbi033_desc,g_bgbi_d[l_ac].bgbi034_desc,g_bgbi_d[l_ac].bgbi035_desc,g_bgbi_d[l_ac].bgbi036_desc,g_bgbi_d[l_ac].bgbi037_desc,
                     g_bgbi_d[l_ac].bgbi023,g_bgbi_d[l_ac].bgbi0232,g_bgbi_d[l_ac].bgbi0233,g_bgbi_d[l_ac].bgbi0234,g_bgbi_d[l_ac].bgbi0235,
                     g_bgbi_d[l_ac].bgbi0236,g_bgbi_d[l_ac].bgbi0237,g_bgbi_d[l_ac].bgbi0238,g_bgbi_d[l_ac].bgbi0239,g_bgbi_d[l_ac].bgbi02310,
                     g_bgbi_d[l_ac].bgbi02311,g_bgbi_d[l_ac].bgbi02312,g_bgbi_d[l_ac].bgbi02313,g_bgbi_d[l_ac].l_sum
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_bgbi_d_t.bgbiseq,":",SQLERRMESSAGE
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  #遮罩相關處理
                  LET g_bgbi_d_mask_o[l_ac].* =  g_bgbi_d[l_ac].*
                  CALL abgt027_bgbi_t_mask()
                  LET g_bgbi_d_mask_n[l_ac].* =  g_bgbi_d[l_ac].*
                  
                  CALL abgt027_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
         IF g_bgbi_m.bgbi044 = "PASS" THEN
            IF g_rec_b >= l_ac 
               AND g_bgbi_d[l_ac].bgbiseq IS NOT NULL
 
            THEN
               #end add-point
               CALL abgt027_set_no_entry_b(l_cmd)
               OPEN abgt027_bcl USING g_enterprise,g_bgbi_m.bgbi002,
                                                g_bgbi_m.bgbi003,
                                                g_bgbi_m.bgbi004,
                                                g_bgbi_m.bgbi005,
                                                g_bgbi_m.bgbi044,
                                                g_bgbi_m.bgbistus,
 
                                                g_bgbi_d_t.bgbiseq
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN abgt027_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH abgt027_bcl INTO g_bgbi_d[l_ac].bgbiseq,g_bgbi_d[l_ac].bgbi038,g_bgbi_d[l_ac].bgbi007, 
                      g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi009,g_bgbi_d[l_ac].bgbi010,g_bgbi_d[l_ac].bgbi011, 
                      g_bgbi_d[l_ac].bgbi012,g_bgbi_d[l_ac].bgbi013,g_bgbi_d[l_ac].bgbi014,g_bgbi_d[l_ac].bgbi015, 
                      g_bgbi_d[l_ac].bgbi016,g_bgbi_d[l_ac].bgbi039,g_bgbi_d[l_ac].bgbi040,g_bgbi_d[l_ac].bgbi041, 
                      g_bgbi_d[l_ac].bgbi028,g_bgbi_d[l_ac].bgbi029,g_bgbi_d[l_ac].bgbi030,g_bgbi_d[l_ac].bgbi031, 
                      g_bgbi_d[l_ac].bgbi032,g_bgbi_d[l_ac].bgbi033,g_bgbi_d[l_ac].bgbi034,g_bgbi_d[l_ac].bgbi035, 
                      g_bgbi_d[l_ac].bgbi036,g_bgbi_d[l_ac].bgbi037,g_bgbi_d[l_ac].bgbi023,g_bgbi2_d[l_ac].bgbiseq, 
                      g_bgbi2_d[l_ac].bgbiownid,g_bgbi2_d[l_ac].bgbiowndp,g_bgbi2_d[l_ac].bgbicrtid, 
                      g_bgbi2_d[l_ac].bgbicrtdp,g_bgbi2_d[l_ac].bgbicrtdt,g_bgbi2_d[l_ac].bgbimodid, 
                      g_bgbi2_d[l_ac].bgbimoddt,g_bgbi2_d[l_ac].bgbicnfid,g_bgbi2_d[l_ac].bgbicnfdt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_bgbi_d_t.bgbiseq,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_bgbi_d_mask_o[l_ac].* =  g_bgbi_d[l_ac].*
                  CALL abgt027_bgbi_t_mask()
                  LET g_bgbi_d_mask_n[l_ac].* =  g_bgbi_d[l_ac].*
                  
                  CALL abgt027_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
         END IF
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_bgbi_d_t.* TO NULL
            INITIALIZE g_bgbi_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_bgbi_d[l_ac].* TO NULL
            #公用欄位預設值
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_bgbi2_d[l_ac].bgbiownid = g_user
      LET g_bgbi2_d[l_ac].bgbiowndp = g_dept
      LET g_bgbi2_d[l_ac].bgbicrtid = g_user
      LET g_bgbi2_d[l_ac].bgbicrtdp = g_dept 
      LET g_bgbi2_d[l_ac].bgbicrtdt = cl_get_current()
      LET g_bgbi2_d[l_ac].bgbimodid = g_user
      LET g_bgbi2_d[l_ac].bgbimoddt = cl_get_current()
 
 
  
            #一般欄位預設值
                  LET g_bgbi_d[l_ac].bgbi023 = "0"
      LET g_bgbi_d[l_ac].bgbi0232 = "0"
      LET g_bgbi_d[l_ac].bgbi0233 = "0"
      LET g_bgbi_d[l_ac].bgbi0234 = "0"
      LET g_bgbi_d[l_ac].bgbi0235 = "0"
      LET g_bgbi_d[l_ac].bgbi0236 = "0"
      LET g_bgbi_d[l_ac].bgbi0237 = "0"
      LET g_bgbi_d[l_ac].bgbi0238 = "0"
      LET g_bgbi_d[l_ac].bgbi0239 = "0"
      LET g_bgbi_d[l_ac].bgbi02310 = "0"
      LET g_bgbi_d[l_ac].bgbi02311 = "0"
      LET g_bgbi_d[l_ac].bgbi02312 = "0"
      LET g_bgbi_d[l_ac].bgbi02313 = "0"
      LET g_bgbi_d[l_ac].l_sum = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
            #項次
            SELECT MAX(bgbiseq)+1 INTO g_bgbi_d[l_ac].bgbiseq
               FROM abgt027_tmp
              WHERE bgbi002 = g_bgbi_m.bgbi002
                AND bgbi003 = g_bgbi_m.bgbi003
                AND bgbi004 = g_bgbi_m.bgbi004
                AND bgbi005 = g_bgbi_m.bgbi005
                AND bgbi044 = '1'
                AND bgbistus = g_bgbi_m.bgbistus
            IF cl_null(g_bgbi_d[l_ac].bgbiseq)THEN LET g_bgbi_d[l_ac].bgbiseq = 1 END IF
            #預待現金變動碼
            CALL abgt027_get_bgbi038(g_bgaa.bgaa008,g_bgbi_m.bgbi005) RETURNING g_bgbi_d[l_ac].bgbi038
            #end add-point
            LET g_bgbi_d_t.* = g_bgbi_d[l_ac].*     #新輸入資料
            LET g_bgbi_d_o.* = g_bgbi_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL abgt027_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL abgt027_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_bgbi_d[li_reproduce_target].* = g_bgbi_d[li_reproduce].*
               LET g_bgbi2_d[li_reproduce_target].* = g_bgbi2_d[li_reproduce].*
 
               LET g_bgbi_d[g_bgbi_d.getLength()].bgbiseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM bgbi_t 
             WHERE bgbient = g_enterprise AND bgbi002 = g_bgbi_m.bgbi002
               AND bgbi003 = g_bgbi_m.bgbi003
               AND bgbi004 = g_bgbi_m.bgbi004
               AND bgbi005 = g_bgbi_m.bgbi005
               AND bgbi044 = g_bgbi_m.bgbi044
               AND bgbistus = g_bgbi_m.bgbistus
 
               AND bgbiseq = g_bgbi_d[l_ac].bgbiseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               #新增/修改/刪除先寫入temptalbe
               IF g_bgbi_m.bgbi044 = "PASS" THEN
               #end add-point
               INSERT INTO bgbi_t
                           (bgbient,
                            bgbi002,bgbi003,bgbi045,bgbi004,bgbi005,bgbi017,bgbi046,bgbi044,bgbistus,
                            bgbiseq
                            ,bgbi038,bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,bgbi012,bgbi013,bgbi014,bgbi015,bgbi016,bgbi039,bgbi040,bgbi041,bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,bgbi033,bgbi034,bgbi035,bgbi036,bgbi037,bgbi023,bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,bgbicrtdt,bgbimodid,bgbimoddt,bgbicnfid,bgbicnfdt) 
                     VALUES(g_enterprise,
                            g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus,
                            g_bgbi_d[l_ac].bgbiseq
                            ,g_bgbi_d[l_ac].bgbi038,g_bgbi_d[l_ac].bgbi007,g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi009, 
                                g_bgbi_d[l_ac].bgbi010,g_bgbi_d[l_ac].bgbi011,g_bgbi_d[l_ac].bgbi012, 
                                g_bgbi_d[l_ac].bgbi013,g_bgbi_d[l_ac].bgbi014,g_bgbi_d[l_ac].bgbi015, 
                                g_bgbi_d[l_ac].bgbi016,g_bgbi_d[l_ac].bgbi039,g_bgbi_d[l_ac].bgbi040, 
                                g_bgbi_d[l_ac].bgbi041,g_bgbi_d[l_ac].bgbi028,g_bgbi_d[l_ac].bgbi029, 
                                g_bgbi_d[l_ac].bgbi030,g_bgbi_d[l_ac].bgbi031,g_bgbi_d[l_ac].bgbi032, 
                                g_bgbi_d[l_ac].bgbi033,g_bgbi_d[l_ac].bgbi034,g_bgbi_d[l_ac].bgbi035, 
                                g_bgbi_d[l_ac].bgbi036,g_bgbi_d[l_ac].bgbi037,g_bgbi_d[l_ac].bgbi023, 
                                g_bgbi2_d[l_ac].bgbiownid,g_bgbi2_d[l_ac].bgbiowndp,g_bgbi2_d[l_ac].bgbicrtid, 
                                g_bgbi2_d[l_ac].bgbicrtdp,g_bgbi2_d[l_ac].bgbicrtdt,g_bgbi2_d[l_ac].bgbimodid, 
                                g_bgbi2_d[l_ac].bgbimoddt,g_bgbi2_d[l_ac].bgbicnfid,g_bgbi2_d[l_ac].bgbicnfdt) 
 
               #add-point:單身新增中 name="input.body.m_insert"
               END IF
               CALL s_transaction_end('N','0')
            END IF
            
               
            #新增寫入temptable
            LET l_count = 1
            LET l_wc = " 1=1 "
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi038) THEN LET l_wc = l_wc, " AND bgbi038 = '",g_bgbi_d[l_ac].bgbi038,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi007) THEN LET l_wc = l_wc, " AND bgbi007 = '",g_bgbi_d[l_ac].bgbi007,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi008) THEN LET l_wc = l_wc, " AND bgbi008 = '",g_bgbi_d[l_ac].bgbi008,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi009) THEN LET l_wc = l_wc, " AND bgbi009 = '",g_bgbi_d[l_ac].bgbi009,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi010) THEN LET l_wc = l_wc, " AND bgbi010 = '",g_bgbi_d[l_ac].bgbi010,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi011) THEN LET l_wc = l_wc, " AND bgbi011 = '",g_bgbi_d[l_ac].bgbi011,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi012) THEN LET l_wc = l_wc, " AND bgbi012 = '",g_bgbi_d[l_ac].bgbi012,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi013) THEN LET l_wc = l_wc, " AND bgbi013 = '",g_bgbi_d[l_ac].bgbi013,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi014) THEN LET l_wc = l_wc, " AND bgbi014 = '",g_bgbi_d[l_ac].bgbi014,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi015) THEN LET l_wc = l_wc, " AND bgbi015 = '",g_bgbi_d[l_ac].bgbi015,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi016) THEN LET l_wc = l_wc, " AND bgbi016 = '",g_bgbi_d[l_ac].bgbi016,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi039) THEN LET l_wc = l_wc, " AND bgbi039 = '",g_bgbi_d[l_ac].bgbi039,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi040) THEN LET l_wc = l_wc, " AND bgbi040 = '",g_bgbi_d[l_ac].bgbi040,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi041) THEN LET l_wc = l_wc, " AND bgbi041 = '",g_bgbi_d[l_ac].bgbi041,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi028) THEN LET l_wc = l_wc, " AND bgbi028 = '",g_bgbi_d[l_ac].bgbi028,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi029) THEN LET l_wc = l_wc, " AND bgbi029 = '",g_bgbi_d[l_ac].bgbi029,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi030) THEN LET l_wc = l_wc, " AND bgbi030 = '",g_bgbi_d[l_ac].bgbi030,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi031) THEN LET l_wc = l_wc, " AND bgbi031 = '",g_bgbi_d[l_ac].bgbi031,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi032) THEN LET l_wc = l_wc, " AND bgbi032 = '",g_bgbi_d[l_ac].bgbi032,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi033) THEN LET l_wc = l_wc, " AND bgbi033 = '",g_bgbi_d[l_ac].bgbi033,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi034) THEN LET l_wc = l_wc, " AND bgbi034 = '",g_bgbi_d[l_ac].bgbi034,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi035) THEN LET l_wc = l_wc, " AND bgbi035 = '",g_bgbi_d[l_ac].bgbi035,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi036) THEN LET l_wc = l_wc, " AND bgbi036 = '",g_bgbi_d[l_ac].bgbi036,"'" END IF
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi037) THEN LET l_wc = l_wc, " AND bgbi037 = '",g_bgbi_d[l_ac].bgbi037,"'" END IF
            
            LET l_sql = "SELECT COUNT(1) FROM abgt027_tmp",
                        " WHERE bgbient = ",g_enterprise,
                        "   AND bgbi002 = '",g_bgbi_m.bgbi002,"'",
                        "   AND bgbi003 = '",g_bgbi_m.bgbi003,"'",
                        "   AND bgbi004 = '",g_bgbi_m.bgbi004,"'",
                        "   AND bgbi005 = '",g_bgbi_m.bgbi005,"'",
                        "   AND bgbi044 = '",g_bgbi_m.bgbi044,"'",
                        "   AND bgbistus = '",g_bgbi_m.bgbistus,"'",
                        "   AND ",l_wc
            PREPARE abgt027_tmp_pb1 FROM l_sql
            EXECUTE abgt027_tmp_pb1 INTO l_count
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               CALL s_transaction_begin()
               INSERT INTO abgt027_tmp (bgbient,bgbiseq,bgbi002,bgbi003,bgbi045,
                                        bgbi004,bgbi005,bgbi017,bgbi046,bgbi044,
                                        bgbi007,bgbi008,bgbi009,bgbi010,
                                        bgbi011,bgbi012,bgbi013,bgbi014,bgbi015,
                                        bgbi016,bgbi039,bgbi040,bgbi041,
                                        bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,
                                        bgbi033,bgbi034,bgbi035,bgbi036,bgbi037,
                                        bgbi023,bgbi0232,bgbi0233,bgbi0234,bgbi0235,
                                        bgbi0236,bgbi0237,bgbi0238,bgbi0239,bgbi02310,
                                        bgbi02311,bgbi02312,bgbi02313,l_sum,
                                        bgbi038,bgbistus,
                                        bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,bgbicrtdt,
                                        bgbimodid,bgbimoddt
                                       )
               VALUES (g_enterprise,g_bgbi_d[l_ac].bgbiseq,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,
                       g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,'1',
                       g_bgbi_d[l_ac].bgbi007,g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi009,g_bgbi_d[l_ac].bgbi010,
                       g_bgbi_d[l_ac].bgbi011,g_bgbi_d[l_ac].bgbi012,g_bgbi_d[l_ac].bgbi013,g_bgbi_d[l_ac].bgbi014,g_bgbi_d[l_ac].bgbi015,
                       g_bgbi_d[l_ac].bgbi016,g_bgbi_d[l_ac].bgbi039,g_bgbi_d[l_ac].bgbi040,g_bgbi_d[l_ac].bgbi041,
                       g_bgbi_d[l_ac].bgbi028,g_bgbi_d[l_ac].bgbi029,g_bgbi_d[l_ac].bgbi030,g_bgbi_d[l_ac].bgbi031,g_bgbi_d[l_ac].bgbi032,
                       g_bgbi_d[l_ac].bgbi033,g_bgbi_d[l_ac].bgbi034,g_bgbi_d[l_ac].bgbi035,g_bgbi_d[l_ac].bgbi036,g_bgbi_d[l_ac].bgbi037,
                       g_bgbi_d[l_ac].bgbi023,g_bgbi_d[l_ac].bgbi0232,g_bgbi_d[l_ac].bgbi0233,g_bgbi_d[l_ac].bgbi0234,g_bgbi_d[l_ac].bgbi0235,
                       g_bgbi_d[l_ac].bgbi0236,g_bgbi_d[l_ac].bgbi0237,g_bgbi_d[l_ac].bgbi0238,g_bgbi_d[l_ac].bgbi0239,g_bgbi_d[l_ac].bgbi02310,
                       g_bgbi_d[l_ac].bgbi02311,g_bgbi_d[l_ac].bgbi02312,g_bgbi_d[l_ac].bgbi02313,g_bgbi_d[l_ac].l_sum,
                       g_bgbi_d[l_ac].bgbi038,'N',
                       g_bgbi2_d[l_ac].bgbiownid,g_bgbi2_d[l_ac].bgbiowndp,g_bgbi2_d[l_ac].bgbicrtid,g_bgbi2_d[l_ac].bgbicrtdp,g_bgbi2_d[l_ac].bgbicrtdt, 
                       g_bgbi2_d[l_ac].bgbimodid,g_bgbi2_d[l_ac].bgbimoddt
                      )
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_bgbi_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "bgbi_t:",SQLERRMESSAGE 
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
               IF abgt027_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_bgbi_m.bgbi002
                  LET gs_keys[gs_keys.getLength()+1] = g_bgbi_m.bgbi003
                  LET gs_keys[gs_keys.getLength()+1] = g_bgbi_m.bgbi004
                  LET gs_keys[gs_keys.getLength()+1] = g_bgbi_m.bgbi005
                  LET gs_keys[gs_keys.getLength()+1] = g_bgbi_m.bgbi044
                  LET gs_keys[gs_keys.getLength()+1] = g_bgbi_m.bgbistus
 
                  LET gs_keys[gs_keys.getLength()+1] = g_bgbi_d_t.bgbiseq
 
 
                  #刪除下層單身
                  IF NOT abgt027_key_delete_b(gs_keys,'bgbi_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE abgt027_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE abgt027_bcl
               LET l_count = g_bgbi_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_bgbi_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi038
            #add-point:BEFORE FIELD bgbi038 name="input.b.page1.bgbi038"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi038
            
            #add-point:AFTER FIELD bgbi038 name="input.a.page1.bgbi038"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi038
            #add-point:ON CHANGE bgbi038 name="input.g.page1.bgbi038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi038_desc
            #add-point:BEFORE FIELD bgbi038_desc name="input.b.page1.bgbi038_desc"
            LET g_bgbi_d[l_ac].bgbi038_desc = g_bgbi_d[l_ac].bgbi038
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi038_desc
            
            #add-point:AFTER FIELD bgbi038_desc name="input.a.page1.bgbi038_desc"
            #現金變動碼
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi038_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi038_desc != g_bgbi_d_t.bgbi038_desc OR g_bgbi_d_t.bgbi038_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi038 = g_bgbi_d[l_ac].bgbi038_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi038 != g_bgbi_d_t.bgbi038 OR g_bgbi_d_t.bgbi038 IS NULL) THEN
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_bgbi_d[l_ac].bgbi038
                        LET g_chkparam.arg2 = g_bgaa.bgaa009
                        IF NOT cl_chk_exist("v_nmai002") THEN
                           LET g_bgbi_d[l_ac].bgbi038      = g_bgbi_d_t.bgbi038
                           LET g_bgbi_d[l_ac].bgbi038_desc = g_bgbi_d_t.bgbi038_desc
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi038,g_bgbi_d[l_ac].bgbi038_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi038 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi038_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi038,s_desc_get_nmail004_desc(g_bgaa.bgaa009,g_bgbi_d[l_ac].bgbi038))
            LET g_bgbi_d_t.bgbi038 = g_bgbi_d[l_ac].bgbi038_desc
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi038,g_bgbi_d[l_ac].bgbi038_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi038_desc
            #add-point:ON CHANGE bgbi038_desc name="input.g.page1.bgbi038_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi007
            #add-point:BEFORE FIELD bgbi007 name="input.b.page1.bgbi007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi007
            
            #add-point:AFTER FIELD bgbi007 name="input.a.page1.bgbi007"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi007
            #add-point:ON CHANGE bgbi007 name="input.g.page1.bgbi007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi007_desc
            #add-point:BEFORE FIELD bgbi007_desc name="input.b.page1.bgbi007_desc"
            LET g_bgbi_d[l_ac].bgbi007_desc = g_bgbi_d[l_ac].bgbi007
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi007_desc
            
            #add-point:AFTER FIELD bgbi007_desc name="input.a.page1.bgbi007_desc"
            #部門
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi007_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi007_desc != g_bgbi_d_t.bgbi007_desc OR g_bgbi_d_t.bgbi007_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi007 = g_bgbi_d[l_ac].bgbi007_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi007 != g_bgbi_d_t.bgbi007 OR g_bgbi_d_t.bgbi007 IS NULL) THEN
                        CALL s_department_chk(g_bgbi_d[l_ac].bgbi007_desc,g_today) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_bgbi_d[l_ac].bgbi007 = g_bgbi_d_t.bgbi007
                           LET g_bgbi_d[l_ac].bgbi007_desc = g_bgbi_d_t.bgbi007_desc
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi007 ,g_bgbi_d[l_ac].bgbi007_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
                  #取責任中心
                  CALL s_department_get_respon_center(g_bgbi_d[l_ac].bgbi007,g_today)
                       RETURNING g_sub_success,g_errno,g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi008_desc
                  LET g_bgbi_d[l_ac].bgbi008_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi008_desc)
                  LET g_bgbi_d_t.bgbi008_desc = g_bgbi_d[l_ac].bgbi008_desc
                  DISPLAY BY NAME g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi008_desc
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi007 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi007_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi007,s_desc_get_department_desc(g_bgbi_d[l_ac].bgbi007))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi007 ,g_bgbi_d[l_ac].bgbi007_desc
            LET g_bgbi_d_t.bgbi007_desc = g_bgbi_d[l_ac].bgbi007_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi007_desc
            #add-point:ON CHANGE bgbi007_desc name="input.g.page1.bgbi007_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi008
            #add-point:BEFORE FIELD bgbi008 name="input.b.page1.bgbi008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi008
            
            #add-point:AFTER FIELD bgbi008 name="input.a.page1.bgbi008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi008
            #add-point:ON CHANGE bgbi008 name="input.g.page1.bgbi008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi008_desc
            #add-point:BEFORE FIELD bgbi008_desc name="input.b.page1.bgbi008_desc"
            LET g_bgbi_d[l_ac].bgbi008_desc = g_bgbi_d[l_ac].bgbi008
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi008_desc
            
            #add-point:AFTER FIELD bgbi008_desc name="input.a.page1.bgbi008_desc"
            #責任中心
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi008_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi008_desc != g_bgbi_d_t.bgbi008_desc OR g_bgbi_d_t.bgbi008_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi008 = g_bgbi_d[l_ac].bgbi008_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi008 != g_bgbi_d_t.bgbi008 OR g_bgbi_d_t.bgbi008 IS NULL) THEN
                        CALL s_voucher_glaq019_chk(g_bgbi_d[l_ac].bgbi008_desc,g_today)
                        IF NOT cl_null(g_errno) THEN
                           LET g_bgbi_d[l_ac].bgbi008 = g_bgbi_d_t.bgbi008
                           LET g_bgbi_d[l_ac].bgbi008_desc = g_bgbi_d_t.bgbi008_desc
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi008_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi008 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi008_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi008,s_desc_get_department_desc(g_bgbi_d[l_ac].bgbi008))         
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi008 ,g_bgbi_d[l_ac].bgbi008_desc
            LET g_bgbi_d_t.bgbi008_desc = g_bgbi_d[l_ac].bgbi008_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi008_desc
            #add-point:ON CHANGE bgbi008_desc name="input.g.page1.bgbi008_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi009
            #add-point:BEFORE FIELD bgbi009 name="input.b.page1.bgbi009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi009
            
            #add-point:AFTER FIELD bgbi009 name="input.a.page1.bgbi009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi009
            #add-point:ON CHANGE bgbi009 name="input.g.page1.bgbi009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi009_desc
            #add-point:BEFORE FIELD bgbi009_desc name="input.b.page1.bgbi009_desc"
            LET g_bgbi_d[l_ac].bgbi009_desc = g_bgbi_d[l_ac].bgbi009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi009_desc
            
            #add-point:AFTER FIELD bgbi009_desc name="input.a.page1.bgbi009_desc"
            #區域
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi009_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi009_desc != g_bgbi_d_t.bgbi009_desc OR g_bgbi_d_t.bgbi009_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi009 = g_bgbi_d[l_ac].bgbi009_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi009 != g_bgbi_d_t.bgbi009 OR g_bgbi_d_t.bgbi009 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('287',g_bgbi_d[l_ac].bgbi009) THEN
                           LET g_bgbi_d[l_ac].bgbi009 = g_bgbi_d_t.bgbi009
                           LET g_bgbi_d[l_ac].bgbi009_desc = g_bgbi_d_t.bgbi009_desc
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi009 ,g_bgbi_d[l_ac].bgbi009_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            END IF
            LET g_bgbi_d[l_ac].bgbi009_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi009,s_desc_get_acc_desc('287',g_bgbi_d[l_ac].bgbi009))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi009 ,g_bgbi_d[l_ac].bgbi009_desc
            LET g_bgbi_d_t.bgbi009_desc = g_bgbi_d[l_ac].bgbi009_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi009_desc
            #add-point:ON CHANGE bgbi009_desc name="input.g.page1.bgbi009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi010
            #add-point:BEFORE FIELD bgbi010 name="input.b.page1.bgbi010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi010
            
            #add-point:AFTER FIELD bgbi010 name="input.a.page1.bgbi010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi010
            #add-point:ON CHANGE bgbi010 name="input.g.page1.bgbi010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi010_desc
            #add-point:BEFORE FIELD bgbi010_desc name="input.b.page1.bgbi010_desc"
            LET g_bgbi_d[l_ac].bgbi010_desc = g_bgbi_d[l_ac].bgbi010
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi010_desc
            
            #add-point:AFTER FIELD bgbi010_desc name="input.a.page1.bgbi010_desc"
            #交易客商
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi010_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi010_desc != g_bgbi_d_t.bgbi010_desc OR g_bgbi_d_t.bgbi010_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi010 = g_bgbi_d[l_ac].bgbi010_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi010 != g_bgbi_d_t.bgbi010 OR g_bgbi_d_t.bgbi010 IS NULL) THEN
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_bgbi_d[l_ac].bgbi010
                        LET g_chkparam.arg2 = ' '
                        IF NOT cl_chk_exist("v_pmaa001_7") THEN
                           LET g_bgbi_d[l_ac].bgbi010      = g_bgbi_d_t.bgbi010
                           LET g_bgbi_d[l_ac].bgbi010_desc = g_bgbi_d_t.bgbi010_desc
                           LET g_bgbi_d[l_ac].bgbi010_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi010,s_desc_get_trading_partner_abbr_desc(g_bgbi_d[l_ac].bgbi010))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi010,g_bgbi_d[l_ac].bgbi010_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi010 = ''
            END IF
            LET g_bgbi_d_t.bgbi010_desc = g_bgbi_d[l_ac].bgbi010_desc
            LET g_bgbi_d[l_ac].bgbi010_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi010,s_desc_get_trading_partner_abbr_desc(g_bgbi_d[l_ac].bgbi010))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi010,g_bgbi_d[l_ac].bgbi010_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi010_desc
            #add-point:ON CHANGE bgbi010_desc name="input.g.page1.bgbi010_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi011
            #add-point:BEFORE FIELD bgbi011 name="input.b.page1.bgbi011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi011
            
            #add-point:AFTER FIELD bgbi011 name="input.a.page1.bgbi011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi011
            #add-point:ON CHANGE bgbi011 name="input.g.page1.bgbi011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi011_desc
            #add-point:BEFORE FIELD bgbi011_desc name="input.b.page1.bgbi011_desc"
            LET g_bgbi_d[l_ac].bgbi011_desc = g_bgbi_d[l_ac].bgbi011
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi011_desc
            
            #add-point:AFTER FIELD bgbi011_desc name="input.a.page1.bgbi011_desc"
            #收款客商
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi011_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi011_desc != g_bgbi_d_t.bgbi011_desc OR g_bgbi_d_t.bgbi011_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi011 = g_bgbi_d[l_ac].bgbi011_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi011 != g_bgbi_d_t.bgbi011 OR g_bgbi_d_t.bgbi011 IS NULL) THEN
                        #資料存在性、有效性檢查
                        INITIALIZE g_chkparam.* TO NULL
                        LET g_chkparam.arg1 = g_bgbi_d[l_ac].bgbi011
                        LET g_chkparam.arg2 = ' '
                        IF NOT cl_chk_exist("v_pmaa001_7") THEN
                           LET g_bgbi_d[l_ac].bgbi011      = g_bgbi_d_t.bgbi011
                           LET g_bgbi_d[l_ac].bgbi011_desc = g_bgbi_d_t.bgbi011_desc
                           LET g_bgbi_d[l_ac].bgbi011_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi011,s_desc_get_trading_partner_abbr_desc(g_bgbi_d[l_ac].bgbi011))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi011,g_bgbi_d[l_ac].bgbi011_desc
                           NEXT FIELD CURRENT
                        END IF
                        #資料邏輯正確性檢查
                        IF g_bgbi_d[l_ac].bgbi010 != g_bgbi_d[l_ac].bgbi011 THEN
                           INITIALIZE g_chkparam.* TO NULL
                           LET g_chkparam.arg1 = g_bgbi_d[l_ac].bgbi010
                           LET g_chkparam.arg2 = g_bgbi_d[l_ac].bgbi011
                           IF NOT cl_chk_exist("v_pmac002_4") THEN
                              LET g_bgbi_d[l_ac].bgbi011      = g_bgbi_d_t.bgbi011
                              LET g_bgbi_d[l_ac].bgbi011_desc = g_bgbi_d_t.bgbi011_desc
                              LET g_bgbi_d[l_ac].bgbi011_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi011,s_desc_get_trading_partner_abbr_desc(g_bgbi_d[l_ac].bgbi011))
                              DISPLAY BY NAME g_bgbi_d[l_ac].bgbi011,g_bgbi_d[l_ac].bgbi011_desc
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi011 = ''
            END IF
            LET g_bgbi_d_t.bgbi011_desc = g_bgbi_d[l_ac].bgbi011_desc
            LET g_bgbi_d[l_ac].bgbi011_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi011,s_desc_get_trading_partner_abbr_desc(g_bgbi_d[l_ac].bgbi011))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi011,g_bgbi_d[l_ac].bgbi011_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi011_desc
            #add-point:ON CHANGE bgbi011_desc name="input.g.page1.bgbi011_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi012
            #add-point:BEFORE FIELD bgbi012 name="input.b.page1.bgbi012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi012
            
            #add-point:AFTER FIELD bgbi012 name="input.a.page1.bgbi012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi012
            #add-point:ON CHANGE bgbi012 name="input.g.page1.bgbi012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi012_desc
            #add-point:BEFORE FIELD bgbi012_desc name="input.b.page1.bgbi012_desc"
            LET g_bgbi_d[l_ac].bgbi012_desc = g_bgbi_d[l_ac].bgbi012
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi012_desc
            
            #add-point:AFTER FIELD bgbi012_desc name="input.a.page1.bgbi012_desc"
            #客群
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi012_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi012_desc != g_bgbi_d_t.bgbi012_desc OR g_bgbi_d_t.bgbi012_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi012 = g_bgbi_d[l_ac].bgbi012_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi012 != g_bgbi_d_t.bgbi012 OR g_bgbi_d_t.bgbi012 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('281',g_bgbi_d[l_ac].bgbi012) THEN
                           LET g_bgbi_d[l_ac].bgbi012 = g_bgbi_d_t.bgbi012
                           LET g_bgbi_d[l_ac].bgbi012_desc = g_bgbi_d_t.bgbi012_desc
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi012 ,g_bgbi_d[l_ac].bgbi012_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi012 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi012_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi012,s_desc_get_acc_desc('281',g_bgbi_d[l_ac].bgbi012))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi012 ,g_bgbi_d[l_ac].bgbi012_desc
            LET g_bgbi_d_t.bgbi012_desc = g_bgbi_d[l_ac].bgbi012_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi012_desc
            #add-point:ON CHANGE bgbi012_desc name="input.g.page1.bgbi012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi013
            #add-point:BEFORE FIELD bgbi013 name="input.b.page1.bgbi013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi013
            
            #add-point:AFTER FIELD bgbi013 name="input.a.page1.bgbi013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi013
            #add-point:ON CHANGE bgbi013 name="input.g.page1.bgbi013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi013_desc
            #add-point:BEFORE FIELD bgbi013_desc name="input.b.page1.bgbi013_desc"
            LET g_bgbi_d[l_ac].bgbi013_desc = g_bgbi_d[l_ac].bgbi013
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi013_desc
            
            #add-point:AFTER FIELD bgbi013_desc name="input.a.page1.bgbi013_desc"
            #產品類別
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi013_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi013_desc != g_bgbi_d_t.bgbi013_desc OR g_bgbi_d_t.bgbi013_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi013 = g_bgbi_d[l_ac].bgbi013_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi013 != g_bgbi_d_t.bgbi013 OR g_bgbi_d_t.bgbi013 IS NULL) THEN
                        CALL s_voucher_glaq024_chk(g_bgbi_d[l_ac].bgbi013) 
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi013 = g_bgbi_d_t.bgbi013
                           LET g_bgbi_d[l_ac].bgbi013_desc = g_bgbi_d_t.bgbi013_desc
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi013 ,g_bgbi_d[l_ac].bgbi013_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi013 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi013_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi013,s_desc_get_rtaxl003_desc(g_bgbi_d[l_ac].bgbi013))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi013 ,g_bgbi_d[l_ac].bgbi013_desc
            LET g_bgbi_d_t.bgbi013_desc = g_bgbi_d[l_ac].bgbi013_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi013_desc
            #add-point:ON CHANGE bgbi013_desc name="input.g.page1.bgbi013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi014
            #add-point:BEFORE FIELD bgbi014 name="input.b.page1.bgbi014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi014
            
            #add-point:AFTER FIELD bgbi014 name="input.a.page1.bgbi014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi014
            #add-point:ON CHANGE bgbi014 name="input.g.page1.bgbi014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi014_desc
            #add-point:BEFORE FIELD bgbi014_desc name="input.b.page1.bgbi014_desc"
            LET g_bgbi_d[l_ac].bgbi014_desc = g_bgbi_d[l_ac].bgbi014
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi014_desc
            
            #add-point:AFTER FIELD bgbi014_desc name="input.a.page1.bgbi014_desc"
            #人員
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi014_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi014_desc != g_bgbi_d_t.bgbi014_desc OR g_bgbi_d_t.bgbi014_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi014 = g_bgbi_d[l_ac].bgbi014_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi014 != g_bgbi_d_t.bgbi014 OR g_bgbi_d_t.bgbi014 IS NULL) THEN
                        CALL s_employee_chk(g_bgbi_d[l_ac].bgbi014_desc) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_bgbi_d[l_ac].bgbi014 = g_bgbi_d_t.bgbi014
                           LET g_bgbi_d[l_ac].bgbi014_desc = g_bgbi_d_t.bgbi014_desc
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi014,g_bgbi_d[l_ac].bgbi014_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi014 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi014_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi014,s_desc_get_person_desc(g_bgbi_d[l_ac].bgbi014))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi014,g_bgbi_d[l_ac].bgbi014_desc
            LET g_bgbi_d_t.bgbi014_desc = g_bgbi_d[l_ac].bgbi014_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi014_desc
            #add-point:ON CHANGE bgbi014_desc name="input.g.page1.bgbi014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi015
            #add-point:BEFORE FIELD bgbi015 name="input.b.page1.bgbi015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi015
            
            #add-point:AFTER FIELD bgbi015 name="input.a.page1.bgbi015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi015
            #add-point:ON CHANGE bgbi015 name="input.g.page1.bgbi015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi015_desc
            #add-point:BEFORE FIELD bgbi015_desc name="input.b.page1.bgbi015_desc"
            LET g_bgbi_d[l_ac].bgbi015_desc = g_bgbi_d[l_ac].bgbi015
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi015_desc
            
            #add-point:AFTER FIELD bgbi015_desc name="input.a.page1.bgbi015_desc"
            #專案代號
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi015_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi015_desc != g_bgbi_d_t.bgbi015_desc OR g_bgbi_d_t.bgbi015_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi015 = g_bgbi_d[l_ac].bgbi015_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi015 != g_bgbi_d_t.bgbi015 OR g_bgbi_d_t.bgbi015 IS NULL) THEN
                        CALL s_aap_project_chk( g_bgbi_d[l_ac].bgbi015) RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi015      = g_bgbi_d_t.bgbi015
                           LET g_bgbi_d[l_ac].bgbi015_desc = g_bgbi_d_t.bgbi015_desc
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi015,g_bgbi_d[l_ac].bgbi015_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi015 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi015_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi015,s_desc_get_project_desc(g_bgbi_d[l_ac].bgbi015))
            LET g_bgbi_d_t.bgbi015 = g_bgbi_d[l_ac].bgbi015_desc
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi015,g_bgbi_d[l_ac].bgbi015_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi015_desc
            #add-point:ON CHANGE bgbi015_desc name="input.g.page1.bgbi015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi016
            #add-point:BEFORE FIELD bgbi016 name="input.b.page1.bgbi016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi016
            
            #add-point:AFTER FIELD bgbi016 name="input.a.page1.bgbi016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi016
            #add-point:ON CHANGE bgbi016 name="input.g.page1.bgbi016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi016_desc
            #add-point:BEFORE FIELD bgbi016_desc name="input.b.page1.bgbi016_desc"
            LET g_bgbi_d[l_ac].bgbi016_desc = g_bgbi_d[l_ac].bgbi016
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi016_desc
            
            #add-point:AFTER FIELD bgbi016_desc name="input.a.page1.bgbi016_desc"
            #WBS
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi016_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi016_desc != g_bgbi_d_t.bgbi016_desc OR g_bgbi_d_t.bgbi016_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi016 = g_bgbi_d[l_ac].bgbi016_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi016 != g_bgbi_d_t.bgbi016 OR g_bgbi_d_t.bgbi016 IS NULL) THEN
                        CALL s_voucher_glaq028_chk(g_bgbi_d[l_ac].bgbi015,g_bgbi_d[l_ac].bgbi016)
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi016      = g_bgbi_d_t.bgbi016
                           LET g_bgbi_d[l_ac].bgbi016_desc = g_bgbi_d_t.bgbi016_desc
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi016,g_bgbi_d[l_ac].bgbi016_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi016 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi016_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi016,s_desc_get_pjbbl004_desc(g_bgbi_d[l_ac].bgbi015,g_bgbi_d[l_ac].bgbi016))
            LET g_bgbi_d_t.bgbi016 = g_bgbi_d[l_ac].bgbi016_desc
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi016,g_bgbi_d[l_ac].bgbi016_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi016_desc
            #add-point:ON CHANGE bgbi016_desc name="input.g.page1.bgbi016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi039
            #add-point:BEFORE FIELD bgbi039 name="input.b.page1.bgbi039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi039
            
            #add-point:AFTER FIELD bgbi039 name="input.a.page1.bgbi039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi039
            #add-point:ON CHANGE bgbi039 name="input.g.page1.bgbi039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi039_desc
            #add-point:BEFORE FIELD bgbi039_desc name="input.b.page1.bgbi039_desc"
            LET g_bgbi_d[l_ac].bgbi039_desc = g_bgbi_d[l_ac].bgbi039
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi039_desc
            
            #add-point:AFTER FIELD bgbi039_desc name="input.a.page1.bgbi039_desc"
            #經營方式
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi039_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi039_desc != g_bgbi_d_t.bgbi039_desc OR g_bgbi_d_t.bgbi039_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi039 = g_bgbi_d[l_ac].bgbi039_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi039 != g_bgbi_d_t.bgbi039 OR g_bgbi_d_t.bgbi039 IS NULL) THEN
                        CALL s_voucher_glaq051_chk(g_bgbi_d[l_ac].bgbi039) 
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi039      = g_bgbi_d_t.bgbi039
                           LET g_bgbi_d[l_ac].bgbi039_desc = g_bgbi_d_t.bgbi039_desc
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi039,g_bgbi_d[l_ac].bgbi039_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi039 = ''
            END IF
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi039 ,g_bgbi_d[l_ac].bgbi039_desc
            LET g_bgbi_d_t.bgbi039_desc = g_bgbi_d[l_ac].bgbi039_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi039_desc
            #add-point:ON CHANGE bgbi039_desc name="input.g.page1.bgbi039_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi040
            #add-point:BEFORE FIELD bgbi040 name="input.b.page1.bgbi040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi040
            
            #add-point:AFTER FIELD bgbi040 name="input.a.page1.bgbi040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi040
            #add-point:ON CHANGE bgbi040 name="input.g.page1.bgbi040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi040_desc
            #add-point:BEFORE FIELD bgbi040_desc name="input.b.page1.bgbi040_desc"
            LET g_bgbi_d[l_ac].bgbi040_desc = g_bgbi_d[l_ac].bgbi040
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi040_desc
            
            #add-point:AFTER FIELD bgbi040_desc name="input.a.page1.bgbi040_desc"
            #渠道
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi040_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi040_desc != g_bgbi_d_t.bgbi040_desc OR g_bgbi_d_t.bgbi040_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi040 = g_bgbi_d[l_ac].bgbi040_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     CALL s_voucher_glaq052_chk(g_bgbi_d[l_ac].bgbi040)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bgbi_d[l_ac].bgbi040 = g_bgbi_d_t.bgbi040
                        LET g_bgbi_d[l_ac].bgbi040_desc = g_bgbi_d_t.bgbi040_desc
                        DISPLAY BY NAME g_bgbi_d[l_ac].bgbi040,g_bgbi_d[l_ac].bgbi040_desc
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi040 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi040_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi040,s_desc_get_oojdl003_desc(g_bgbi_d[l_ac].bgbi040))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi040,g_bgbi_d[l_ac].bgbi040_desc
            LET g_bgbi_d_t.bgbi040_desc = g_bgbi_d[l_ac].bgbi040_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi040_desc
            #add-point:ON CHANGE bgbi040_desc name="input.g.page1.bgbi040_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi041
            #add-point:BEFORE FIELD bgbi041 name="input.b.page1.bgbi041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi041
            
            #add-point:AFTER FIELD bgbi041 name="input.a.page1.bgbi041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi041
            #add-point:ON CHANGE bgbi041 name="input.g.page1.bgbi041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi041_desc
            #add-point:BEFORE FIELD bgbi041_desc name="input.b.page1.bgbi041_desc"
            LET g_bgbi_d[l_ac].bgbi041_desc = g_bgbi_d[l_ac].bgbi041
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi041_desc
            
            #add-point:AFTER FIELD bgbi041_desc name="input.a.page1.bgbi041_desc"
            #品牌
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi041_desc) THEN
               IF ( g_bgbi_d[l_ac].bgbi041_desc != g_bgbi_d_t.bgbi041_desc OR g_bgbi_d_t.bgbi041_desc IS NULL ) THEN
                  LET g_bgbi_d[l_ac].bgbi041 = g_bgbi_d[l_ac].bgbi041_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF NOT s_azzi650_chk_exist('2002',g_bgbi_d[l_ac].bgbi041) THEN
                        LET g_bgbi_d[l_ac].bgbi041      = g_bgbi_d_t.bgbi041
                        LET g_bgbi_d[l_ac].bgbi041_desc = g_bgbi_d_t.bgbi041_desc
                        DISPLAY BY NAME g_bgbi_d[l_ac].bgbi041 ,g_bgbi_d[l_ac].bgbi041_desc
                        NEXT FIELD CURRENT
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi041 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi041_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi041,s_desc_get_acc_desc('2002',g_bgbi_d[l_ac].bgbi041))      
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi041 ,g_bgbi_d[l_ac].bgbi041_desc
            LET g_bgbi_d_t.bgbi041_desc = g_bgbi_d[l_ac].bgbi041_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi041_desc
            #add-point:ON CHANGE bgbi041_desc name="input.g.page1.bgbi041_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi028
            #add-point:BEFORE FIELD bgbi028 name="input.b.page1.bgbi028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi028
            
            #add-point:AFTER FIELD bgbi028 name="input.a.page1.bgbi028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi028
            #add-point:ON CHANGE bgbi028 name="input.g.page1.bgbi028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi028_desc
            #add-point:BEFORE FIELD bgbi028_desc name="input.b.page1.bgbi028_desc"
            #自由核算項一
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_bgbi_d[l_ac].bgbi028_desc = g_bgbi_d[l_ac].bgbi028
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi028_desc
            
            #add-point:AFTER FIELD bgbi028_desc name="input.a.page1.bgbi028_desc"
            #自由核算項一
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi028_desc) THEN
               IF (g_bgbi_d[l_ac].bgbi028_desc != g_bgbi_d_t.bgbi028_desc OR g_bgbi_d_t.bgbi028_desc IS NULL) THEN
                  LET g_bgbi_d[l_ac].bgbi028 = g_bgbi_d[l_ac].bgbi028_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi028 != g_bgbi_d_t.bgbi028 OR g_bgbi_d_t.bgbi028 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_bgbi_d[l_ac].bgbi028,g_glad.glad0172) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi028 = g_bgbi_d_t.bgbi028
                           LET g_bgbi_d[l_ac].bgbi028_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi028,s_fin_get_accting_desc(g_glad.glad0171,g_bgbi_d[l_ac].bgbi028))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi028_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi028 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi028_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi028,s_fin_get_accting_desc(g_glad.glad0171,g_bgbi_d[l_ac].bgbi028))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi028_desc
            LET g_bgbi_d_t.bgbi028_desc = g_bgbi_d[l_ac].bgbi028_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi028_desc
            #add-point:ON CHANGE bgbi028_desc name="input.g.page1.bgbi028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi029
            #add-point:BEFORE FIELD bgbi029 name="input.b.page1.bgbi029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi029
            
            #add-point:AFTER FIELD bgbi029 name="input.a.page1.bgbi029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi029
            #add-point:ON CHANGE bgbi029 name="input.g.page1.bgbi029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi029_desc
            #add-point:BEFORE FIELD bgbi029_desc name="input.b.page1.bgbi029_desc"
            #自由核算項二
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_bgbi_d[l_ac].bgbi029_desc = g_bgbi_d[l_ac].bgbi029
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi029_desc
            
            #add-point:AFTER FIELD bgbi029_desc name="input.a.page1.bgbi029_desc"
            #自由核算項二
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi029_desc) THEN
               IF (g_bgbi_d[l_ac].bgbi029_desc != g_bgbi_d_t.bgbi029_desc OR g_bgbi_d_t.bgbi029_desc IS NULL) THEN
                  LET g_bgbi_d[l_ac].bgbi029 = g_bgbi_d[l_ac].bgbi029_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi029 != g_bgbi_d_t.bgbi029 OR g_bgbi_d_t.bgbi029 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_bgbi_d[l_ac].bgbi029,g_glad.glad0182) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi029 = g_bgbi_d_t.bgbi029
                           LET g_bgbi_d[l_ac].bgbi029_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi029,s_fin_get_accting_desc(g_glad.glad0181,g_bgbi_d[l_ac].bgbi029))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi029_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi029 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi029_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi029,s_fin_get_accting_desc(g_glad.glad0181,g_bgbi_d[l_ac].bgbi029))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi029_desc 
            LET g_bgbi_d_t.bgbi029_desc = g_bgbi_d[l_ac].bgbi029_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi029_desc
            #add-point:ON CHANGE bgbi029_desc name="input.g.page1.bgbi029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi030
            #add-point:BEFORE FIELD bgbi030 name="input.b.page1.bgbi030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi030
            
            #add-point:AFTER FIELD bgbi030 name="input.a.page1.bgbi030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi030
            #add-point:ON CHANGE bgbi030 name="input.g.page1.bgbi030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi030_desc
            #add-point:BEFORE FIELD bgbi030_desc name="input.b.page1.bgbi030_desc"
            #自由核算項三
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_bgbi_d[l_ac].bgbi030_desc = g_bgbi_d[l_ac].bgbi030
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi030_desc
            
            #add-point:AFTER FIELD bgbi030_desc name="input.a.page1.bgbi030_desc"
            #自由核算項三
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi030_desc) THEN
               IF (g_bgbi_d[l_ac].bgbi030_desc != g_bgbi_d_t.bgbi030_desc OR g_bgbi_d_t.bgbi030_desc IS NULL) THEN
                  LET g_bgbi_d[l_ac].bgbi030 = g_bgbi_d[l_ac].bgbi030_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi030 != g_bgbi_d_t.bgbi030 OR g_bgbi_d_t.bgbi030 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_bgbi_d[l_ac].bgbi030,g_glad.glad0192) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi030 = g_bgbi_d_t.bgbi030
                           LET g_bgbi_d[l_ac].bgbi030_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi030,s_fin_get_accting_desc(g_glad.glad0191,g_bgbi_d[l_ac].bgbi030))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi030_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi030 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi030_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi030,s_fin_get_accting_desc(g_glad.glad0191,g_bgbi_d[l_ac].bgbi030))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi030_desc 
            LET g_bgbi_d_t.bgbi030_desc = g_bgbi_d[l_ac].bgbi030_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi030_desc
            #add-point:ON CHANGE bgbi030_desc name="input.g.page1.bgbi030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi031
            #add-point:BEFORE FIELD bgbi031 name="input.b.page1.bgbi031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi031
            
            #add-point:AFTER FIELD bgbi031 name="input.a.page1.bgbi031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi031
            #add-point:ON CHANGE bgbi031 name="input.g.page1.bgbi031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi031_desc
            #add-point:BEFORE FIELD bgbi031_desc name="input.b.page1.bgbi031_desc"
            #自由核算項四
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_bgbi_d[l_ac].bgbi031_desc = g_bgbi_d[l_ac].bgbi031
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi031_desc
            
            #add-point:AFTER FIELD bgbi031_desc name="input.a.page1.bgbi031_desc"
            #自由核算項四
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi031_desc) THEN
               IF (g_bgbi_d[l_ac].bgbi031_desc != g_bgbi_d_t.bgbi031_desc OR g_bgbi_d_t.bgbi031_desc IS NULL) THEN
                  LET g_bgbi_d[l_ac].bgbi031 = g_bgbi_d[l_ac].bgbi031_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi031 != g_bgbi_d_t.bgbi031 OR g_bgbi_d_t.bgbi031 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_bgbi_d[l_ac].bgbi031,g_glad.glad0202) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi031 = g_bgbi_d_t.bgbi031
                           LET g_bgbi_d[l_ac].bgbi031_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi031,s_fin_get_accting_desc(g_glad.glad0201,g_bgbi_d[l_ac].bgbi031))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi031_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi031 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi031_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi031,s_fin_get_accting_desc(g_glad.glad0201,g_bgbi_d[l_ac].bgbi031))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi031_desc 
            LET g_bgbi_d_t.bgbi031_desc = g_bgbi_d[l_ac].bgbi031_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi031_desc
            #add-point:ON CHANGE bgbi031_desc name="input.g.page1.bgbi031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi032
            #add-point:BEFORE FIELD bgbi032 name="input.b.page1.bgbi032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi032
            
            #add-point:AFTER FIELD bgbi032 name="input.a.page1.bgbi032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi032
            #add-point:ON CHANGE bgbi032 name="input.g.page1.bgbi032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi032_desc
            #add-point:BEFORE FIELD bgbi032_desc name="input.b.page1.bgbi032_desc"
            #自由核算項五
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_bgbi_d[l_ac].bgbi032_desc = g_bgbi_d[l_ac].bgbi032
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi032_desc
            
            #add-point:AFTER FIELD bgbi032_desc name="input.a.page1.bgbi032_desc"
            #自由核算項五
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi032_desc) THEN
               IF (g_bgbi_d[l_ac].bgbi032_desc != g_bgbi_d_t.bgbi032_desc OR g_bgbi_d_t.bgbi032_desc IS NULL) THEN
                  LET g_bgbi_d[l_ac].bgbi032 = g_bgbi_d[l_ac].bgbi032_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi032 != g_bgbi_d_t.bgbi032 OR g_bgbi_d_t.bgbi032 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_bgbi_d[l_ac].bgbi032,g_glad.glad0212) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi032 = g_bgbi_d_t.bgbi032
                           LET g_bgbi_d[l_ac].bgbi032_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi032,s_fin_get_accting_desc(g_glad.glad0211,g_bgbi_d[l_ac].bgbi032))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi032_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi032 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi032_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi032,s_fin_get_accting_desc(g_glad.glad0211,g_bgbi_d[l_ac].bgbi032))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi032_desc
            LET g_bgbi_d_t.bgbi032_desc = g_bgbi_d[l_ac].bgbi032_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi032_desc
            #add-point:ON CHANGE bgbi032_desc name="input.g.page1.bgbi032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi033
            #add-point:BEFORE FIELD bgbi033 name="input.b.page1.bgbi033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi033
            
            #add-point:AFTER FIELD bgbi033 name="input.a.page1.bgbi033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi033
            #add-point:ON CHANGE bgbi033 name="input.g.page1.bgbi033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi033_desc
            #add-point:BEFORE FIELD bgbi033_desc name="input.b.page1.bgbi033_desc"
            #自由核算項六
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_bgbi_d[l_ac].bgbi033_desc = g_bgbi_d[l_ac].bgbi033
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi033_desc
            
            #add-point:AFTER FIELD bgbi033_desc name="input.a.page1.bgbi033_desc"
            #自由核算項六
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi033_desc) THEN
               IF (g_bgbi_d[l_ac].bgbi033_desc != g_bgbi_d_t.bgbi033_desc OR g_bgbi_d_t.bgbi033_desc IS NULL) THEN
                  LET g_bgbi_d[l_ac].bgbi033 = g_bgbi_d[l_ac].bgbi033_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi033 != g_bgbi_d_t.bgbi033 OR g_bgbi_d_t.bgbi033 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_bgbi_d[l_ac].bgbi033,g_glad.glad0222) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi033 = g_bgbi_d_t.bgbi033
                           LET g_bgbi_d[l_ac].bgbi033_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi033,s_fin_get_accting_desc(g_glad.glad0221,g_bgbi_d[l_ac].bgbi033))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi033_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi033 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi033_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi033,s_fin_get_accting_desc(g_glad.glad0221,g_bgbi_d[l_ac].bgbi033))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi033_desc 
            LET g_bgbi_d_t.bgbi033_desc = g_bgbi_d[l_ac].bgbi033_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi033_desc
            #add-point:ON CHANGE bgbi033_desc name="input.g.page1.bgbi033_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi034
            #add-point:BEFORE FIELD bgbi034 name="input.b.page1.bgbi034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi034
            
            #add-point:AFTER FIELD bgbi034 name="input.a.page1.bgbi034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi034
            #add-point:ON CHANGE bgbi034 name="input.g.page1.bgbi034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi034_desc
            #add-point:BEFORE FIELD bgbi034_desc name="input.b.page1.bgbi034_desc"
            #自由核算項七
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_bgbi_d[l_ac].bgbi034_desc = g_bgbi_d[l_ac].bgbi034
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi034_desc
            
            #add-point:AFTER FIELD bgbi034_desc name="input.a.page1.bgbi034_desc"
            #自由核算項七
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi034_desc) THEN
               IF (g_bgbi_d[l_ac].bgbi034_desc != g_bgbi_d_t.bgbi034_desc OR g_bgbi_d_t.bgbi034_desc IS NULL) THEN
                  LET g_bgbi_d[l_ac].bgbi034 = g_bgbi_d[l_ac].bgbi034_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi034 != g_bgbi_d_t.bgbi034 OR g_bgbi_d_t.bgbi034 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0231,g_bgbi_d[l_ac].bgbi034,g_glad.glad0232) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi034 = g_bgbi_d_t.bgbi034
                           LET g_bgbi_d[l_ac].bgbi034_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi034,s_fin_get_accting_desc(g_glad.glad0231,g_bgbi_d[l_ac].bgbi034))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi034_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi034 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi034_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi034,s_fin_get_accting_desc(g_glad.glad0231,g_bgbi_d[l_ac].bgbi034))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi034_desc 
            LET g_bgbi_d_t.bgbi034_desc = g_bgbi_d[l_ac].bgbi034_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi034_desc
            #add-point:ON CHANGE bgbi034_desc name="input.g.page1.bgbi034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi035
            #add-point:BEFORE FIELD bgbi035 name="input.b.page1.bgbi035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi035
            
            #add-point:AFTER FIELD bgbi035 name="input.a.page1.bgbi035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi035
            #add-point:ON CHANGE bgbi035 name="input.g.page1.bgbi035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi035_desc
            #add-point:BEFORE FIELD bgbi035_desc name="input.b.page1.bgbi035_desc"
            #自由核算項八
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_bgbi_d[l_ac].bgbi035_desc = g_bgbi_d[l_ac].bgbi035
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi035_desc
            
            #add-point:AFTER FIELD bgbi035_desc name="input.a.page1.bgbi035_desc"
            #自由核算項八
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi035_desc) THEN
               IF (g_bgbi_d[l_ac].bgbi035_desc != g_bgbi_d_t.bgbi035_desc OR g_bgbi_d_t.bgbi035_desc IS NULL) THEN
                  LET g_bgbi_d[l_ac].bgbi035 = g_bgbi_d[l_ac].bgbi035_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi035 != g_bgbi_d_t.bgbi035 OR g_bgbi_d_t.bgbi035 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_bgbi_d[l_ac].bgbi035,g_glad.glad0242) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi035 = g_bgbi_d_t.bgbi035
                           LET g_bgbi_d[l_ac].bgbi035_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi035,s_fin_get_accting_desc(g_glad.glad0241,g_bgbi_d[l_ac].bgbi035))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi035_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi035 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi035_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi035,s_fin_get_accting_desc(g_glad.glad0241,g_bgbi_d[l_ac].bgbi035))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi035_desc
            LET g_bgbi_d_t.bgbi035_desc = g_bgbi_d[l_ac].bgbi035_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi035_desc
            #add-point:ON CHANGE bgbi035_desc name="input.g.page1.bgbi035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi036
            #add-point:BEFORE FIELD bgbi036 name="input.b.page1.bgbi036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi036
            
            #add-point:AFTER FIELD bgbi036 name="input.a.page1.bgbi036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi036
            #add-point:ON CHANGE bgbi036 name="input.g.page1.bgbi036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi036_desc
            #add-point:BEFORE FIELD bgbi036_desc name="input.b.page1.bgbi036_desc"
            #自由核算項九
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_bgbi_d[l_ac].bgbi036_desc = g_bgbi_d[l_ac].bgbi036
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi036_desc
            
            #add-point:AFTER FIELD bgbi036_desc name="input.a.page1.bgbi036_desc"
            #自由核算項九
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi036_desc) THEN
               IF (g_bgbi_d[l_ac].bgbi036_desc != g_bgbi_d_t.bgbi036_desc OR g_bgbi_d_t.bgbi036_desc IS NULL) THEN
                  LET g_bgbi_d[l_ac].bgbi036 = g_bgbi_d[l_ac].bgbi036_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi036 != g_bgbi_d_t.bgbi036 OR g_bgbi_d_t.bgbi036 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_bgbi_d[l_ac].bgbi036,g_glad.glad0252) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi036 = g_bgbi_d_t.bgbi036
                           LET g_bgbi_d[l_ac].bgbi036_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi036,s_fin_get_accting_desc(g_glad.glad0251,g_bgbi_d[l_ac].bgbi036))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi036_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi036 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi036_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi036,s_fin_get_accting_desc(g_glad.glad0251,g_bgbi_d[l_ac].bgbi036))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi036_desc
            LET g_bgbi_d_t.bgbi036_desc = g_bgbi_d[l_ac].bgbi036_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi036_desc
            #add-point:ON CHANGE bgbi036_desc name="input.g.page1.bgbi036_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi037
            #add-point:BEFORE FIELD bgbi037 name="input.b.page1.bgbi037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi037
            
            #add-point:AFTER FIELD bgbi037 name="input.a.page1.bgbi037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi037
            #add-point:ON CHANGE bgbi037 name="input.g.page1.bgbi037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi037_desc
            #add-point:BEFORE FIELD bgbi037_desc name="input.b.page1.bgbi037_desc"
            #自由核算項十
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_bgbi_d[l_ac].bgbi037_desc = g_bgbi_d[l_ac].bgbi037
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi037_desc
            
            #add-point:AFTER FIELD bgbi037_desc name="input.a.page1.bgbi037_desc"
            #自由核算項十
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi037_desc) THEN
               IF (g_bgbi_d[l_ac].bgbi037_desc != g_bgbi_d_t.bgbi037_desc OR g_bgbi_d_t.bgbi037_desc IS NULL) THEN
                  LET g_bgbi_d[l_ac].bgbi037 = g_bgbi_d[l_ac].bgbi037_desc
                  #IF g_glaa.glaa121 = 'N' THEN
                     IF (g_bgbi_d[l_ac].bgbi037 != g_bgbi_d_t.bgbi037 OR g_bgbi_d_t.bgbi037 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_bgbi_d[l_ac].bgbi037,g_glad.glad0262) RETURNING g_errno
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = ""
                           LET g_errparam.code   = g_errno
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_bgbi_d[l_ac].bgbi037 = g_bgbi_d_t.bgbi037
                           LET g_bgbi_d[l_ac].bgbi037_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi037,s_fin_get_accting_desc(g_glad.glad0261,g_bgbi_d[l_ac].bgbi037))
                           DISPLAY BY NAME g_bgbi_d[l_ac].bgbi037_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  #END IF
               END IF
            ELSE
               LET g_bgbi_d[l_ac].bgbi037 = ''
            END IF
            LET g_bgbi_d[l_ac].bgbi037_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi037,s_fin_get_accting_desc(g_glad.glad0261,g_bgbi_d[l_ac].bgbi037))
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi037_desc
            LET g_bgbi_d_t.bgbi037_desc = g_bgbi_d[l_ac].bgbi037_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi037_desc
            #add-point:ON CHANGE bgbi037_desc name="input.g.page1.bgbi037_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi023
            #add-point:BEFORE FIELD bgbi023 name="input.b.page1.bgbi023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi023
            
            #add-point:AFTER FIELD bgbi023 name="input.a.page1.bgbi023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi023
            #add-point:ON CHANGE bgbi023 name="input.g.page1.bgbi023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi0232
            #add-point:BEFORE FIELD bgbi0232 name="input.b.page1.bgbi0232"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi0232
            
            #add-point:AFTER FIELD bgbi0232 name="input.a.page1.bgbi0232"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi0232
            #add-point:ON CHANGE bgbi0232 name="input.g.page1.bgbi0232"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi0233
            #add-point:BEFORE FIELD bgbi0233 name="input.b.page1.bgbi0233"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi0233
            
            #add-point:AFTER FIELD bgbi0233 name="input.a.page1.bgbi0233"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi0233
            #add-point:ON CHANGE bgbi0233 name="input.g.page1.bgbi0233"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi0234
            #add-point:BEFORE FIELD bgbi0234 name="input.b.page1.bgbi0234"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi0234
            
            #add-point:AFTER FIELD bgbi0234 name="input.a.page1.bgbi0234"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi0234
            #add-point:ON CHANGE bgbi0234 name="input.g.page1.bgbi0234"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi0235
            #add-point:BEFORE FIELD bgbi0235 name="input.b.page1.bgbi0235"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi0235
            
            #add-point:AFTER FIELD bgbi0235 name="input.a.page1.bgbi0235"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi0235
            #add-point:ON CHANGE bgbi0235 name="input.g.page1.bgbi0235"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi0236
            #add-point:BEFORE FIELD bgbi0236 name="input.b.page1.bgbi0236"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi0236
            
            #add-point:AFTER FIELD bgbi0236 name="input.a.page1.bgbi0236"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi0236
            #add-point:ON CHANGE bgbi0236 name="input.g.page1.bgbi0236"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi0237
            #add-point:BEFORE FIELD bgbi0237 name="input.b.page1.bgbi0237"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi0237
            
            #add-point:AFTER FIELD bgbi0237 name="input.a.page1.bgbi0237"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi0237
            #add-point:ON CHANGE bgbi0237 name="input.g.page1.bgbi0237"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi0238
            #add-point:BEFORE FIELD bgbi0238 name="input.b.page1.bgbi0238"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi0238
            
            #add-point:AFTER FIELD bgbi0238 name="input.a.page1.bgbi0238"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi0238
            #add-point:ON CHANGE bgbi0238 name="input.g.page1.bgbi0238"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi0239
            #add-point:BEFORE FIELD bgbi0239 name="input.b.page1.bgbi0239"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi0239
            
            #add-point:AFTER FIELD bgbi0239 name="input.a.page1.bgbi0239"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi0239
            #add-point:ON CHANGE bgbi0239 name="input.g.page1.bgbi0239"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi02310
            #add-point:BEFORE FIELD bgbi02310 name="input.b.page1.bgbi02310"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi02310
            
            #add-point:AFTER FIELD bgbi02310 name="input.a.page1.bgbi02310"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi02310
            #add-point:ON CHANGE bgbi02310 name="input.g.page1.bgbi02310"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi02311
            #add-point:BEFORE FIELD bgbi02311 name="input.b.page1.bgbi02311"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi02311
            
            #add-point:AFTER FIELD bgbi02311 name="input.a.page1.bgbi02311"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi02311
            #add-point:ON CHANGE bgbi02311 name="input.g.page1.bgbi02311"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi02312
            #add-point:BEFORE FIELD bgbi02312 name="input.b.page1.bgbi02312"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi02312
            
            #add-point:AFTER FIELD bgbi02312 name="input.a.page1.bgbi02312"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi02312
            #add-point:ON CHANGE bgbi02312 name="input.g.page1.bgbi02312"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbi02313
            #add-point:BEFORE FIELD bgbi02313 name="input.b.page1.bgbi02313"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbi02313
            
            #add-point:AFTER FIELD bgbi02313 name="input.a.page1.bgbi02313"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbi02313
            #add-point:ON CHANGE bgbi02313 name="input.g.page1.bgbi02313"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.bgbi038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi038
            #add-point:ON ACTION controlp INFIELD bgbi038 name="input.c.page1.bgbi038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi038_desc
            #add-point:ON ACTION controlp INFIELD bgbi038_desc name="input.c.page1.bgbi038_desc"
            #開窗i段-現金變動碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",g_bgaa.bgaa009,"' "
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi038
            CALL q_nmai002() 
            LET g_bgbi_d[l_ac].bgbi038 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi038_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi038,g_bgbi_d[l_ac].bgbi038_desc
            NEXT FIELD bgbi038_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi007
            #add-point:ON ACTION controlp INFIELD bgbi007 name="input.c.page1.bgbi007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi007_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi007_desc
            #add-point:ON ACTION controlp INFIELD bgbi007_desc name="input.c.page1.bgbi007_desc"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi007
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            LET g_bgbi_d[l_ac].bgbi007 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi007_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi007,g_bgbi_d[l_ac].bgbi007_desc
            NEXT FIELD bgbi007_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi008
            #add-point:ON ACTION controlp INFIELD bgbi008 name="input.c.page1.bgbi008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi008_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi008_desc
            #add-point:ON ACTION controlp INFIELD bgbi008_desc name="input.c.page1.bgbi008_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 =  g_bgbi_d[l_ac].bgbi008
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_5()
            LET g_bgbi_d[l_ac].bgbi008 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi008_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi008_desc
            NEXT FIELD bgbi008_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi009
            #add-point:ON ACTION controlp INFIELD bgbi009 name="input.c.page1.bgbi009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi009_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi009_desc
            #add-point:ON ACTION controlp INFIELD bgbi009_desc name="input.c.page1.bgbi009_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi009
            CALL q_oocq002_287()
            LET g_bgbi_d[l_ac].bgbi009 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi009_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi009,g_bgbi_d[l_ac].bgbi009_desc
            NEXT FIELD bgbi009_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi010
            #add-point:ON ACTION controlp INFIELD bgbi010 name="input.c.page1.bgbi010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi010_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi010_desc
            #add-point:ON ACTION controlp INFIELD bgbi010_desc name="input.c.page1.bgbi010_desc"
            #交易客商
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi010
            #LET g_qryparam.where = "pmaa002 IN ('2','3')"  #160920-00019#3--mark
            #CALL q_pmaa001()    #160920-00019#3--mark
            CALL q_pmaa001_25()  #160920-00019#3--add
            LET g_bgbi_d[l_ac].bgbi010 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi010_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi010,g_bgbi_d[l_ac].bgbi010_desc
            NEXT FIELD bgbi010_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi011
            #add-point:ON ACTION controlp INFIELD bgbi011 name="input.c.page1.bgbi011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi011_desc
            #add-point:ON ACTION controlp INFIELD bgbi011_desc name="input.c.page1.bgbi011_desc"
            #帳款客戶
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi011
            LET g_qryparam.arg1 = g_bgbi_d[l_ac].bgbi010
            LET g_qryparam.arg2 = "1"
            CALL q_pmac002_1()
            LET g_bgbi_d[l_ac].bgbi011 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi011_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi011,g_bgbi_d[l_ac].bgbi011_desc
            NEXT FIELD bgbi011_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi012
            #add-point:ON ACTION controlp INFIELD bgbi012 name="input.c.page1.bgbi012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi012_desc
            #add-point:ON ACTION controlp INFIELD bgbi012_desc name="input.c.page1.bgbi012_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi012
            CALL q_oocq002_281()
            LET g_bgbi_d[l_ac].bgbi012 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi012_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi012,g_bgbi_d[l_ac].bgbi012_desc
            NEXT FIELD bgbi012_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi013
            #add-point:ON ACTION controlp INFIELD bgbi013 name="input.c.page1.bgbi013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi013_desc
            #add-point:ON ACTION controlp INFIELD bgbi013_desc name="input.c.page1.bgbi013_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi013
            CALL q_rtax001()
            LET g_bgbi_d[l_ac].bgbi013 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi013_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi013,g_bgbi_d[l_ac].bgbi013_desc
            NEXT FIELD bgbi013_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi014
            #add-point:ON ACTION controlp INFIELD bgbi014 name="input.c.page1.bgbi014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi014_desc
            #add-point:ON ACTION controlp INFIELD bgbi014_desc name="input.c.page1.bgbi014_desc"
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi014
            CALL q_ooag001_8()
            LET g_bgbi_d[l_ac].bgbi014 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi014_desc = g_qryparam.return1 
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi014,g_bgbi_d[l_ac].bgbi014_desc
            NEXT FIELD bgbi014_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi015
            #add-point:ON ACTION controlp INFIELD bgbi015 name="input.c.page1.bgbi015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi015_desc
            #add-point:ON ACTION controlp INFIELD bgbi015_desc name="input.c.page1.bgbi015_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi015
            CALL q_pjba001()
            LET g_bgbi_d[l_ac].bgbi015 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi015_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi015,g_bgbi_d[l_ac].bgbi015_desc
            NEXT FIELD bgbi015_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi016
            #add-point:ON ACTION controlp INFIELD bgbi016 name="input.c.page1.bgbi016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi016_desc
            #add-point:ON ACTION controlp INFIELD bgbi016_desc name="input.c.page1.bgbi016_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi016
            IF NOT cl_null(g_bgbi_d[l_ac].bgbi015) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_bgbi_d[l_ac].bgbi015,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            CALL q_pjbb002()
            LET g_bgbi_d[l_ac].bgbi016 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi016_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi016,g_bgbi_d[l_ac].bgbi016_desc
            NEXT FIELD bgbi016_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi039
            #add-point:ON ACTION controlp INFIELD bgbi039 name="input.c.page1.bgbi039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi039_desc
            #add-point:ON ACTION controlp INFIELD bgbi039_desc name="input.c.page1.bgbi039_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi040
            #add-point:ON ACTION controlp INFIELD bgbi040 name="input.c.page1.bgbi040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi040_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi040_desc
            #add-point:ON ACTION controlp INFIELD bgbi040_desc name="input.c.page1.bgbi040_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi040
            CALL q_oojd001_2()
            LET g_bgbi_d[l_ac].bgbi040 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi040_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi040,g_bgbi_d[l_ac].bgbi040_desc
            NEXT FIELD bgbi040_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi041
            #add-point:ON ACTION controlp INFIELD bgbi041 name="input.c.page1.bgbi041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi041_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi041_desc
            #add-point:ON ACTION controlp INFIELD bgbi041_desc name="input.c.page1.bgbi041_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi041
            CALL q_oocq002_2002()
            LET g_bgbi_d[l_ac].bgbi041 = g_qryparam.return1
            LET g_bgbi_d[l_ac].bgbi041_desc = g_qryparam.return1
            DISPLAY BY NAME g_bgbi_d[l_ac].bgbi041,g_bgbi_d[l_ac].bgbi041_desc
            NEXT FIELD bgbi041_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi028
            #add-point:ON ACTION controlp INFIELD bgbi028 name="input.c.page1.bgbi028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi028_desc
            #add-point:ON ACTION controlp INFIELD bgbi028_desc name="input.c.page1.bgbi028_desc"
            #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi028
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbi_d[l_ac].bgbi028 = g_qryparam.return1
               LET g_bgbi_d[l_ac].bgbi028_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbi_d[l_ac].bgbi028,g_bgbi_d[l_ac].bgbi028_desc
               NEXT FIELD bgbi028_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi029
            #add-point:ON ACTION controlp INFIELD bgbi029 name="input.c.page1.bgbi029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi029_desc
            #add-point:ON ACTION controlp INFIELD bgbi029_desc name="input.c.page1.bgbi029_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi029
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)
               LET g_bgbi_d[l_ac].bgbi029 = g_qryparam.return1
               LET g_bgbi_d[l_ac].bgbi029_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbi_d[l_ac].bgbi029,g_bgbi_d[l_ac].bgbi029_desc
               NEXT FIELD bgbi029_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi030
            #add-point:ON ACTION controlp INFIELD bgbi030 name="input.c.page1.bgbi030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi030_desc
            #add-point:ON ACTION controlp INFIELD bgbi030_desc name="input.c.page1.bgbi030_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi030
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbi_d[l_ac].bgbi030 = g_qryparam.return1
               LET g_bgbi_d[l_ac].bgbi030_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbi_d[l_ac].bgbi030,g_bgbi_d[l_ac].bgbi030_desc
               NEXT FIELD bgbi030_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi031
            #add-point:ON ACTION controlp INFIELD bgbi031 name="input.c.page1.bgbi031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi031_desc
            #add-point:ON ACTION controlp INFIELD bgbi031_desc name="input.c.page1.bgbi031_desc"
            #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi031
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbi_d[l_ac].bgbi031 = g_qryparam.return1
               LET g_bgbi_d[l_ac].bgbi031_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbi_d[l_ac].bgbi031,g_bgbi_d[l_ac].bgbi031_desc
               NEXT FIELD bgbi031_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi032
            #add-point:ON ACTION controlp INFIELD bgbi032 name="input.c.page1.bgbi032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi032_desc
            #add-point:ON ACTION controlp INFIELD bgbi032_desc name="input.c.page1.bgbi032_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi032
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbi_d[l_ac].bgbi032 = g_qryparam.return1
               LET g_bgbi_d[l_ac].bgbi032_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbi_d[l_ac].bgbi032,g_bgbi_d[l_ac].bgbi032_desc
               NEXT FIELD bgbi032_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi033
            #add-point:ON ACTION controlp INFIELD bgbi033 name="input.c.page1.bgbi033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi033_desc
            #add-point:ON ACTION controlp INFIELD bgbi033_desc name="input.c.page1.bgbi033_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi033
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbi_d[l_ac].bgbi033 = g_qryparam.return1
               LET g_bgbi_d[l_ac].bgbi033_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbi_d[l_ac].bgbi033,g_bgbi_d[l_ac].bgbi033_desc 
               NEXT FIELD bgbi033_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi034
            #add-point:ON ACTION controlp INFIELD bgbi034 name="input.c.page1.bgbi034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi034_desc
            #add-point:ON ACTION controlp INFIELD bgbi034_desc name="input.c.page1.bgbi034_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi034
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbi_d[l_ac].bgbi034 = g_qryparam.return1
               LET g_bgbi_d[l_ac].bgbi034_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbi_d[l_ac].bgbi034,g_bgbi_d[l_ac].bgbi034_desc
               NEXT FIELD bgbi034_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi035
            #add-point:ON ACTION controlp INFIELD bgbi035 name="input.c.page1.bgbi035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi035_desc
            #add-point:ON ACTION controlp INFIELD bgbi035_desc name="input.c.page1.bgbi035_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi035
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbi_d[l_ac].bgbi035 = g_qryparam.return1
               LET g_bgbi_d[l_ac].bgbi035_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbi_d[l_ac].bgbi035,g_bgbi_d[l_ac].bgbi035_desc
               NEXT FIELD bgbi035_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi036
            #add-point:ON ACTION controlp INFIELD bgbi036 name="input.c.page1.bgbi036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi036_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi036_desc
            #add-point:ON ACTION controlp INFIELD bgbi036_desc name="input.c.page1.bgbi036_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi036
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbi_d[l_ac].bgbi036 = g_qryparam.return1
               LET g_bgbi_d[l_ac].bgbi036_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbi_d[l_ac].bgbi036,g_bgbi_d[l_ac].bgbi036_desc
               NEXT FIELD bgbi036_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi037
            #add-point:ON ACTION controlp INFIELD bgbi037 name="input.c.page1.bgbi037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi037_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi037_desc
            #add-point:ON ACTION controlp INFIELD bgbi037_desc name="input.c.page1.bgbi037_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_bgbi_d[l_ac].bgbi037
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_bgbi_d[l_ac].bgbi037 = g_qryparam.return1
               LET g_bgbi_d[l_ac].bgbi037_desc = g_qryparam.return1
               DISPLAY BY NAME g_bgbi_d[l_ac].bgbi037,g_bgbi_d[l_ac].bgbi037_desc
               NEXT FIELD bgbi037_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi023
            #add-point:ON ACTION controlp INFIELD bgbi023 name="input.c.page1.bgbi023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi0232
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi0232
            #add-point:ON ACTION controlp INFIELD bgbi0232 name="input.c.page1.bgbi0232"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi0233
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi0233
            #add-point:ON ACTION controlp INFIELD bgbi0233 name="input.c.page1.bgbi0233"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi0234
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi0234
            #add-point:ON ACTION controlp INFIELD bgbi0234 name="input.c.page1.bgbi0234"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi0235
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi0235
            #add-point:ON ACTION controlp INFIELD bgbi0235 name="input.c.page1.bgbi0235"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi0236
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi0236
            #add-point:ON ACTION controlp INFIELD bgbi0236 name="input.c.page1.bgbi0236"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi0237
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi0237
            #add-point:ON ACTION controlp INFIELD bgbi0237 name="input.c.page1.bgbi0237"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi0238
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi0238
            #add-point:ON ACTION controlp INFIELD bgbi0238 name="input.c.page1.bgbi0238"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi0239
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi0239
            #add-point:ON ACTION controlp INFIELD bgbi0239 name="input.c.page1.bgbi0239"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi02310
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi02310
            #add-point:ON ACTION controlp INFIELD bgbi02310 name="input.c.page1.bgbi02310"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi02311
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi02311
            #add-point:ON ACTION controlp INFIELD bgbi02311 name="input.c.page1.bgbi02311"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi02312
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi02312
            #add-point:ON ACTION controlp INFIELD bgbi02312 name="input.c.page1.bgbi02312"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.bgbi02313
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbi02313
            #add-point:ON ACTION controlp INFIELD bgbi02313 name="input.c.page1.bgbi02313"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_bgbi_d[l_ac].* = g_bgbi_d_t.*
               CLOSE abgt027_bcl
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
               LET g_errparam.extend = g_bgbi_d[l_ac].bgbiseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_bgbi_d[l_ac].* = g_bgbi_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_bgbi2_d[l_ac].bgbimodid = g_user 
LET g_bgbi2_d[l_ac].bgbimoddt = cl_get_current()
LET g_bgbi2_d[l_ac].bgbimodid_desc = cl_get_username(g_bgbi2_d[l_ac].bgbimodid)
            
               #add-point:單身修改前 name="input.body.b_update"
            #新增/修改/刪除先寫入temptalbe
            IF g_bgbi_m.bgbi044 = "PASS" THEN
               #end add-point
         
               #將遮罩欄位還原
               CALL abgt027_bgbi_t_mask_restore('restore_mask_o')
         
               UPDATE bgbi_t SET (bgbi002,bgbi003,bgbi004,bgbi005,bgbi044,bgbistus,bgbiseq,bgbi038,bgbi007, 
                   bgbi008,bgbi009,bgbi010,bgbi011,bgbi012,bgbi013,bgbi014,bgbi015,bgbi016,bgbi039,bgbi040, 
                   bgbi041,bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,bgbi033,bgbi034,bgbi035,bgbi036,bgbi037, 
                   bgbi023,bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,bgbicrtdt,bgbimodid,bgbimoddt,bgbicnfid, 
                   bgbicnfdt) = (g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005, 
                   g_bgbi_m.bgbi044,g_bgbi_m.bgbistus,g_bgbi_d[l_ac].bgbiseq,g_bgbi_d[l_ac].bgbi038, 
                   g_bgbi_d[l_ac].bgbi007,g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi009,g_bgbi_d[l_ac].bgbi010, 
                   g_bgbi_d[l_ac].bgbi011,g_bgbi_d[l_ac].bgbi012,g_bgbi_d[l_ac].bgbi013,g_bgbi_d[l_ac].bgbi014, 
                   g_bgbi_d[l_ac].bgbi015,g_bgbi_d[l_ac].bgbi016,g_bgbi_d[l_ac].bgbi039,g_bgbi_d[l_ac].bgbi040, 
                   g_bgbi_d[l_ac].bgbi041,g_bgbi_d[l_ac].bgbi028,g_bgbi_d[l_ac].bgbi029,g_bgbi_d[l_ac].bgbi030, 
                   g_bgbi_d[l_ac].bgbi031,g_bgbi_d[l_ac].bgbi032,g_bgbi_d[l_ac].bgbi033,g_bgbi_d[l_ac].bgbi034, 
                   g_bgbi_d[l_ac].bgbi035,g_bgbi_d[l_ac].bgbi036,g_bgbi_d[l_ac].bgbi037,g_bgbi_d[l_ac].bgbi023, 
                   g_bgbi2_d[l_ac].bgbiownid,g_bgbi2_d[l_ac].bgbiowndp,g_bgbi2_d[l_ac].bgbicrtid,g_bgbi2_d[l_ac].bgbicrtdp, 
                   g_bgbi2_d[l_ac].bgbicrtdt,g_bgbi2_d[l_ac].bgbimodid,g_bgbi2_d[l_ac].bgbimoddt,g_bgbi2_d[l_ac].bgbicnfid, 
                   g_bgbi2_d[l_ac].bgbicnfdt)
                WHERE bgbient = g_enterprise AND bgbi002 = g_bgbi_m.bgbi002 
                 AND bgbi003 = g_bgbi_m.bgbi003 
                 AND bgbi004 = g_bgbi_m.bgbi004 
                 AND bgbi005 = g_bgbi_m.bgbi005 
                 AND bgbi044 = g_bgbi_m.bgbi044 
                 AND bgbistus = g_bgbi_m.bgbistus 
 
                 AND bgbiseq = g_bgbi_d_t.bgbiseq #項次   
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "bgbi_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "bgbi_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_bgbi_m.bgbi002
               LET gs_keys_bak[1] = g_bgbi002_t
               LET gs_keys[2] = g_bgbi_m.bgbi003
               LET gs_keys_bak[2] = g_bgbi003_t
               LET gs_keys[3] = g_bgbi_m.bgbi004
               LET gs_keys_bak[3] = g_bgbi004_t
               LET gs_keys[4] = g_bgbi_m.bgbi005
               LET gs_keys_bak[4] = g_bgbi005_t
               LET gs_keys[5] = g_bgbi_m.bgbi044
               LET gs_keys_bak[5] = g_bgbi044_t
               LET gs_keys[6] = g_bgbi_m.bgbistus
               LET gs_keys_bak[6] = g_bgbistus_t
               LET gs_keys[7] = g_bgbi_d[g_detail_idx].bgbiseq
               LET gs_keys_bak[7] = g_bgbi_d_t.bgbiseq
               CALL abgt027_update_b('bgbi_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_bgbi_m),util.JSON.stringify(g_bgbi_d_t)
                     LET g_log2 = util.JSON.stringify(g_bgbi_m),util.JSON.stringify(g_bgbi_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL abgt027_bgbi_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_bgbi_m.bgbi002
               LET ls_keys[ls_keys.getLength()+1] = g_bgbi_m.bgbi003
               LET ls_keys[ls_keys.getLength()+1] = g_bgbi_m.bgbi004
               LET ls_keys[ls_keys.getLength()+1] = g_bgbi_m.bgbi005
               LET ls_keys[ls_keys.getLength()+1] = g_bgbi_m.bgbi044
               LET ls_keys[ls_keys.getLength()+1] = g_bgbi_m.bgbistus
 
               LET ls_keys[ls_keys.getLength()+1] = g_bgbi_d_t.bgbiseq
 
               CALL abgt027_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
            END IF
               UPDATE abgt027_tmp SET (bgbient,bgbiseq,bgbi002,bgbi003,bgbi045,
                                       bgbi004,bgbi005,bgbi017,bgbi046,bgbi044,
                                       bgbistus,
                                       bgbi007,bgbi008,bgbi009,bgbi010,
                                       bgbi011,bgbi012,bgbi013,bgbi014,bgbi015,
                                       bgbi016,bgbi039,bgbi040,bgbi041,
                                       bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,
                                       bgbi033,bgbi034,bgbi035,bgbi036,bgbi037,
                                       bgbi023,bgbi0232,bgbi0233,bgbi0234,bgbi0235,
                                       bgbi0236,bgbi0237,bgbi0238,bgbi0239,bgbi02310,
                                       bgbi02311,bgbi02312,bgbi02313,l_sum,
                                       bgbi038,
                                       bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,bgbicrtdt,
                                       bgbimodid,bgbimoddt
                                      ) = (
               g_enterprise,g_bgbi_d[l_ac].bgbiseq,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,
               g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,'1',
               g_bgbi_m.bgbistus,
               g_bgbi_d[l_ac].bgbi007,g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi009,g_bgbi_d[l_ac].bgbi010,
               g_bgbi_d[l_ac].bgbi011,g_bgbi_d[l_ac].bgbi012,g_bgbi_d[l_ac].bgbi013,g_bgbi_d[l_ac].bgbi014,g_bgbi_d[l_ac].bgbi015,
               g_bgbi_d[l_ac].bgbi016,g_bgbi_d[l_ac].bgbi039,g_bgbi_d[l_ac].bgbi040,g_bgbi_d[l_ac].bgbi041,
               g_bgbi_d[l_ac].bgbi028,g_bgbi_d[l_ac].bgbi029,g_bgbi_d[l_ac].bgbi030,g_bgbi_d[l_ac].bgbi031,g_bgbi_d[l_ac].bgbi032,
               g_bgbi_d[l_ac].bgbi033,g_bgbi_d[l_ac].bgbi034,g_bgbi_d[l_ac].bgbi035,g_bgbi_d[l_ac].bgbi036,g_bgbi_d[l_ac].bgbi037,
               g_bgbi_d[l_ac].bgbi023,g_bgbi_d[l_ac].bgbi0232,g_bgbi_d[l_ac].bgbi0233,g_bgbi_d[l_ac].bgbi0234,g_bgbi_d[l_ac].bgbi0235,
               g_bgbi_d[l_ac].bgbi0236,g_bgbi_d[l_ac].bgbi0237,g_bgbi_d[l_ac].bgbi0238,g_bgbi_d[l_ac].bgbi0239,g_bgbi_d[l_ac].bgbi02310,
               g_bgbi_d[l_ac].bgbi02311,g_bgbi_d[l_ac].bgbi02312,g_bgbi_d[l_ac].bgbi02313,g_bgbi_d[l_ac].l_sum,
               g_bgbi_d[l_ac].bgbi038,
               g_bgbi2_d[l_ac].bgbiownid,g_bgbi2_d[l_ac].bgbiowndp,g_bgbi2_d[l_ac].bgbicrtid,g_bgbi2_d[l_ac].bgbicrtdp,g_bgbi2_d[l_ac].bgbicrtdt,
               g_bgbi2_d[l_ac].bgbimodid,g_bgbi2_d[l_ac].bgbimoddt
               )
                WHERE bgbient = g_enterprise
                  AND bgbi002 = g_bgbi_m.bgbi002
                  AND bgbi003 = g_bgbi_m.bgbi003
                  AND bgbi004 = g_bgbi_m.bgbi004
                  AND bgbi005 = g_bgbi_m.bgbi005
                  AND bgbi044 = g_bgbi_m.bgbi044
                  AND bgbiseq = g_bgbi_d_t.bgbiseq
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "bgbi_t"
                     LET g_errparam.code   = "std-00009"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_bgbi_d[l_ac].* = g_bgbi_d_t.*
                     EXIT DIALOG
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "bgbi_t:",SQLERRMESSAGE
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_bgbi_d[l_ac].* = g_bgbi_d_t.*
                     EXIT DIALOG
               END CASE
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE abgt027_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_bgbi_d[l_ac].* = g_bgbi_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE abgt027_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_bgbi_d.getLength() = 0 THEN
               NEXT FIELD bgbiseq
            END IF
            #add-point:input段after input  name="input.body.after_input"
            DISPLAY "AFTER_INPUT_INSERT"
            
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 9001
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_bgbi_d[l_ac].* = g_bgbi_d_t.*
               CLOSE abgt027_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF
            
            #先全部刪除資料再寫入
            DELETE FROM bgbi_t
             WHERE bgbient = g_enterprise
               AND bgbi002 = g_bgbi_m.bgbi002
               AND bgbi003 = g_bgbi_m.bgbi003
               AND bgbi004 = g_bgbi_m.bgbi004
               AND bgbi005 = g_bgbi_m.bgbi005
               AND bgbi044 = g_bgbi_m.bgbi044
               AND bgbistus = g_bgbi_m.bgbistus
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "bgbi_t:",SQLERRMESSAGE
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            
            CALL s_transaction_begin()
            
            LET l_sql = "SELECT bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,",  #固定核算項
                        "       bgbi012,bgbi013,bgbi014,bgbi015,bgbi016,",  #固定核算項
                        "       bgbi039,bgbi040,bgbi041,",                  #固定核算項
                        "       bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,",  #自由核算項1~5
                        "       bgbi033,bgbi034,bgbi035,bgbi036,bgbi037,",  #自由核算項6~10
                        "       bgbi023,bgbi0232,bgbi0233,bgbi0234,bgbi0235,",
                        "       bgbi0236,bgbi0237,bgbi0238,bgbi0239,bgbi02310,",
                        "       bgbi02311,bgbi02312,bgbi02313,",
                        "       bgbi038,",
                        "       bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,bgbicrtdt,",
                        "       bgbimodid,bgbimoddt",
                        "  FROM abgt027_tmp",
                        " WHERE bgbient = ",g_enterprise,
                        "   AND bgbi002 = '",g_bgbi_m.bgbi002,"'",
                        "   AND bgbi003 = '",g_bgbi_m.bgbi003,"'",
                        "   AND bgbi004 = '",g_bgbi_m.bgbi004,"'",
                        "   AND bgbi005 = '",g_bgbi_m.bgbi005,"'",
                        "   AND bgbi044 = '1' ",
                        "   AND bgbistus = '",g_bgbi_m.bgbistus,"'",
                        " ORDER BY bgbiseq"
            PREPARE abgt027_sel_pre1 FROM l_sql
            DECLARE abgt027_sel_cur1 CURSOR FOR abgt027_sel_pre1
            FOREACH abgt027_sel_cur1 INTO l_bgbi.bgbi007,l_bgbi.bgbi008,l_bgbi.bgbi009,l_bgbi.bgbi010,l_bgbi.bgbi011,
                                          l_bgbi.bgbi012,l_bgbi.bgbi013,l_bgbi.bgbi014,l_bgbi.bgbi015,l_bgbi.bgbi016,
                                          l_bgbi.bgbi039,l_bgbi.bgbi040,l_bgbi.bgbi041,
                                          l_bgbi.bgbi028,l_bgbi.bgbi029,l_bgbi.bgbi030,l_bgbi.bgbi031,l_bgbi.bgbi032,
                                          l_bgbi.bgbi033,l_bgbi.bgbi034,l_bgbi.bgbi035,l_bgbi.bgbi036,l_bgbi.bgbi037, 
                                          l_bgbi.bgbi023,l_bgbi.bgbi0232,l_bgbi.bgbi0233,l_bgbi.bgbi0234,l_bgbi.bgbi0235,
                                          l_bgbi.bgbi0236,l_bgbi.bgbi0237,l_bgbi.bgbi0238,l_bgbi.bgbi0239,l_bgbi.bgbi02310,
                                          l_bgbi.bgbi02311,l_bgbi.bgbi02312,l_bgbi.bgbi02313,
                                          l_bgbi.bgbi038,
                                          l_bgbi2.bgbiownid,l_bgbi2.bgbiowndp,l_bgbi2.bgbicrtid,l_bgbi2.bgbicrtdp,l_bgbi2.bgbicrtdt,
                                          l_bgbi2.bgbimodid,l_bgbi2.bgbimoddt
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT FOREACH
               END IF
               
               #每一項次有13期，所以要寫入13筆資料
               FOR l_i = 1 TO 13
                  LET l_write = "N"
                  LET l_bgbi023 = 0
                  CASE l_i
                     WHEN 1
                        IF l_bgbi.bgbi023 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi023
                        END IF
                     WHEN 2
                        IF l_bgbi.bgbi0232 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi0232
                        END IF
                     WHEN 3
                        IF l_bgbi.bgbi0233 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi0233
                        END IF
                     WHEN 4
                        IF l_bgbi.bgbi0234 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi0234
                        END IF
                     WHEN 5
                        IF l_bgbi.bgbi0235 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi0235
                        END IF
                     WHEN 6
                        IF l_bgbi.bgbi0236 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi0236
                        END IF
                     WHEN 7
                        IF l_bgbi.bgbi0237 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi0237
                        END IF
                     WHEN 8
                        IF l_bgbi.bgbi0238 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 =l_bgbi .bgbi0238
                        END IF
                     WHEN 9
                        IF l_bgbi.bgbi0239 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi0239
                        END IF
                     WHEN 10
                        IF l_bgbi.bgbi02310 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi02310
                        END IF
                     WHEN 11
                        IF l_bgbi.bgbi02311 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi02311
                        END IF
                     WHEN 12
                        IF l_bgbi.bgbi02312 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi02312
                        END IF
                     WHEN 13
                        IF l_bgbi.bgbi02313 > 0 THEN
                           LET l_write = "Y"
                           LET l_bgbi023 = l_bgbi.bgbi02313
                        END IF
                  END CASE
                  IF l_write = "Y" AND l_bgbi023 > 0 THEN
                     SELECT MAX(bgbiseq)+1 INTO l_bgbi.bgbiseq
                       FROM bgbi_t
                      WHERE bgbi002 = g_bgbi_m.bgbi002
                        AND bgbi003 = g_bgbi_m.bgbi003
                        AND bgbi004 = g_bgbi_m.bgbi004
                        AND bgbi005 = g_bgbi_m.bgbi005
                        AND bgbi044 = '1'
                        AND bgbient = g_enterprise #160905-00002#2 
                     IF cl_null(l_bgbi.bgbiseq)THEN LET l_bgbi.bgbiseq = 1 END IF
                     IF cl_null(g_bgbi043)THEN LET g_bgbi043 = 1 END IF
                     INSERT INTO bgbi_t (bgbient,bgbi002,bgbi003,bgbi045,bgbi004,bgbi005,
                                         bgbi017,bgbi046,bgbi044,
                                         bgbiseq,bgbi006,
                                         bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,
                                         bgbi012,bgbi013,bgbi014,bgbi015,bgbi016,
                                         bgbi039,bgbi040,bgbi041,
                                         bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,
                                         bgbi033,bgbi034,bgbi035,bgbi036,bgbi037,
                                         bgbi023,
                                         bgbi018,bgbi019,bgbi020,bgbi021,bgbi022,
                                         bgbi024,bgbi025,bgbi026,bgbi027,bgbi038,
                                         bgbi043,bgbistus,
                                         bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,bgbicrtdt,
                                         bgbimodid,bgbimoddt
                                         ) 
                     VALUES(g_enterprise,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,
                            g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,'1',
                            l_bgbi.bgbiseq,l_i,
                            l_bgbi.bgbi007,l_bgbi.bgbi008,l_bgbi.bgbi009,l_bgbi.bgbi010,l_bgbi.bgbi011,
                            l_bgbi.bgbi012,l_bgbi.bgbi013,l_bgbi.bgbi014,l_bgbi.bgbi015,l_bgbi.bgbi016,
                            l_bgbi.bgbi039,l_bgbi.bgbi040,l_bgbi.bgbi041,
                            l_bgbi.bgbi028,l_bgbi.bgbi029,l_bgbi.bgbi030,l_bgbi.bgbi031,l_bgbi.bgbi032, 
                            l_bgbi.bgbi033,l_bgbi.bgbi034,l_bgbi.bgbi035,l_bgbi.bgbi036,l_bgbi.bgbi037,
                            l_bgbi023,
                            l_bgbi023,l_bgbi023,'',1,l_bgbi023,
                            0,0,0,l_bgbi023,l_bgbi.bgbi038,
                            g_bgbi043,'N',
                            l_bgbi2.bgbiownid,l_bgbi2.bgbiowndp,l_bgbi2.bgbicrtid,l_bgbi2.bgbicrtdp,l_bgbi2.bgbicrtdt,
                            l_bgbi2.bgbimodid,l_bgbi2.bgbimoddt
                            )
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = ""
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        EXIT FOREACH
                     END IF
                  END IF
               END FOR
            END FOREACH
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_bgbi_d[li_reproduce_target].* = g_bgbi_d[li_reproduce].*
               LET g_bgbi2_d[li_reproduce_target].* = g_bgbi2_d[li_reproduce].*
 
               LET g_bgbi_d[li_reproduce_target].bgbiseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_bgbi_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_bgbi_d.getLength()+1
            END IF
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_bgbi2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL abgt027_b_fill(g_wc2) #test 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_page = 2
            CALL abgt027_idx_chk()
            CALL abgt027_ui_detailshow()
        
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
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD bgbi002
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD bgbiseq
               WHEN "s_detail2"
                  NEXT FIELD bgbiseq_2
 
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
   IF l_flag = 'Y' THEN
      CONTINUE WHILE
   ELSE
      EXIT WHILE
   END IF
END WHILE
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION abgt027_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL abgt027_b_fill(g_wc2) #第一階單身填充
      CALL abgt027_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL abgt027_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   CALL abgt027_set_entry_bgbi046(g_bgbi_m.bgbi002,g_bgbi_m.bgbi045,g_bgbi_m.bgbi046)
   CALL abgt027_ld_info(g_bgbi_m.bgbi004) RETURNING g_glaald
   #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼/使用科目預算
   SELECT bgaa002,bgaa003,bgaa008,bgaa009,bgaa012 INTO g_bgaa.*
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_bgbi_m.bgbi002
   LET g_bgbi_m.l_bgaa002 = g_bgaa.bgaa002
   LET g_bgbi_m.bgbi017 = g_bgaa.bgaa003
   #設定顯示13期否
   CALL abgt027_set_entry_period(g_bgaa.bgaa002)
   DISPLAY BY NAME g_bgbi_m.l_bgaa002,g_bgbi_m.bgbi017
   #取得abgi200匯率
   CALL s_abg_get_rate(g_bgbi_m.bgbi002,g_today,g_bgbi_m.bgbi017)RETURNING g_sub_success,g_errno,g_bgbi043
   IF g_bgaa.bgaa012 = 'Y' THEN #使用科目預算
      LET g_glac002 = g_bgbi_m.bgbi005
   ELSE
      CALL abgt027_get_bgao003(g_bgaa.bgaa008,g_bgbi_m.bgbi005)RETURNING g_glac002
   END IF
   LET g_bgbi_m.bgbi002_desc = s_desc_get_budget_desc(g_bgbi_m.bgbi002)
   LET g_bgbi_m.bgbi045_desc = s_desc_get_department_desc(g_bgbi_m.bgbi045)
   LET g_bgbi_m.bgbi004_desc = s_desc_get_department_desc(g_bgbi_m.bgbi004)
   LET g_bgbi_m.bgbi005_desc = s_abg_bgae001_desc(g_bgaa.bgaa008,g_bgbi_m.bgbi005)
   
   #SELECT DISTINCT bgbistus INTO g_bgbi_m.bgbistus
   #  FROM abgt027_tmp
   # WHERE bgbient=g_enterprise AND bgbi002=g_bgbi_m.bgbi002 AND bgbi003=g_bgbi_m.bgbi003
   #   AND bgbi004=g_bgbi_m.bgbi004 AND bgbi005=g_bgbi_m.bgbi005 AND bgbi044=g_bgbi_m.bgbi044
   #DISPLAY BY NAME g_bgbi_m.bgbistus
   CALL abgt027_set_act_visible()
   CALL abgt027_set_act_no_visible()
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_bgbi_m.bgbi002,g_bgbi_m.bgbi002_desc,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi045_desc, 
       g_bgbi_m.bgbi004,g_bgbi_m.bgbi004_desc,g_bgbi_m.bgbi005,g_bgbi_m.bgbi005_desc,g_bgbi_m.l_bgaa002, 
       g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
 
   CALL abgt027_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   CASE g_bgbi_m.bgbistus
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
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION abgt027_ref_show()
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
   FOR l_ac = 1 TO g_bgbi_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      #現金變動碼
      LET g_bgbi_d[l_ac].bgbi038_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi038,s_desc_get_nmail004_desc(g_bgaa.bgaa009,g_bgbi_d[l_ac].bgbi038))
      #固定核算項
      #部門
      LET g_bgbi_d[l_ac].bgbi007_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi007,s_desc_get_department_desc(g_bgbi_d[l_ac].bgbi007))
      #成本利潤中心
      LET g_bgbi_d[l_ac].bgbi008_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi008,s_desc_get_department_desc(g_bgbi_d[l_ac].bgbi008))
      #區域
      LET g_bgbi_d[l_ac].bgbi009_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi009,s_desc_get_acc_desc('287',g_bgbi_d[l_ac].bgbi009))
      #交易客商
      LET g_bgbi_d[l_ac].bgbi010_desc  = s_desc_show1(g_bgbi_d[l_ac].bgbi010,s_desc_get_trading_partner_abbr_desc(g_bgbi_d[l_ac].bgbi010))
      #收款客商
      LET g_bgbi_d[l_ac].bgbi011_desc  = s_desc_show1(g_bgbi_d[l_ac].bgbi011,s_desc_get_trading_partner_abbr_desc(g_bgbi_d[l_ac].bgbi011))
      #客群
      LET g_bgbi_d[l_ac].bgbi012_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi012,s_desc_get_acc_desc('281',g_bgbi_d[l_ac].bgbi012))
      #產品類別
      LET g_bgbi_d[l_ac].bgbi013_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi013,s_desc_get_rtaxl003_desc(g_bgbi_d[l_ac].bgbi013))
      #人員
      LET g_bgbi_d[l_ac].bgbi014_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi014,s_desc_get_person_desc(g_bgbi_d[l_ac].bgbi014))
      #專案編號
      LET g_bgbi_d[l_ac].bgbi015_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi015,s_desc_get_project_desc(g_bgbi_d[l_ac].bgbi015))
      #WBS
      LET g_bgbi_d[l_ac].bgbi016_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi016,s_desc_get_pjbbl004_desc(g_bgbi_d[l_ac].bgbi015,g_bgbi_d[l_ac].bgbi016))
      #經營方式
      LET g_bgbi_d[l_ac].bgbi039_desc = g_bgbi_d[l_ac].bgbi039
      #渠道
      LET g_bgbi_d[l_ac].bgbi040_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi040,s_desc_get_oojdl003_desc(g_bgbi_d[l_ac].bgbi040))
      #品牌
      LET g_bgbi_d[l_ac].bgbi041_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi041,s_desc_get_acc_desc('2002',g_bgbi_d[l_ac].bgbi041))
      
      
      #自由核算項
      CALL s_fin_sel_glad(g_glaald,g_glac002,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
           RETURNING g_errno,g_glad.*
      
      IF NOT cl_null(g_bgbi_d[l_ac].bgbi028) THEN
         LET g_bgbi_d[l_ac].bgbi028_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi028,s_fin_get_accting_desc(g_glad.glad0171,g_bgbi_d[l_ac].bgbi028))
      END IF
      IF NOT cl_null(g_bgbi_d[l_ac].bgbi029) THEN
         LET g_bgbi_d[l_ac].bgbi029_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi029,s_fin_get_accting_desc(g_glad.glad0181,g_bgbi_d[l_ac].bgbi029))
      END IF
      IF NOT cl_null(g_bgbi_d[l_ac].bgbi030) THEN
         LET g_bgbi_d[l_ac].bgbi030_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi030,s_fin_get_accting_desc(g_glad.glad0191,g_bgbi_d[l_ac].bgbi030))
      END IF
      IF NOT cl_null(g_bgbi_d[l_ac].bgbi031) THEN
         LET g_bgbi_d[l_ac].bgbi031_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi031,s_fin_get_accting_desc(g_glad.glad0201,g_bgbi_d[l_ac].bgbi031))
      END IF
      IF NOT cl_null(g_bgbi_d[l_ac].bgbi032) THEN
         LET g_bgbi_d[l_ac].bgbi032_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi032,s_fin_get_accting_desc(g_glad.glad0211,g_bgbi_d[l_ac].bgbi032))
      END IF
      IF NOT cl_null(g_bgbi_d[l_ac].bgbi033) THEN
         LET g_bgbi_d[l_ac].bgbi033_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi033,s_fin_get_accting_desc(g_glad.glad0221,g_bgbi_d[l_ac].bgbi033))
      END IF
      IF NOT cl_null(g_bgbi_d[l_ac].bgbi034) THEN
         LET g_bgbi_d[l_ac].bgbi034_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi034,s_fin_get_accting_desc(g_glad.glad0231,g_bgbi_d[l_ac].bgbi034))
      END IF
      IF NOT cl_null(g_bgbi_d[l_ac].bgbi035) THEN
         LET g_bgbi_d[l_ac].bgbi035_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi035,s_fin_get_accting_desc(g_glad.glad0241,g_bgbi_d[l_ac].bgbi035))
      END IF
      IF NOT cl_null(g_bgbi_d[l_ac].bgbi036) THEN
         LET g_bgbi_d[l_ac].bgbi036_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi036,s_fin_get_accting_desc(g_glad.glad0251,g_bgbi_d[l_ac].bgbi036))
      END IF
      IF NOT cl_null(g_bgbi_d[l_ac].bgbi037) THEN
         LET g_bgbi_d[l_ac].bgbi037_desc = s_desc_show1(g_bgbi_d[l_ac].bgbi037,s_fin_get_accting_desc(g_glad.glad0261,g_bgbi_d[l_ac].bgbi037))
      END IF
      
      LET g_bgbi2_d[l_ac].bgbiownid_desc = s_desc_get_person_desc(g_bgbi2_d[l_ac].bgbiownid)
      LET g_bgbi2_d[l_ac].bgbiowndp_desc = s_desc_get_department_desc(g_bgbi2_d[l_ac].bgbiowndp)
      LET g_bgbi2_d[l_ac].bgbicrtid_desc = s_desc_get_person_desc(g_bgbi2_d[l_ac].bgbicrtid)
      LET g_bgbi2_d[l_ac].bgbicrtdp_desc = s_desc_get_department_desc(g_bgbi2_d[l_ac].bgbicrtdp)
      LET g_bgbi2_d[l_ac].bgbimodid_desc = s_desc_get_person_desc(g_bgbi2_d[l_ac].bgbimodid)
      LET g_bgbi2_d[l_ac].bgbicnfid_desc = s_desc_get_person_desc(g_bgbi2_d[l_ac].bgbicnfid)
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_bgbi2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="abgt027.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION abgt027_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE bgbi_t.bgbi002 
   DEFINE l_oldno     LIKE bgbi_t.bgbi002 
   DEFINE l_newno02     LIKE bgbi_t.bgbi003 
   DEFINE l_oldno02     LIKE bgbi_t.bgbi003 
   DEFINE l_newno03     LIKE bgbi_t.bgbi004 
   DEFINE l_oldno03     LIKE bgbi_t.bgbi004 
   DEFINE l_newno04     LIKE bgbi_t.bgbi005 
   DEFINE l_oldno04     LIKE bgbi_t.bgbi005 
   DEFINE l_newno05     LIKE bgbi_t.bgbi044 
   DEFINE l_oldno05     LIKE bgbi_t.bgbi044 
   DEFINE l_newno06     LIKE bgbi_t.bgbistus 
   DEFINE l_oldno06     LIKE bgbi_t.bgbistus 
 
   DEFINE l_master    RECORD LIKE bgbi_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE bgbi_t.* #此變數樣板目前無使用
 
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
 
   IF g_bgbi_m.bgbi002 IS NULL
      OR g_bgbi_m.bgbi003 IS NULL
      OR g_bgbi_m.bgbi004 IS NULL
      OR g_bgbi_m.bgbi005 IS NULL
      OR g_bgbi_m.bgbi044 IS NULL
      OR g_bgbi_m.bgbistus IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_bgbi002_t = g_bgbi_m.bgbi002
   LET g_bgbi003_t = g_bgbi_m.bgbi003
   LET g_bgbi004_t = g_bgbi_m.bgbi004
   LET g_bgbi005_t = g_bgbi_m.bgbi005
   LET g_bgbi044_t = g_bgbi_m.bgbi044
   LET g_bgbistus_t = g_bgbi_m.bgbistus
 
   
   LET g_bgbi_m.bgbi002 = ""
   LET g_bgbi_m.bgbi003 = ""
   LET g_bgbi_m.bgbi004 = ""
   LET g_bgbi_m.bgbi005 = ""
   LET g_bgbi_m.bgbi044 = ""
   LET g_bgbi_m.bgbistus = ""
 
   LET g_master_insert = FALSE
   CALL abgt027_set_entry('a')
   CALL abgt027_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_bgbi_m.bgbi002_desc = ''
   DISPLAY BY NAME g_bgbi_m.bgbi002_desc
   LET g_bgbi_m.bgbi004_desc = ''
   DISPLAY BY NAME g_bgbi_m.bgbi004_desc
   LET g_bgbi_m.bgbi005_desc = ''
   DISPLAY BY NAME g_bgbi_m.bgbi005_desc
 
   
   CALL abgt027_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_bgbi_m.* TO NULL
      INITIALIZE g_bgbi_d TO NULL
      INITIALIZE g_bgbi2_d TO NULL
 
      CALL abgt027_show()
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
   CALL abgt027_set_act_visible()
   CALL abgt027_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_bgbi002_t = g_bgbi_m.bgbi002
   LET g_bgbi003_t = g_bgbi_m.bgbi003
   LET g_bgbi004_t = g_bgbi_m.bgbi004
   LET g_bgbi005_t = g_bgbi_m.bgbi005
   LET g_bgbi044_t = g_bgbi_m.bgbi044
   LET g_bgbistus_t = g_bgbi_m.bgbistus
 
   
   #組合新增資料的條件
   LET g_add_browse = " bgbient = " ||g_enterprise|| " AND",
                      " bgbi002 = '", g_bgbi_m.bgbi002, "' "
                      ," AND bgbi003 = '", g_bgbi_m.bgbi003, "' "
                      ," AND bgbi004 = '", g_bgbi_m.bgbi004, "' "
                      ," AND bgbi005 = '", g_bgbi_m.bgbi005, "' "
                      ," AND bgbi044 = '", g_bgbi_m.bgbi044, "' "
                      ," AND bgbistus = '", g_bgbi_m.bgbistus, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL abgt027_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL abgt027_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL abgt027_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION abgt027_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE bgbi_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE abgt027_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM bgbi_t
    WHERE bgbient = g_enterprise AND bgbi002 = g_bgbi002_t
    AND bgbi003 = g_bgbi003_t
    AND bgbi004 = g_bgbi004_t
    AND bgbi005 = g_bgbi005_t
    AND bgbi044 = g_bgbi044_t
    AND bgbistus = g_bgbistus_t
 
       INTO TEMP abgt027_detail
   
   #將key修正為調整後   
   UPDATE abgt027_detail 
      #更新key欄位
      SET bgbi002 = g_bgbi_m.bgbi002
          , bgbi003 = g_bgbi_m.bgbi003
          , bgbi004 = g_bgbi_m.bgbi004
          , bgbi005 = g_bgbi_m.bgbi005
          , bgbi044 = g_bgbi_m.bgbi044
          , bgbistus = g_bgbi_m.bgbistus
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , bgbiownid = g_user 
       , bgbiowndp = g_dept
       , bgbicrtid = g_user
       , bgbicrtdp = g_dept 
       , bgbicrtdt = ld_date
       , bgbimodid = g_user
       , bgbimoddt = ld_date
 
 
 
                                       
   #將資料塞回原table   
   INSERT INTO bgbi_t SELECT * FROM abgt027_detail
   
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
   DROP TABLE abgt027_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_bgbi002_t = g_bgbi_m.bgbi002
   LET g_bgbi003_t = g_bgbi_m.bgbi003
   LET g_bgbi004_t = g_bgbi_m.bgbi004
   LET g_bgbi005_t = g_bgbi_m.bgbi005
   LET g_bgbi044_t = g_bgbi_m.bgbi044
   LET g_bgbistus_t = g_bgbi_m.bgbistus
 
   
   DROP TABLE abgt027_detail
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.delete" >}
#+ 資料刪除
PRIVATE FUNCTION abgt027_delete()
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
    #160818-00017#3  2016/08/24 By 07900 --add--s--
      #檢查是否允許此動作
      IF NOT abgt027_action_chk() THEN
        # CALL s_transaction_end('N','0')
         RETURN
      END IF
      #160818-00017#3  2016/08/24 By 07900 --add--e--
   #end add-point
   
   IF g_bgbi_m.bgbi002 IS NULL
   OR g_bgbi_m.bgbi003 IS NULL
   OR g_bgbi_m.bgbi004 IS NULL
   OR g_bgbi_m.bgbi005 IS NULL
   OR g_bgbi_m.bgbi044 IS NULL
   OR g_bgbi_m.bgbistus IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN abgt027_cl USING g_enterprise,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt027_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE abgt027_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE abgt027_master_referesh USING g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005, 
       g_bgbi_m.bgbi044,g_bgbi_m.bgbistus INTO g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004, 
       g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
   
   #遮罩相關處理
   LET g_bgbi_m_mask_o.* =  g_bgbi_m.*
   CALL abgt027_bgbi_t_mask()
   LET g_bgbi_m_mask_n.* =  g_bgbi_m.*
   
   CALL abgt027_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL abgt027_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM bgbi_t WHERE bgbient = g_enterprise AND bgbi002 = g_bgbi_m.bgbi002
                                                               AND bgbi003 = g_bgbi_m.bgbi003
                                                               AND bgbi004 = g_bgbi_m.bgbi004
                                                               AND bgbi005 = g_bgbi_m.bgbi005
                                                               AND bgbi044 = g_bgbi_m.bgbi044
                                                               AND bgbistus = g_bgbi_m.bgbistus
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "bgbi_t:",SQLERRMESSAGE 
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
      #   CLOSE abgt027_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_bgbi_d.clear() 
      CALL g_bgbi2_d.clear()       
 
     
      CALL abgt027_ui_browser_refresh()  
      #CALL abgt027_ui_headershow()  
      #CALL abgt027_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL abgt027_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL abgt027_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE abgt027_cl
 
   #功能已完成,通報訊息中心
   CALL abgt027_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="abgt027.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgt027_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_bgbi_d.clear()
   CALL g_bgbi2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL abgt027_insert_tmp()
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT bgbiseq,bgbi038,bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,bgbi012,bgbi013, 
       bgbi014,bgbi015,bgbi016,bgbi039,bgbi040,bgbi041,bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,bgbi033, 
       bgbi034,bgbi035,bgbi036,bgbi037,bgbi023,bgbiseq,bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,bgbicrtdt, 
       bgbimodid,bgbimoddt,bgbicnfid,bgbicnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 , 
       t6.ooag011 FROM bgbi_t",   
               "",
               
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=bgbiownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=bgbiowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=bgbicrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=bgbicrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=bgbimodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=bgbicnfid  ",
 
               " WHERE bgbient= ? AND bgbi002=? AND bgbi003=? AND bgbi004=? AND bgbi005=? AND bgbi044=? AND bgbistus=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("bgbi_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF abgt027_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY bgbi_t.bgbiseq"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE abgt027_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR abgt027_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005, 
          g_bgbi_m.bgbi044,g_bgbi_m.bgbistus INTO g_bgbi_d[l_ac].bgbiseq,g_bgbi_d[l_ac].bgbi038,g_bgbi_d[l_ac].bgbi007, 
          g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi009,g_bgbi_d[l_ac].bgbi010,g_bgbi_d[l_ac].bgbi011, 
          g_bgbi_d[l_ac].bgbi012,g_bgbi_d[l_ac].bgbi013,g_bgbi_d[l_ac].bgbi014,g_bgbi_d[l_ac].bgbi015, 
          g_bgbi_d[l_ac].bgbi016,g_bgbi_d[l_ac].bgbi039,g_bgbi_d[l_ac].bgbi040,g_bgbi_d[l_ac].bgbi041, 
          g_bgbi_d[l_ac].bgbi028,g_bgbi_d[l_ac].bgbi029,g_bgbi_d[l_ac].bgbi030,g_bgbi_d[l_ac].bgbi031, 
          g_bgbi_d[l_ac].bgbi032,g_bgbi_d[l_ac].bgbi033,g_bgbi_d[l_ac].bgbi034,g_bgbi_d[l_ac].bgbi035, 
          g_bgbi_d[l_ac].bgbi036,g_bgbi_d[l_ac].bgbi037,g_bgbi_d[l_ac].bgbi023,g_bgbi2_d[l_ac].bgbiseq, 
          g_bgbi2_d[l_ac].bgbiownid,g_bgbi2_d[l_ac].bgbiowndp,g_bgbi2_d[l_ac].bgbicrtid,g_bgbi2_d[l_ac].bgbicrtdp, 
          g_bgbi2_d[l_ac].bgbicrtdt,g_bgbi2_d[l_ac].bgbimodid,g_bgbi2_d[l_ac].bgbimoddt,g_bgbi2_d[l_ac].bgbicnfid, 
          g_bgbi2_d[l_ac].bgbicnfdt,g_bgbi2_d[l_ac].bgbiownid_desc,g_bgbi2_d[l_ac].bgbiowndp_desc,g_bgbi2_d[l_ac].bgbicrtid_desc, 
          g_bgbi2_d[l_ac].bgbicrtdp_desc,g_bgbi2_d[l_ac].bgbimodid_desc,g_bgbi2_d[l_ac].bgbicnfid_desc  
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
 
            CALL g_bgbi_d.deleteElement(g_bgbi_d.getLength())
      CALL g_bgbi2_d.deleteElement(g_bgbi2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   LET g_sql = "SELECT DISTINCT bgbiseq,bgbi038,",
               "                bgbi007,bgbi008,bgbi009,bgbi010,",
               "                bgbi011,bgbi012,bgbi013,bgbi014,bgbi015,",
               "                bgbi016,bgbi039,bgbi040,bgbi041,",
               "                bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,",
               "                bgbi033,bgbi034,bgbi035,bgbi036,bgbi037,",
               "                bgbi023,bgbi0232,bgbi0233,bgbi0234,bgbi0235,",
               "                bgbi0236,bgbi0237,bgbi0238,bgbi0239,bgbi02310,",
               "                bgbi02311,bgbi02312,bgbi02313,l_sum,",
               "                bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,bgbicrtdt,",
               "                bgbimodid,bgbimoddt,bgbicnfid,bgbicnfdt",
               "  FROM abgt027_tmp",
               " WHERE bgbient=? AND bgbi002=? AND bgbi003=? AND bgbi004=? AND bgbi005=? AND bgbi044=? AND bgbistus=?"
   LET g_sql = cl_sql_add_mask(g_sql)
   IF NOT cl_null(g_wc2_table1) THEN
      CALL s_chr_replace(g_wc2_table1,'_desc','',0) RETURNING g_wc2_table1
      LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
   END IF
   LET g_sql = g_sql, " ORDER BY bgbiseq"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE abgt027_pb2 FROM g_sql
   DECLARE abgt027_cs2 CURSOR FOR abgt027_pb2
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN abgt027_cs2 USING g_enterprise,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
   
   FOREACH abgt027_cs2 INTO g_bgbi_d[l_ac].bgbiseq,g_bgbi_d[l_ac].bgbi038,
                            g_bgbi_d[l_ac].bgbi007,g_bgbi_d[l_ac].bgbi008,g_bgbi_d[l_ac].bgbi009,g_bgbi_d[l_ac].bgbi010,
                            g_bgbi_d[l_ac].bgbi011,g_bgbi_d[l_ac].bgbi012,g_bgbi_d[l_ac].bgbi013,g_bgbi_d[l_ac].bgbi014,g_bgbi_d[l_ac].bgbi015,
                            g_bgbi_d[l_ac].bgbi016,g_bgbi_d[l_ac].bgbi039,g_bgbi_d[l_ac].bgbi040,g_bgbi_d[l_ac].bgbi041,
                            g_bgbi_d[l_ac].bgbi028,g_bgbi_d[l_ac].bgbi029,g_bgbi_d[l_ac].bgbi030,g_bgbi_d[l_ac].bgbi031,g_bgbi_d[l_ac].bgbi032,
                            g_bgbi_d[l_ac].bgbi033,g_bgbi_d[l_ac].bgbi034,g_bgbi_d[l_ac].bgbi035,g_bgbi_d[l_ac].bgbi036,g_bgbi_d[l_ac].bgbi037, 
                            g_bgbi_d[l_ac].bgbi023,g_bgbi_d[l_ac].bgbi0232,g_bgbi_d[l_ac].bgbi0233,g_bgbi_d[l_ac].bgbi0234,g_bgbi_d[l_ac].bgbi0235,
                            g_bgbi_d[l_ac].bgbi0236,g_bgbi_d[l_ac].bgbi0237,g_bgbi_d[l_ac].bgbi0238,g_bgbi_d[l_ac].bgbi0239,g_bgbi_d[l_ac].bgbi02310,
                            g_bgbi_d[l_ac].bgbi02311,g_bgbi_d[l_ac].bgbi02312,g_bgbi_d[l_ac].bgbi02313,g_bgbi_d[l_ac].l_sum,
                            g_bgbi2_d[l_ac].bgbiownid,g_bgbi2_d[l_ac].bgbiowndp,g_bgbi2_d[l_ac].bgbicrtid,g_bgbi2_d[l_ac].bgbicrtdp,g_bgbi2_d[l_ac].bgbicrtdt,
                            g_bgbi2_d[l_ac].bgbimodid,g_bgbi2_d[l_ac].bgbimoddt,g_bgbi2_d[l_ac].bgbicnfid,g_bgbi2_d[l_ac].bgbicnfdt
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET g_bgbi2_d[l_ac].bgbiseq = g_bgbi_d[l_ac].bgbiseq

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
   CALL g_bgbi_d.deleteElement(g_bgbi_d.getLength())
   CALL g_bgbi2_d.deleteElement(g_bgbi2_d.getLength())
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_bgbi_d.getLength()
      LET g_bgbi_d_mask_o[l_ac].* =  g_bgbi_d[l_ac].*
      CALL abgt027_bgbi_t_mask()
      LET g_bgbi_d_mask_n[l_ac].* =  g_bgbi_d[l_ac].*
   END FOR
   
   LET g_bgbi2_d_mask_o.* =  g_bgbi2_d.*
   FOR l_ac = 1 TO g_bgbi2_d.getLength()
      LET g_bgbi2_d_mask_o[l_ac].* =  g_bgbi2_d[l_ac].*
      CALL abgt027_bgbi_t_mask()
      LET g_bgbi2_d_mask_n[l_ac].* =  g_bgbi2_d[l_ac].*
   END FOR
 
 
   FREE abgt027_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION abgt027_idx_chk()
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
      IF g_detail_idx > g_bgbi_d.getLength() THEN
         LET g_detail_idx = g_bgbi_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_bgbi_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgbi_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_bgbi2_d.getLength() THEN
         LET g_detail_idx = g_bgbi2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_bgbi2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_bgbi2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgt027_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_bgbi_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION abgt027_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   #新增/修改/刪除先寫入temptalbe
   IF g_bgbi_m.bgbi044 = "PASS" THEN
   #end add-point
   
   DELETE FROM bgbi_t
    WHERE bgbient = g_enterprise AND bgbi002 = g_bgbi_m.bgbi002 AND
                              bgbi003 = g_bgbi_m.bgbi003 AND
                              bgbi004 = g_bgbi_m.bgbi004 AND
                              bgbi005 = g_bgbi_m.bgbi005 AND
                              bgbi044 = g_bgbi_m.bgbi044 AND
                              bgbistus = g_bgbi_m.bgbistus AND
 
          bgbiseq = g_bgbi_d_t.bgbiseq
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   END IF
   
   DELETE FROM abgt027_tmp
    WHERE bgbient = g_enterprise
      AND bgbi002 = g_bgbi_m.bgbi002 AND bgbi003 = g_bgbi_m.bgbi003
      AND bgbi004 = g_bgbi_m.bgbi004 AND bgbi005 = g_bgbi_m.bgbi005
      AND bgbi044 = g_bgbi_m.bgbi044 AND bgbiseq = g_bgbi_d_t.bgbiseq
      AND bgbistus = g_bgbi_m.bgbistus
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "bgbi_t:",SQLERRMESSAGE 
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
 
{<section id="abgt027.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION abgt027_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
{<section id="abgt027.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION abgt027_insert_b(ps_table,ps_keys,ps_page)
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
 
{<section id="abgt027.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION abgt027_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
 
{<section id="abgt027.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION abgt027_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_bgbi_d[l_ac].bgbiseq = g_bgbi_d_t.bgbiseq 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION abgt027_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="abgt027.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION abgt027_lock_b(ps_table,ps_page)
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
   #CALL abgt027_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt027.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION abgt027_unlock_b(ps_table,ps_page)
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
 
{<section id="abgt027.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION abgt027_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bgbi002,bgbi003,bgbi004,bgbi005,bgbi044,bgbistus",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("bgbi045,bgbistus",TRUE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt027.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION abgt027_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("bgbi002,bgbi003,bgbi004,bgbi005,bgbi044,bgbistus",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("bgbi045",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("bgbi044,bgbistus",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="abgt027.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION abgt027_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION abgt027_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION abgt027_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("abgt027_01",TRUE)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt027.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION abgt027_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
 
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_bgbi_m.bgbistus = 'Y' THEN
      CALL cl_set_act_visible("abgt027_01",FALSE)
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt027.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION abgt027_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
 
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt027.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION abgt027_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgt027.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION abgt027_default_search()
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
      LET ls_wc = ls_wc, " bgbi002 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " bgbi003 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " bgbi004 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " bgbi005 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " bgbi044 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " bgbistus = '", g_argv[06], "' AND "
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
 
{<section id="abgt027.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION abgt027_fill_chk(ps_idx)
   #add-point:fill_chk段define name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fill_chk.pre_function"
   RETURN FALSE  #此寫FALSE為b_fill()段SQL撈取另外寫，故不走原本SQL段節省效能
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other name="fill_chk.other"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="abgt027.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION abgt027_modify_detail_chk(ps_record)
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
         LET ls_return = "bgbiseq"
      WHEN "s_detail2"
         LET ls_return = "bgbiseq_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="abgt027.mask_functions" >}
&include "erp/abg/abgt027_mask.4gl"
 
{</section>}
 
{<section id="abgt027.state_change" >}
    
 
{</section>}
 
{<section id="abgt027.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION abgt027_set_pk_array()
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
   LET g_pk_array[1].values = g_bgbi_m.bgbi002
   LET g_pk_array[1].column = 'bgbi002'
   LET g_pk_array[2].values = g_bgbi_m.bgbi003
   LET g_pk_array[2].column = 'bgbi003'
   LET g_pk_array[3].values = g_bgbi_m.bgbi004
   LET g_pk_array[3].column = 'bgbi004'
   LET g_pk_array[4].values = g_bgbi_m.bgbi005
   LET g_pk_array[4].column = 'bgbi005'
   LET g_pk_array[5].values = g_bgbi_m.bgbi044
   LET g_pk_array[5].column = 'bgbi044'
   LET g_pk_array[6].values = g_bgbi_m.bgbistus
   LET g_pk_array[6].column = 'bgbistus'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt027.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION abgt027_msgcentre_notify(lc_state)
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
   CALL abgt027_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_bgbi_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="abgt027.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立tmp table
# Memo...........:
# Usage..........: CALL abgt027_create_tmp()
# Date & Author..: 2016/06/13 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_create_tmp()

   DROP TABLE abgt027_tmp;
   
   CREATE TEMP TABLE abgt027_tmp(
         bgbient LIKE bgbi_t.bgbient,
         bgbiseq LIKE bgbi_t.bgbiseq,
         bgbi002 LIKE bgbi_t.bgbi002,
         bgbi003 LIKE bgbi_t.bgbi003,
         bgbi004 LIKE bgbi_t.bgbi004,
         bgbi005 LIKE bgbi_t.bgbi005,
         bgbi007 LIKE bgbi_t.bgbi007,
         bgbi008 LIKE bgbi_t.bgbi008,
         bgbi009 LIKE bgbi_t.bgbi009,
         bgbi010 LIKE bgbi_t.bgbi010,
         bgbi011 LIKE bgbi_t.bgbi011,
         bgbi012 LIKE bgbi_t.bgbi012,
         bgbi013 LIKE bgbi_t.bgbi013,
         bgbi014 LIKE bgbi_t.bgbi014,
         bgbi015 LIKE bgbi_t.bgbi015,
         bgbi016 LIKE bgbi_t.bgbi016,
         bgbi017 LIKE bgbi_t.bgbi017,
         bgbi028 LIKE bgbi_t.bgbi028,
         bgbi029 LIKE bgbi_t.bgbi029,
         bgbi030 LIKE bgbi_t.bgbi030,
         bgbi031 LIKE bgbi_t.bgbi031,
         bgbi032 LIKE bgbi_t.bgbi032,
         bgbi033 LIKE bgbi_t.bgbi033,
         bgbi034 LIKE bgbi_t.bgbi034,
         bgbi035 LIKE bgbi_t.bgbi035,
         bgbi036 LIKE bgbi_t.bgbi036,
         bgbi037 LIKE bgbi_t.bgbi037,
         bgbi038 LIKE bgbi_t.bgbi038,
         bgbi039 LIKE bgbi_t.bgbi039,
         bgbi040 LIKE bgbi_t.bgbi040,
         bgbi041 LIKE bgbi_t.bgbi041,
         bgbi023 LIKE bgbi_t.bgbi023,
         bgbi0232 LIKE type_t.num20_6,
         bgbi0233 LIKE type_t.num20_6,
         bgbi0234 LIKE type_t.num20_6,
         bgbi0235 LIKE type_t.num20_6,
         bgbi0236 LIKE type_t.num20_6,
         bgbi0237 LIKE type_t.num20_6,
         bgbi0238 LIKE type_t.num20_6,
         bgbi0239 LIKE type_t.num20_6,
         bgbi02310 LIKE type_t.num20_6,
         bgbi02311 LIKE type_t.num20_6,
         bgbi02312 LIKE type_t.num20_6,
         bgbi02313 LIKE type_t.num20_6,
         l_sum LIKE type_t.chr500,
         bgbi044 LIKE bgbi_t.bgbi044,
         bgbi045 LIKE bgbi_t.bgbi045,
         bgbi046 LIKE bgbi_t.bgbi046,
         bgbistus LIKE bgbi_t.bgbistus,
         bgbiownid LIKE bgbi_t.bgbiownid,
         bgbiowndp LIKE bgbi_t.bgbiowndp,
         bgbicrtid LIKE bgbi_t.bgbicrtid,
         bgbicrtdp LIKE bgbi_t.bgbicrtdp,
         bgbicrtdt LIKE bgbi_t.bgbicrtdt,
         bgbimodid LIKE bgbi_t.bgbimodid,
         bgbimoddt LIKE bgbi_t.bgbimoddt,
         bgbicnfid LIKE bgbi_t.bgbicnfid,
         bgbicnfdt LIKE bgbi_t.bgbicnfdt
         )
END FUNCTION

################################################################################
# Descriptions...: 撈取來源資料寫入tmp
# Memo...........:
# Usage..........: CALL abgt027_insert_tmp()
# Date & Author..: 2016/06/13 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_insert_tmp()
DEFINE l_sql         STRING
#DEFINE l_bgbi        RECORD LIKE bgbi_t.* #161104-00024#8 mark
#161104-00024#8 --s add
DEFINE l_bgbi RECORD  #年度預算單身檔
       bgbient LIKE bgbi_t.bgbient, #企業編號
       bgbiseq LIKE bgbi_t.bgbiseq, #項次
       bgbi001 LIKE bgbi_t.bgbi001, #摘要
       bgbi002 LIKE bgbi_t.bgbi002, #預算編號
       bgbi003 LIKE bgbi_t.bgbi003, #預算版本
       bgbi004 LIKE bgbi_t.bgbi004, #預算組織
       bgbi005 LIKE bgbi_t.bgbi005, #預算細項
       bgbi006 LIKE bgbi_t.bgbi006, #預算期別
       bgbi007 LIKE bgbi_t.bgbi007, #部門
       bgbi008 LIKE bgbi_t.bgbi008, #成本利潤中心
       bgbi009 LIKE bgbi_t.bgbi009, #區域
       bgbi010 LIKE bgbi_t.bgbi010, #交易客商
       bgbi011 LIKE bgbi_t.bgbi011, #收款客商
       bgbi012 LIKE bgbi_t.bgbi012, #客群
       bgbi013 LIKE bgbi_t.bgbi013, #產品類別
       bgbi014 LIKE bgbi_t.bgbi014, #人員
       bgbi015 LIKE bgbi_t.bgbi015, #專案編號
       bgbi016 LIKE bgbi_t.bgbi016, #WBS
       bgbi017 LIKE bgbi_t.bgbi017, #預算幣別
       bgbi018 LIKE bgbi_t.bgbi018, #含稅單價
       bgbi019 LIKE bgbi_t.bgbi019, #不含稅單價
       bgbi020 LIKE bgbi_t.bgbi020, #稅別
       bgbi021 LIKE bgbi_t.bgbi021, #交易數量
       bgbi022 LIKE bgbi_t.bgbi022, #交易金額
       bgbi023 LIKE bgbi_t.bgbi023, #基準金額
       bgbi024 LIKE bgbi_t.bgbi024, #本層調整
       bgbi025 LIKE bgbi_t.bgbi025, #上層調整
       bgbi026 LIKE bgbi_t.bgbi026, #下層調整
       bgbi027 LIKE bgbi_t.bgbi027, #核准金額
       bgbi028 LIKE bgbi_t.bgbi028, #自由核算項一
       bgbi029 LIKE bgbi_t.bgbi029, #自由核算項二
       bgbi030 LIKE bgbi_t.bgbi030, #自由核算項三
       bgbi031 LIKE bgbi_t.bgbi031, #自由核算項四
       bgbi032 LIKE bgbi_t.bgbi032, #自由核算項五
       bgbi033 LIKE bgbi_t.bgbi033, #自由核算項六
       bgbi034 LIKE bgbi_t.bgbi034, #自由核算項七
       bgbi035 LIKE bgbi_t.bgbi035, #自由核算項八
       bgbi036 LIKE bgbi_t.bgbi036, #自由核算項九
       bgbi037 LIKE bgbi_t.bgbi037, #自由核算項十
       bgbi038 LIKE bgbi_t.bgbi038, #現金變動碼
       bgbi039 LIKE bgbi_t.bgbi039, #經營方式
       bgbi040 LIKE bgbi_t.bgbi040, #通路
       bgbi041 LIKE bgbi_t.bgbi041, #品牌
       bgbi042 LIKE bgbi_t.bgbi042, #稅率
       bgbi043 LIKE bgbi_t.bgbi043, #匯率
       bgbiud001 LIKE bgbi_t.bgbiud001, #自定義欄位(文字)001
       bgbiud002 LIKE bgbi_t.bgbiud002, #自定義欄位(文字)002
       bgbiud003 LIKE bgbi_t.bgbiud003, #自定義欄位(文字)003
       bgbiud004 LIKE bgbi_t.bgbiud004, #自定義欄位(文字)004
       bgbiud005 LIKE bgbi_t.bgbiud005, #自定義欄位(文字)005
       bgbiud006 LIKE bgbi_t.bgbiud006, #自定義欄位(文字)006
       bgbiud007 LIKE bgbi_t.bgbiud007, #自定義欄位(文字)007
       bgbiud008 LIKE bgbi_t.bgbiud008, #自定義欄位(文字)008
       bgbiud009 LIKE bgbi_t.bgbiud009, #自定義欄位(文字)009
       bgbiud010 LIKE bgbi_t.bgbiud010, #自定義欄位(文字)010
       bgbiud011 LIKE bgbi_t.bgbiud011, #自定義欄位(數字)011
       bgbiud012 LIKE bgbi_t.bgbiud012, #自定義欄位(數字)012
       bgbiud013 LIKE bgbi_t.bgbiud013, #自定義欄位(數字)013
       bgbiud014 LIKE bgbi_t.bgbiud014, #自定義欄位(數字)014
       bgbiud015 LIKE bgbi_t.bgbiud015, #自定義欄位(數字)015
       bgbiud016 LIKE bgbi_t.bgbiud016, #自定義欄位(數字)016
       bgbiud017 LIKE bgbi_t.bgbiud017, #自定義欄位(數字)017
       bgbiud018 LIKE bgbi_t.bgbiud018, #自定義欄位(數字)018
       bgbiud019 LIKE bgbi_t.bgbiud019, #自定義欄位(數字)019
       bgbiud020 LIKE bgbi_t.bgbiud020, #自定義欄位(數字)020
       bgbiud021 LIKE bgbi_t.bgbiud021, #自定義欄位(日期時間)021
       bgbiud022 LIKE bgbi_t.bgbiud022, #自定義欄位(日期時間)022
       bgbiud023 LIKE bgbi_t.bgbiud023, #自定義欄位(日期時間)023
       bgbiud024 LIKE bgbi_t.bgbiud024, #自定義欄位(日期時間)024
       bgbiud025 LIKE bgbi_t.bgbiud025, #自定義欄位(日期時間)025
       bgbiud026 LIKE bgbi_t.bgbiud026, #自定義欄位(日期時間)026
       bgbiud027 LIKE bgbi_t.bgbiud027, #自定義欄位(日期時間)027
       bgbiud028 LIKE bgbi_t.bgbiud028, #自定義欄位(日期時間)028
       bgbiud029 LIKE bgbi_t.bgbiud029, #自定義欄位(日期時間)029
       bgbiud030 LIKE bgbi_t.bgbiud030, #自定義欄位(日期時間)030
       bgbi044 LIKE bgbi_t.bgbi044, #資料來源
       bgbi045 LIKE bgbi_t.bgbi045, #管理組織
       bgbi046 LIKE bgbi_t.bgbi046, #預算樣表
       bgbiownid LIKE bgbi_t.bgbiownid, #資料所有者
       bgbiowndp LIKE bgbi_t.bgbiowndp, #資料所屬部門
       bgbicrtid LIKE bgbi_t.bgbicrtid, #資料建立者
       bgbicrtdp LIKE bgbi_t.bgbicrtdp, #資料建立部門
       bgbicrtdt LIKE bgbi_t.bgbicrtdt, #資料創建日
       bgbimodid LIKE bgbi_t.bgbimodid, #資料修改者
       bgbimoddt LIKE bgbi_t.bgbimoddt, #最近修改日
       bgbicnfid LIKE bgbi_t.bgbicnfid, #資料確認者
       bgbicnfdt LIKE bgbi_t.bgbicnfdt, #資料確認日
       bgbistus LIKE bgbi_t.bgbistus, #狀態碼
       bgbi047 LIKE bgbi_t.bgbi047  #上層組織
END RECORD
#161104-00024#8 --e add
DEFINE l_bgbi023     RECORD
                        sum01   LIKE bgbi_t.bgbi023,
                        sum02   LIKE bgbi_t.bgbi023,
                        sum03   LIKE bgbi_t.bgbi023,
                        sum04   LIKE bgbi_t.bgbi023,
                        sum05   LIKE bgbi_t.bgbi023,
                        sum06   LIKE bgbi_t.bgbi023,
                        sum07   LIKE bgbi_t.bgbi023,
                        sum08   LIKE bgbi_t.bgbi023,
                        sum09   LIKE bgbi_t.bgbi023,
                        sum10   LIKE bgbi_t.bgbi023,
                        sum11   LIKE bgbi_t.bgbi023,
                        sum12   LIKE bgbi_t.bgbi023,
                        sum13   LIKE bgbi_t.bgbi023,
                        sumall   LIKE bgbi_t.bgbi023
                     END RECORD
DEFINE l_wc          STRING
   
   DELETE FROM abgt027_tmp
   
   
   LET l_sql = "SELECT DISTINCT bgbi038,",                                  #現金變動碼
               "                bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,",  #固定核算項
               "                bgbi012,bgbi013,bgbi014,bgbi015,bgbi016,",  #固定核算項
               "                bgbi039,bgbi040,bgbi041,",                  #固定核算項
               "                bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,",  #自由核算項1~5
               "                bgbi033,bgbi034,bgbi035,bgbi036,bgbi037,",  #自由核算項6~10
               "                bgbistus,bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,",
               "                bgbicrtdt,bgbimodid,bgbimoddt,bgbicnfid,bgbicnfdt",
               "  FROM bgbi_t",
               " WHERE bgbient = ",g_enterprise,
               "   AND bgbi002 = '",g_bgbi_m.bgbi002,"'",
               "   AND bgbi003 = '",g_bgbi_m.bgbi003,"'",
               "   AND bgbi004 = '",g_bgbi_m.bgbi004,"'",
               "   AND bgbi005 = '",g_bgbi_m.bgbi005,"'",
               "   AND bgbi044 = '1' ",
               "   AND bgbistus = '",g_bgbi_m.bgbistus,"'",
               " ORDER BY bgbi007,bgbi008,bgbi009,bgbi010,bgbi011, ",
               "          bgbi012,bgbi013,bgbi014,bgbi015,bgbi016,",
               "          bgbi039,bgbi040,bgbi041,",                
               "          bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,",
               "          bgbi033,bgbi034,bgbi035,bgbi036,bgbi037"
   PREPARE abgt027_sel_pre2 FROM l_sql
   DECLARE abgt027_sel_cur2 CURSOR FOR abgt027_sel_pre2
   FOREACH abgt027_sel_cur2 INTO l_bgbi.bgbi038,
                                 l_bgbi.bgbi007,l_bgbi.bgbi008,l_bgbi.bgbi009,l_bgbi.bgbi010,l_bgbi.bgbi011,
                                 l_bgbi.bgbi012,l_bgbi.bgbi013,l_bgbi.bgbi014,l_bgbi.bgbi015,l_bgbi.bgbi016,
                                 l_bgbi.bgbi039,l_bgbi.bgbi040,l_bgbi.bgbi041,
                                 l_bgbi.bgbi028,l_bgbi.bgbi029,l_bgbi.bgbi030,l_bgbi.bgbi031,l_bgbi.bgbi032,
                                 l_bgbi.bgbi033,l_bgbi.bgbi034,l_bgbi.bgbi035,l_bgbi.bgbi036,l_bgbi.bgbi037,
                                 l_bgbi.bgbistus,l_bgbi.bgbiownid,l_bgbi.bgbiowndp,l_bgbi.bgbicrtid,l_bgbi.bgbicrtdp,
                                 l_bgbi.bgbicrtdt,l_bgbi.bgbimodid,l_bgbi.bgbimoddt,l_bgbi.bgbicnfid,l_bgbi.bgbicnfdt
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_wc = " 1=1 "
      IF NOT cl_null(l_bgbi.bgbi038) THEN LET l_wc = l_wc, " AND bgbi038 = '",l_bgbi.bgbi038,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi007) THEN LET l_wc = l_wc, " AND bgbi007 = '",l_bgbi.bgbi007,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi008) THEN LET l_wc = l_wc, " AND bgbi008 = '",l_bgbi.bgbi008,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi009) THEN LET l_wc = l_wc, " AND bgbi009 = '",l_bgbi.bgbi009,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi010) THEN LET l_wc = l_wc, " AND bgbi010 = '",l_bgbi.bgbi010,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi011) THEN LET l_wc = l_wc, " AND bgbi011 = '",l_bgbi.bgbi011,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi012) THEN LET l_wc = l_wc, " AND bgbi012 = '",l_bgbi.bgbi012,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi013) THEN LET l_wc = l_wc, " AND bgbi013 = '",l_bgbi.bgbi013,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi014) THEN LET l_wc = l_wc, " AND bgbi014 = '",l_bgbi.bgbi014,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi015) THEN LET l_wc = l_wc, " AND bgbi015 = '",l_bgbi.bgbi015,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi016) THEN LET l_wc = l_wc, " AND bgbi016 = '",l_bgbi.bgbi016,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi039) THEN LET l_wc = l_wc, " AND bgbi039 = '",l_bgbi.bgbi039,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi040) THEN LET l_wc = l_wc, " AND bgbi040 = '",l_bgbi.bgbi040,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi041) THEN LET l_wc = l_wc, " AND bgbi041 = '",l_bgbi.bgbi041,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi028) THEN LET l_wc = l_wc, " AND bgbi028 = '",l_bgbi.bgbi028,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi029) THEN LET l_wc = l_wc, " AND bgbi029 = '",l_bgbi.bgbi029,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi030) THEN LET l_wc = l_wc, " AND bgbi030 = '",l_bgbi.bgbi030,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi031) THEN LET l_wc = l_wc, " AND bgbi031 = '",l_bgbi.bgbi031,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi032) THEN LET l_wc = l_wc, " AND bgbi032 = '",l_bgbi.bgbi032,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi033) THEN LET l_wc = l_wc, " AND bgbi033 = '",l_bgbi.bgbi033,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi034) THEN LET l_wc = l_wc, " AND bgbi034 = '",l_bgbi.bgbi034,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi035) THEN LET l_wc = l_wc, " AND bgbi035 = '",l_bgbi.bgbi035,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi036) THEN LET l_wc = l_wc, " AND bgbi036 = '",l_bgbi.bgbi036,"'" END IF
      IF NOT cl_null(l_bgbi.bgbi037) THEN LET l_wc = l_wc, " AND bgbi037 = '",l_bgbi.bgbi037,"'" END IF
      
      LET l_bgbi023.sum01 = 0
      LET l_bgbi023.sum02 = 0
      LET l_bgbi023.sum03 = 0
      LET l_bgbi023.sum04 = 0
      LET l_bgbi023.sum05 = 0
      LET l_bgbi023.sum06 = 0
      LET l_bgbi023.sum07 = 0
      LET l_bgbi023.sum08 = 0
      LET l_bgbi023.sum09 = 0
      LET l_bgbi023.sum10 = 0
      LET l_bgbi023.sum11 = 0
      LET l_bgbi023.sum12 = 0
      LET l_bgbi023.sum13 = 0
      LET l_bgbi023.sumall = 0
      
      #撈出符合的期別/金額
      LET l_sql = "SELECT bgbi006,bgbi023",
                  "  FROM bgbi_t",
                  " WHERE bgbient = ",g_enterprise,
                  "   AND bgbi002 = '",g_bgbi_m.bgbi002,"'",
                  "   AND bgbi003 = '",g_bgbi_m.bgbi003,"'",
                  "   AND bgbi004 = '",g_bgbi_m.bgbi004,"'",
                  "   AND bgbi005 = '",g_bgbi_m.bgbi005,"'",
                  "   AND bgbi044 = '1' ",
                  "   AND bgbistus = '",g_bgbi_m.bgbistus,"'",
                  "   AND ",l_wc,
                  " ORDER BY bgbi006"
      PREPARE abgt027_sel_pre3 FROM l_sql
      DECLARE abgt027_sel_cur3 CURSOR FOR abgt027_sel_pre3
      FOREACH abgt027_sel_cur3 INTO l_bgbi.bgbi006,l_bgbi.bgbi023
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         IF cl_null(l_bgbi.bgbi023)THEN LET l_bgbi.bgbi023 = 0 END IF
         CASE l_bgbi.bgbi006
            WHEN 1
               LET l_bgbi023.sum01 = l_bgbi.bgbi023
            WHEN 2
               LET l_bgbi023.sum02 = l_bgbi.bgbi023
            WHEN 3
               LET l_bgbi023.sum03 = l_bgbi.bgbi023
            WHEN 4
               LET l_bgbi023.sum04 = l_bgbi.bgbi023
            WHEN 5
               LET l_bgbi023.sum05 = l_bgbi.bgbi023
            WHEN 6
               LET l_bgbi023.sum06 = l_bgbi.bgbi023
            WHEN 7
               LET l_bgbi023.sum07 = l_bgbi.bgbi023
            WHEN 8
               LET l_bgbi023.sum08 = l_bgbi.bgbi023
            WHEN 9
               LET l_bgbi023.sum09 = l_bgbi.bgbi023
            WHEN 10
               LET l_bgbi023.sum10 = l_bgbi.bgbi023
            WHEN 11
               LET l_bgbi023.sum11 = l_bgbi.bgbi023
            WHEN 12
               LET l_bgbi023.sum12 = l_bgbi.bgbi023
            WHEN 13
               LET l_bgbi023.sum13 = l_bgbi.bgbi023
         END CASE
         
         LET l_bgbi023.sumall = l_bgbi023.sumall+l_bgbi.bgbi023
      
      END FOREACH
      
      SELECT MAX(bgbiseq)+1 INTO l_bgbi.bgbiseq
         FROM abgt027_tmp
        WHERE bgbi002 = g_bgbi_m.bgbi002
          AND bgbi003 = g_bgbi_m.bgbi003
          AND bgbi004 = g_bgbi_m.bgbi004
          AND bgbi005 = g_bgbi_m.bgbi005
          AND bgbi044 = '1'
          AND bgbistus = g_bgbi_m.bgbistus
      IF cl_null(l_bgbi.bgbiseq)THEN LET l_bgbi.bgbiseq = 1 END IF
      
      INSERT INTO abgt027_tmp (bgbient,bgbiseq,bgbi002,bgbi003,bgbi004,bgbi005,
                               bgbi038,
                               bgbi007,bgbi008,bgbi009,bgbi010,
                               bgbi011,bgbi012,bgbi013,bgbi014,bgbi015,
                               bgbi016,bgbi039,bgbi040,bgbi041,
                               bgbi028,bgbi029,bgbi030,bgbi031,bgbi032,
                               bgbi033,bgbi034,bgbi035,bgbi036,bgbi037,
                               bgbi023,bgbi0232,bgbi0233,bgbi0234,bgbi0235,
                               bgbi0236,bgbi0237,bgbi0238,bgbi0239,bgbi02310,
                               bgbi02311,bgbi02312,bgbi02313,l_sum,bgbi044,
                               bgbistus,bgbiownid,bgbiowndp,bgbicrtid,bgbicrtdp,
                               bgbicrtdt,bgbimodid,bgbimoddt,bgbicnfid,bgbicnfdt
                              )
                       VALUES (g_enterprise,l_bgbi.bgbiseq,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,
                               l_bgbi.bgbi038,
                               l_bgbi.bgbi007,l_bgbi.bgbi008,l_bgbi.bgbi009,l_bgbi.bgbi010,
                               l_bgbi.bgbi011,l_bgbi.bgbi012,l_bgbi.bgbi013,l_bgbi.bgbi014,l_bgbi.bgbi015,
                               l_bgbi.bgbi016,l_bgbi.bgbi039,l_bgbi.bgbi040,l_bgbi.bgbi041,
                               l_bgbi.bgbi028,l_bgbi.bgbi029,l_bgbi.bgbi030,l_bgbi.bgbi031,l_bgbi.bgbi032,
                               l_bgbi.bgbi033,l_bgbi.bgbi034,l_bgbi.bgbi035,l_bgbi.bgbi036,l_bgbi.bgbi037,
                               l_bgbi023.sum01,l_bgbi023.sum02,l_bgbi023.sum03,l_bgbi023.sum04,l_bgbi023.sum05,
                               l_bgbi023.sum06,l_bgbi023.sum07,l_bgbi023.sum08,l_bgbi023.sum09,l_bgbi023.sum10,
                               l_bgbi023.sum11,l_bgbi023.sum12,l_bgbi023.sum13,l_bgbi023.sumall,'1',
                               l_bgbi.bgbistus,l_bgbi.bgbiownid,l_bgbi.bgbiowndp,l_bgbi.bgbicrtid,l_bgbi.bgbicrtdp,
                               l_bgbi.bgbicrtdt,l_bgbi.bgbimodid,l_bgbi.bgbimoddt,l_bgbi.bgbicnfid,l_bgbi.bgbicnfdt
                              )
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 取得預算組織的主帳套
# Memo...........:
# Usage..........: CALL abgt027_ld_info()
# Date & Author..: 2016/06/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_ld_info(p_site)
DEFINE p_site        LIKE ooef_t.ooef001
DEFINE r_ld          LIKE glaa_t.glaald
   
   LET r_ld = ""
   
   SELECT glaald INTO r_ld
     FROM glaa_t,ooef_t
    WHERE glaaent = g_enterprise
      AND glaacomp = ooef017 AND glaaent = ooefent
      AND ooef001 = p_site
      AND glaa014 = 'Y'
   
   RETURN r_ld
END FUNCTION

################################################################################
# Descriptions...: 依樣表設置核算項隱顯
# Memo...........:
# Usage..........: CALL abgt027_set_entry_bgbi046()
# Date & Author..: 2016/06/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_set_entry_bgbi046(p_bgbi002,p_bgbi045,p_bgbi046)
DEFINE p_bgbi002     LIKE bgbi_t.bgbi002
DEFINE p_bgbi045     LIKE bgbi_t.bgbi045
DEFINE p_bgbi046     LIKE bgbi_t.bgbi046
DEFINE l_sql         STRING
DEFINE l_bgaw        RECORD
                        bgaw004   LIKE bgaw_t.bgaw004,
                        bgaw005   LIKE bgaw_t.bgaw005
                     END RECORD
DEFINE l_open        STRING
DEFINE l_close       STRING

   #若無樣板則去abgi090取
   IF cl_null(p_bgbi046) THEN
      SELECT bgai008 INTO p_bgbi046
        FROM bgai_t
       WHERE bgaient = g_enterprise
         AND bgai001 = p_bgbi002
         AND bgai002 = p_bgbi045
   END IF
   
   LET l_open = ""
   LET l_close = ""
   #預算維度/使用否
   LET l_sql = " SELECT bgaw004,bgaw005",
               "   FROM bgaw_t ",
               "  WHERE bgawent = ",g_enterprise," ",
               "    AND bgaw001 = '",p_bgbi046,"' "
   PREPARE abgt027_sel_bgaw_p1 FROM l_sql
   DECLARE abgt027_sel_bgaw_c1 CURSOR FOR abgt027_sel_bgaw_p1
   FOREACH abgt027_sel_bgaw_c1 INTO l_bgaw.*
      IF l_bgaw.bgaw005 = "Y" THEN
         CASE l_bgaw.bgaw004
            WHEN "2"    #部門
               LET l_open = l_open,"bgbi007_desc,"
            WHEN "3"    #利潤成本中心
               LET l_open = l_open,"bgbi008_desc,"
            WHEN "4"    #區域
               LET l_open = l_open,"bgbi009_desc,"
            WHEN "5"    #交易客商
               LET l_open = l_open,"bgbi010_desc,"
            WHEN "6"    #收款客商
               LET l_open = l_open,"bgbi011_desc,"
            WHEN "7"    #客群
               LET l_open = l_open,"bgbi012_desc,"
            WHEN "8"    #產品類別
               LET l_open = l_open,"bgbi013_desc,"
            WHEN "9"    #經營方式
               LET l_open = l_open,"bgbi039_desc,"
            WHEN "10"   #渠道
               LET l_open = l_open,"bgbi040_desc,"
            WHEN "11"   #品牌
               LET l_open = l_open,"bgbi041_desc,"
            WHEN "12"   #人員
               LET l_open = l_open,"bgbi014_desc,"
            WHEN "13"   #專案編號
               LET l_open = l_open,"bgbi015_desc,"
            WHEN "14"   #WBS
               LET l_open = l_open,"bgbi016_desc,"
            WHEN "15"   #自由核算項一
               LET l_open = l_open,"bgbi028_desc,"
            WHEN "16"   #自由核算項二
               LET l_open = l_open,"bgbi029_desc,"
            WHEN "17"   #自由核算項三
               LET l_open = l_open,"bgbi030_desc,"
            WHEN "18"   #自由核算項四
               LET l_open = l_open,"bgbi031_desc,"
            WHEN "19"   #自由核算項五
               LET l_open = l_open,"bgbi032_desc,"
            WHEN "20"   #自由核算項六
               LET l_open = l_open,"bgbi033_desc,"
            WHEN "21"   #自由核算項七
               LET l_open = l_open,"bgbi034_desc,"
            WHEN "22"   #自由核算項八
               LET l_open = l_open,"bgbi035_desc,"
            WHEN "23"   #自由核算項九
               LET l_open = l_open,"bgbi036_desc,"
            WHEN "24"   #自由核算項十
               LET l_open = l_open,"bgbi037_desc,"
         END CASE
      ELSE
         CASE l_bgaw.bgaw004
            WHEN "2"    #部門
               LET l_close = l_close,"bgbi007_desc,"
            WHEN "3"    #利潤成本中心
               LET l_close = l_close,"bgbi008_desc,"
            WHEN "4"    #區域
               LET l_close = l_close,"bgbi009_desc,"
            WHEN "5"    #交易客商
               LET l_close = l_close,"bgbi010_desc,"
            WHEN "6"    #收款客商
               LET l_close = l_close,"bgbi011_desc,"
            WHEN "7"    #客群
               LET l_close = l_close,"bgbi012_desc,"
            WHEN "8"    #產品類別
               LET l_close = l_close,"bgbi013_desc,"
            WHEN "9"    #經營方式
               LET l_close = l_close,"bgbi039_desc,"
            WHEN "10"   #渠道
               LET l_close = l_close,"bgbi040_desc,"
            WHEN "11"   #品牌
               LET l_close = l_close,"bgbi041_desc,"
            WHEN "12"   #人員
               LET l_close = l_close,"bgbi014_desc,"
            WHEN "13"   #專案編號
               LET l_close = l_close,"bgbi015_desc,"
            WHEN "14"   #WBS
               LET l_close = l_close,"bgbi016_desc,"
            WHEN "15"   #自由核算項一
               LET l_close = l_close,"bgbi028_desc,"
            WHEN "16"   #自由核算項二
               LET l_close = l_close,"bgbi029_desc,"
            WHEN "17"   #自由核算項三
               LET l_close = l_close,"bgbi030_desc,"
            WHEN "18"   #自由核算項四
               LET l_close = l_close,"bgbi031_desc,"
            WHEN "19"   #自由核算項五
               LET l_close = l_close,"bgbi032_desc,"
            WHEN "20"   #自由核算項六
               LET l_close = l_close,"bgbi033_desc,"
            WHEN "21"   #自由核算項七
               LET l_close = l_close,"bgbi034_desc,"
            WHEN "22"   #自由核算項八
               LET l_close = l_close,"bgbi035_desc,"
            WHEN "23"   #自由核算項九
               LET l_close = l_close,"bgbi036_desc,"
            WHEN "24"   #自由核算項十
               LET l_close = l_close,"bgbi037_desc,"
         END CASE
      END IF
      
   END FOREACH
   
   LET l_open = l_open.subString(1,l_open.getLength()-1)
   LET l_close = l_close.subString(1,l_close.getLength()-1)
   
   CALL cl_set_comp_visible(l_open,TRUE)
   CALL cl_set_comp_visible(l_close,FALSE)
   
END FUNCTION

################################################################################
# Descriptions...: 抓取期別是12期還13期&欄位隱顯
# Memo...........:
# Usage..........: CALL abgt027_set_entry_period()
# Date & Author..: 2016/06/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_set_entry_period(p_bgaa002)
DEFINE p_bgaa002     LIKE bgaa_t.bgaa002
DEFINE  l_n          LIKE type_t.num10
   
   LET l_n = 0
   SELECT COUNT(DISTINCT bgac004) INTO l_n
     FROM bgac_t
    WHERE bgacent = g_enterprise
      AND bgac001 = p_bgaa002
   IF cl_null(l_n) THEN LET l_n = 0 END IF
   CALL cl_set_comp_visible("bgbi02313",TRUE)
   IF l_n = 12 THEN
      CALL cl_set_comp_visible("bgbi02313",FALSE)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 重新計算每一行的合計
# Memo...........:
# Usage..........: CALL abgt027_row_sum()
# Date & Author..: 2016/06/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_row_sum()

   IF cl_null(g_bgbi_d[l_ac].bgbi023)   THEN LET g_bgbi_d[l_ac].bgbi023   = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi0232)  THEN LET g_bgbi_d[l_ac].bgbi0232  = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi0233)  THEN LET g_bgbi_d[l_ac].bgbi0233  = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi0234)  THEN LET g_bgbi_d[l_ac].bgbi0234  = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi0235)  THEN LET g_bgbi_d[l_ac].bgbi0235  = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi0236)  THEN LET g_bgbi_d[l_ac].bgbi0236  = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi0237)  THEN LET g_bgbi_d[l_ac].bgbi0237  = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi0238)  THEN LET g_bgbi_d[l_ac].bgbi0238  = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi0239)  THEN LET g_bgbi_d[l_ac].bgbi0239  = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi02310) THEN LET g_bgbi_d[l_ac].bgbi02310 = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi02311) THEN LET g_bgbi_d[l_ac].bgbi02311 = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi02312) THEN LET g_bgbi_d[l_ac].bgbi02312 = 0 END IF
   IF cl_null(g_bgbi_d[l_ac].bgbi02313) THEN LET g_bgbi_d[l_ac].bgbi02313 = 0 END IF
   
   LET g_bgbi_d[l_ac].l_sum = g_bgbi_d[l_ac].bgbi023+g_bgbi_d[l_ac].bgbi0232+g_bgbi_d[l_ac].bgbi0233+
                              g_bgbi_d[l_ac].bgbi0234+g_bgbi_d[l_ac].bgbi0235+g_bgbi_d[l_ac].bgbi0236+
                              g_bgbi_d[l_ac].bgbi0237+g_bgbi_d[l_ac].bgbi0238+g_bgbi_d[l_ac].bgbi0239+
                              g_bgbi_d[l_ac].bgbi02310+g_bgbi_d[l_ac].bgbi02311+g_bgbi_d[l_ac].bgbi02312+
                              g_bgbi_d[l_ac].bgbi02313
   
   DISPLAY BY NAME g_bgbi_d[l_ac].l_sum
END FUNCTION

################################################################################
# Descriptions...: 取得agli021設定的現金變動碼
# Memo...........:
# Usage..........: CALL abgt027_get_bgbi038()
# Date & Author..: 2016/06/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_get_bgbi038(p_bgaa008,p_bgbi005)
DEFINE p_bgaa008     LIKE bgaa_t.bgaa008
DEFINE p_bgbi005     LIKE bgbi_t.bgbi005
DEFINE r_bgbi038     LIKE bgbi_t.bgbi038  #現金變動碼
DEFINE l_glaa004     LIKE glaa_t.glaa004  #會計科目參照表號
DEFINE l_bgae002     LIKE bgae_t.bgae002
DEFINE l_bgao003     LIKE glac_t.glac002
DEFINE l_sql         STRING
   
   LET r_bgbi038 = NULL
   
   #先至abgi010取得預算項目參照表
   #先取得預算組織的法人主帳套的會計科目參照表號
   #在至abgi140找出預算項目參照表+會計科目參照表號+預算項目的ALL會科
   #在至agli021找出預設的現金變動碼(取借or貸可以至abgi040看設定)
   
   #會計科目參照表號
   SELECT glaa004 INTO l_glaa004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glaald
   
   #取得預算項目的借貸方
   SELECT bgae002 INTO l_bgae002
     FROM bgae_t
    WHERE bgaeent = g_enterprise
      AND bgae006 = p_bgaa008
      AND bgae001 = p_bgbi005
   
   #取得abgi140的會科
   LET l_sql = "SELECT bgao003 FROM bgao_t ",
               " WHERE bgaoent = ",g_enterprise,
               "   AND bgao001 = '",p_bgaa008,"' ",
               "   AND bgao002 = '",l_glaa004,"' ",
               "   AND bgao004 = '",p_bgbi005,"' "
   PREPARE sel_bgao_p2 FROM l_sql
   DECLARE sel_bgao_c2 CURSOR FOR sel_bgao_p2
   
   #取借方現金變動碼
   LET l_sql = "SELECT glac032 FROM glac_t ",
               " WHERE glacent = ",g_enterprise,
               "   AND glac001 = '",l_glaa004,"' ",
               "   AND glac002 = ? "
   PREPARE sel_glac_pb1 FROM l_sql
   
   #取貸方現金變動碼
   LET l_sql = "SELECT glac036 FROM glac_t ",
               " WHERE glacent = ",g_enterprise,
               "   AND glac001 = '",l_glaa004,"' ",
               "   AND glac002 = ? "
   PREPARE sel_glac_pb2 FROM l_sql
   
   FOREACH sel_bgao_c2 INTO l_bgao003
      IF l_bgae002 = '1' THEN #借方
         EXECUTE sel_glac_pb1 USING l_bgao003 INTO r_bgbi038
      ELSE
         EXECUTE sel_glac_pb2 USING l_bgao003 INTO r_bgbi038
      END IF
      IF NOT cl_null(r_bgbi038) THEN EXIT FOREACH END IF
   END FOREACH
   
   RETURN r_bgbi038
END FUNCTION

################################################################################
# Descriptions...: 不走科目預算時，預算項目轉換成科目
# Memo...........: #取第一個符合在abgi140中的第一個會計科目
# Usage..........: CALL abgt027_get_bgao003()
# Date & Author..: 2016/06/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_get_bgao003(p_bgaa008,p_bgbi005)
DEFINE p_bgaa008     LIKE bgaa_t.bgaa008
DEFINE p_bgbi005     LIKE bgbi_t.bgbi005
DEFINE r_bgao003     LIKE glac_t.glac002
DEFINE l_glaa004     LIKE glaa_t.glaa004  #會計科目參照表號
DEFINE l_sql         STRING
   
   LET r_bgao003 = NULL
   
   #會計科目參照表號
   SELECT glaa004 INTO l_glaa004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glaald
   
   LET l_sql = "SELECT bgao003 FROM bgao_t ",
               " WHERE bgaoent = ",g_enterprise,
               "   AND bgao001 = '",p_bgaa008,"' ",
               "   AND bgao002 = '",l_glaa004,"' ",
               "   AND bgao004 = '",p_bgbi005,"' "
   PREPARE sel_bgao_p1 FROM l_sql
   DECLARE sel_bgao_c1 SCROLL CURSOR FOR sel_bgao_p1
   OPEN sel_bgao_c1
   FETCH FIRST sel_bgao_c1 INTO r_bgao003
   
   RETURN r_bgao003
END FUNCTION

################################################################################
# Descriptions...: 預算編號,預算項目,預算組織檢核
# Memo...........:
# Usage..........: abgt027_bgbi002_bgbi005_bgbi004_chk()
# Date & Author..: 2016/06/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_bgbi002_bgbi005_bgbi004_chk(p_bgbi002,p_bgbi005,p_bgbi004)
DEFINE p_bgbi002     LIKE bgbi_t.bgbi002  #預算編號
DEFINE p_bgbi005     LIKE bgbi_t.bgbi005  #預算項目編碼
DEFINE p_bgbi004     LIKE bgbi_t.bgbi004  #預算組織
DEFINE r_errno       LIKE gzze_t.gzze001
DEFINE r_success     LIKE type_t.num5

   LET r_errno = NULL
   LET r_success = TRUE
   IF NOT cl_null(p_bgbi002)THEN
      #單獨檢查預算編號
      CALL s_abg_bgaa001_chk(p_bgbi002)RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_errno = g_errno
         RETURN r_success,r_errno
      END IF
   END IF
   
   IF NOT cl_null(p_bgbi005) AND NOT cl_null(p_bgbi002)THEN
      IF g_bgaa.bgaa012 = 'Y' THEN
         IF NOT cl_null(p_bgbi004)THEN
            #科目檢合
            CALL s_aap_glac002_chk(p_bgbi005,g_glaald) RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               LET r_success = FALSE
               LET r_errno  = g_errno
               RETURN r_success,r_errno
            END IF
         END IF
      ELSE
         #預算項目必須存在預算編號中的預算項目參照表中
         CALL s_abg_bgae001_chk(p_bgbi002,'',p_bgbi005,'1') RETURNING g_sub_success,g_errno
         IF NOT g_sub_success THEN
            LET r_success = FALSE
            LET r_errno  = g_errno
            RETURN r_success,r_errno
         END IF
      END IF
      #要有可預設樣表
      CALL s_abg_bgay_exist_chk(p_bgbi002,p_bgbi005) RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_errno  = g_errno
         RETURN r_success,r_errno
      END IF
   END IF
   
   #檢查組織跟預算編號
   IF NOT cl_null(p_bgbi002) AND NOT cl_null(p_bgbi004)THEN
      CALL s_abg_cre_bg_licence_chk(p_bgbi002,p_bgbi004,g_user) RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_errno  = g_errno
         RETURN r_success,r_errno
      END IF
   END IF
   
   #檢查abgi100存在並有效
   IF NOT cl_null(p_bgbi004) AND NOT cl_null(p_bgbi002) AND NOT cl_null(p_bgbi005)THEN
      CALL s_abg_bgai_chk(p_bgbi002,p_bgbi004,p_bgbi005) RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_errno = g_errno
         RETURN r_success,r_errno
      END IF
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 可否新增
# Memo...........:
# Usage..........: CALL abgt027_insert_chk()
# Date & Author..: 2016/06/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_insert_chk(p_bgbi002,p_bgbi003,p_bgbi004,p_bgbi005)
DEFINE p_bgbi002     LIKE bgbi_t.bgbi002
DEFINE p_bgbi003     LIKE bgbi_t.bgbi003
DEFINE p_bgbi004     LIKE bgbi_t.bgbi004
DEFINE p_bgbi005     LIKE bgbi_t.bgbi005
DEFINE l_count       LIKE type_t.num20_6
DEFINE l_site        LIKE ooef_t.ooef001
DEFINE r_success     LIKE type_t.num5
DEFINE r_errno       LIKE gzze_t.gzze001
   
   LET r_success = TRUE
   LET r_errno   = ''

   #檢核自己是否已經建立abgt025
   LET l_count = 0
   SELECT COUNT(*) INTO l_count
     FROM bgbi_t
    WHERE bgbient = g_enterprise
      AND bgbi002 = p_bgbi002
      AND bgbi003 = p_bgbi003
      AND bgbi004 = p_bgbi004
      AND bgbi005 = p_bgbi005
      AND bgbi044 = '2'
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count > 0 THEN
      LET r_errno = 'abg-00109'
      LET r_success = FALSE
      RETURN r_success,r_errno
   END IF

   #檢核上層組織是否已經建立abgt025
   #CALL s_abgt020_get_upstep_site(p_bgbi002,'','',p_bgbi004)RETURNING l_site
   #LET l_count = 0
   #SELECT COUNT(*) INTO l_count
   #  FROM bgbi_t
   # WHERE bgbient = g_enterprise
   #   AND bgbi002 = p_bgbi002
   #   AND bgbi003 = p_bgbi003
   #   AND bgbi004 = l_site
   #   AND bgbi005 = p_bgbi005
   #   AND bgbi044 = '2'
   #IF cl_null(l_count)THEN LET l_count = 0 END IF
   #IF l_count > 0 THEN
   #   LET r_errno = 'abg-00110'
   #   LET r_success = FALSE
   #   RETURN r_success,r_errno
   #END IF
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 狀態設定
# Memo...........:
# Usage..........: CALL abgt027_statechange()
# Date & Author..: 2016/06/14 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"

   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_bgbimoddt  LIKE bgbi_t.bgbimoddt
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"

   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_bgbi_m.bgbi002 IS NULL OR g_bgbi_m.bgbi003 IS NULL OR
      g_bgbi_m.bgbi004 IS NULL OR g_bgbi_m.bgbi005 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN abgt027_cl USING g_enterprise,g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN abgt027_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE abgt027_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE abgt027_master_referesh USING g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005, 
       g_bgbi_m.bgbi044,g_bgbi_m.bgbistus INTO g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004, 
       g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
 
   #檢查是否允許此動作
   #IF NOT abgt021_action_chk() THEN
   #   CLOSE abgt021_cl
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_bgbi_m.bgbi002,g_bgbi_m.bgbi002_desc,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi045_desc, 
       g_bgbi_m.bgbi004,g_bgbi_m.bgbi004_desc,g_bgbi_m.bgbi005,g_bgbi_m.bgbi005_desc,g_bgbi_m.l_bgaa002, 
       g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
 
   CASE g_bgbi_m.bgbistus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      WHEN "FC"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"

   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_bgbi_m.bgbistus
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
            WHEN "FC"
               HIDE OPTION "final_confirmed"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)
      CALL cl_set_act_visible("final_confirmed",FALSE)
      
      CASE g_bgbi_m.bgbistus
         WHEN "N"
           #CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            CALL cl_set_act_visible("unconfirmed,hold,invalid",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            CALL s_transaction_end('N','0')
            RETURN

         WHEN "Y"
           #CALL cl_set_act_visible("invalid,confirmed",FALSE)
            CALL cl_set_act_visible("invalid,confirmed,invalid",FALSE)

         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      #end add-point
      
      
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"

            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"

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
      ON ACTION final_confirmed
         IF cl_auth_chk_act("final_confirmed") THEN
            LET lc_state = "FC"
            #add-point:action控制 name="statechange.final_confirmed"

            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"

      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      AND lc_state <> "FC"
      ) OR 
      g_bgbi_m.bgbistus = lc_state OR cl_null(lc_state) THEN
      CLOSE abgt027_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      CALL cl_err_collect_init()
      IF NOT s_abgt027_conf_chk(g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi044) THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_abgt027_conf_upd(g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi044) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #取消確認
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      IF NOT s_abgt027_unconf_chk(g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi044) THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_abgt027_unconf_upd(g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005,g_bgbi_m.bgbi044) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET l_bgbimoddt = cl_get_current()
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE bgbi_t 
      SET (bgbistus,bgbimodid,bgbimoddt) 
        = (lc_state,g_user,l_bgbimoddt)
    WHERE bgbient = g_enterprise AND bgbi002 = g_bgbi_m.bgbi002
      AND bgbi003 = g_bgbi_m.bgbi003 AND bgbi004 = g_bgbi_m.bgbi004
      AND bgbi005 = g_bgbi_m.bgbi005 AND bgbi044 = '1'
      AND bgbistus = g_bgbi_m.bgbistus
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
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "FC"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/final_confirmed.png")
      END CASE
    
      #撈取異動後的資料
      EXECUTE abgt027_master_referesh USING g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi004,g_bgbi_m.bgbi005, 
          g_bgbi_m.bgbi044,g_bgbi_m.bgbistus INTO g_bgbi_m.bgbi002,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi004, 
          g_bgbi_m.bgbi005,g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_bgbi_m.bgbi002,g_bgbi_m.bgbi002_desc,g_bgbi_m.bgbi003,g_bgbi_m.bgbi045,g_bgbi_m.bgbi045_desc, 
          g_bgbi_m.bgbi004,g_bgbi_m.bgbi004_desc,g_bgbi_m.bgbi005,g_bgbi_m.bgbi005_desc,g_bgbi_m.l_bgaa002, 
          g_bgbi_m.bgbi017,g_bgbi_m.bgbi046,g_bgbi_m.bgbi044,g_bgbi_m.bgbistus
      
      CALL abgt027_show()
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"

   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"

   #end add-point  
 
   CLOSE abgt027_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL abgt027_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION

################################################################################
# Descriptions...: #+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
# Memo...........: #160818-00017#3
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20160824 By 07900
# Modify.........:
################################################################################
PRIVATE FUNCTION abgt027_action_chk()
 #add-point:action_chk段define(客製用) name="action_chk.define_customerization"

   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"

   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"

   SELECT bgbistus INTO g_bgbi_m.bgbistus
     FROM bgbi_t
    WHERE bgbient = g_enterprise      
      AND bgbi002 = g_bgbi_m.bgbi002
      AND bgbi003 = g_bgbi_m.bgbi003
      AND bgbi004 = g_bgbi_m.bgbi004
      AND bgbi005 = g_bgbi_m.bgbi005
      AND bgbi044 = g_bgbi_m.bgbi044

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_bgbi_m.bgbistus
        WHEN 'FC'
           LET g_errno = 'abg-00020'
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_bgbi_m.bgbi002
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL abgt027_set_act_visible()
        CALL abgt027_set_act_no_visible()
        CALL abgt027_show()
        RETURN FALSE
     END IF
   END IF
   
   #end add-point
      
   RETURN TRUE
END FUNCTION

 
{</section>}
 
