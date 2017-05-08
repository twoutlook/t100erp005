#該程式未解開Section, 採用最新樣板產出!
{<section id="afai021.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2016-08-08 09:51:44), PR版次:0011(2016-11-17 14:26:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000294
#+ Filename...: afai021
#+ Description: 資產主要類型依帳套設定科目作業
#+ Creator....: 02291(2014-03-13 17:35:21)
#+ Modifier...: 01531 -SD/PR- 08172
 
{</section>}
 
{<section id="afai021.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#4   2016/04/12  BY 07675  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160426-00014#8   2016/07/22  BY 01531  增加列管与列帐,scc-9897，默认值为2：列账
#160426-00014#33  2016/08/17  BY 02114  修改权限的问题
#161026-00014#1   2016/10/26  By 01531  当主要類型編號被使用(例如afai100，afai120),则不可删除
#161024-00008#6   2016/10/28  By Hans        AFA組織類型與職能開窗清單調整。 
#161111-00028#6   2016/11/17  by 08172  标准程式定义采用宣告模式,弃用.*写法
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
#150916-00015#1  2015/12/7 By Xiaozg  1.快捷带出类似科目编号 2. 当有账套时，科目检查改为检查是否存在于glad_t中
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_faal_m        RECORD
       faalld LIKE faal_t.faalld, 
   faalld_desc LIKE type_t.chr80, 
   glaacomp LIKE glaa_t.glaacomp, 
   glaacomp_desc LIKE type_t.chr80, 
   faal001 LIKE faal_t.faal001, 
   faal001_desc LIKE type_t.chr80, 
   glaa004 LIKE glaa_t.glaa004, 
   glaa004_desc LIKE type_t.chr80, 
   glaa014 LIKE glaa_t.glaa014, 
   glaa008 LIKE glaa_t.glaa008, 
   faal002 LIKE faal_t.faal002, 
   faal003 LIKE faal_t.faal003, 
   faal004 LIKE faal_t.faal004, 
   faal005 LIKE faal_t.faal005, 
   faal006 LIKE faal_t.faal006, 
   faalstus LIKE faal_t.faalstus, 
   faalownid LIKE faal_t.faalownid, 
   faalownid_desc LIKE type_t.chr80, 
   faalowndp LIKE faal_t.faalowndp, 
   faalowndp_desc LIKE type_t.chr80, 
   faalcrtid LIKE faal_t.faalcrtid, 
   faalcrtid_desc LIKE type_t.chr80, 
   faalcrtdp LIKE faal_t.faalcrtdp, 
   faalcrtdp_desc LIKE type_t.chr80, 
   faalcrtdt LIKE faal_t.faalcrtdt, 
   faalmodid LIKE faal_t.faalmodid, 
   faalmodid_desc LIKE type_t.chr80, 
   faalmoddt LIKE faal_t.faalmoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_glab_d        RECORD
       glab001 LIKE glab_t.glab001, 
   glab003 LIKE glab_t.glab003, 
   glab003_desc LIKE type_t.chr500, 
   glab005 LIKE glab_t.glab005, 
   glab005_desc LIKE type_t.chr500, 
   glab011 LIKE glab_t.glab011
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_faalld LIKE faal_t.faalld,
      b_faal001 LIKE faal_t.faal001
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_faal_m          type_g_faal_m
DEFINE g_faal_m_t        type_g_faal_m
DEFINE g_faal_m_o        type_g_faal_m
DEFINE g_faal_m_mask_o   type_g_faal_m #轉換遮罩前資料
DEFINE g_faal_m_mask_n   type_g_faal_m #轉換遮罩後資料
 
   DEFINE g_faalld_t LIKE faal_t.faalld
DEFINE g_faal001_t LIKE faal_t.faal001
 
 
DEFINE g_glab_d          DYNAMIC ARRAY OF type_g_glab_d
DEFINE g_glab_d_t        type_g_glab_d
DEFINE g_glab_d_o        type_g_glab_d
DEFINE g_glab_d_mask_o   DYNAMIC ARRAY OF type_g_glab_d #轉換遮罩前資料
DEFINE g_glab_d_mask_n   DYNAMIC ARRAY OF type_g_glab_d #轉換遮罩後資料
 
 
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
 
{<section id="afai021.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
      
   #end add-point
   LET g_forupd_sql = " SELECT faalld,'','','',faal001,'','','','','',faal002,faal003,faal004,faal005, 
       faal006,faalstus,faalownid,'',faalowndp,'',faalcrtid,'',faalcrtdp,'',faalcrtdt,faalmodid,'',faalmoddt", 
        
                      " FROM faal_t",
                      " WHERE faalent= ? AND faalld=? AND faal001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afai021_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.faalld,t0.faal001,t0.faal002,t0.faal003,t0.faal004,t0.faal005,t0.faal006, 
       t0.faalstus,t0.faalownid,t0.faalowndp,t0.faalcrtid,t0.faalcrtdp,t0.faalcrtdt,t0.faalmodid,t0.faalmoddt, 
       t1.glaal002 ,t2.faacl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011",
               " FROM faal_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.faalld AND t1.glaal001='"||g_dlang||"' ",
               " LEFT JOIN faacl_t t2 ON t2.faaclent="||g_enterprise||" AND t2.faacl001=t0.faal001 AND t2.faacl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.faalownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.faalowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.faalcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.faalcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.faalmodid  ",
 
               " WHERE t0.faalent = " ||g_enterprise|| " AND t0.faalld = ? AND t0.faal001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afai021_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afai021 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afai021_init()   
 
      #進入選單 Menu (="N")
      CALL afai021_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afai021
      
   END IF 
   
   CLOSE afai021_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afai021.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afai021_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('faalstus','17','N,Y')
 
      CALL cl_set_combo_scc('glab011','8315') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('faal005','9920')   
   CALL cl_set_combo_scc('glab003','9901')
   CALL cl_set_combo_scc('faal006','9897')  #160426-00014#8  
   CALL s_fin_create_account_center_tmp()   #160426-00014#33 add lujh     
   #end add-point
   
   #初始化搜尋條件
   CALL afai021_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afai021.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afai021_ui_dialog()
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
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL afai021_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_faal_m.* TO NULL
         CALL g_glab_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afai021_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_glab_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afai021_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL afai021_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL afai021_browser_fill("")
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
               CALL afai021_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afai021_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afai021_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afai021_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afai021_set_act_visible()   
            CALL afai021_set_act_no_visible()
            IF NOT (g_faal_m.faalld IS NULL
              OR g_faal_m.faal001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " faalent = " ||g_enterprise|| " AND",
                                  " faalld = '", g_faal_m.faalld, "' "
                                  ," AND faal001 = '", g_faal_m.faal001, "' "
 
               #填到對應位置
               CALL afai021_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "faal_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "glab_t" 
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
               CALL afai021_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "faal_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "glab_t" 
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
                  CALL afai021_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afai021_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afai021_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afai021_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afai021_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afai021_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afai021_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afai021_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afai021_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afai021_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afai021_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afai021_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_glab_d)
                  LET g_export_id[1]   = "s_detail1"
 
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
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afai021_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afai021_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afai021_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afai021_insert()
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
               CALL afai021_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afai021_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afai021_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afai021_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afai021_set_pk_array()
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
 
{<section id="afai021.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afai021_browser_fill(ps_page_action)
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
#        LET l_wc  = g_wc.trim() 
   
#   IF g_wc = " 1=1" THEN 
#      LET g_wc = " glab001 = '91'" 
#   END IF      
#   
#   IF cl_null(l_wc) THEN  #p_wc 查詢條件
#      RETURN
#   END IF
#   
#  
#   IF cl_null(g_wc) OR g_wc = " 1=1" THEN
#      LET g_wc = " glab001 = '91' "
#      IF NOT cl_null(g_argv[03]) THEN
#         LET g_wc =  g_wc CLIPPED," AND glab002 = '", g_argv[03], "' "       
#          
#      END IF
#   ELSE
#      LET g_wc = g_wc CLIPPED," AND glab001 = '91' "  
#   END IF
#
#   
#   
#   
#   LET l_wc  = g_wc.trim()
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
      LET l_sub_sql = " SELECT DISTINCT faalld,faal001 ",
                      " FROM faal_t ",
                      " ",
                      " LEFT JOIN glab_t ON glabent = faalent AND faalld = glabld AND faal001 = glab002 ", "  ",
                      #add-point:browser_fill段sql(glab_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE faalent = " ||g_enterprise|| " AND glabent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("faal_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT faalld,faal001 ",
                      " FROM faal_t ", 
                      "  ",
                      "  ",
                      " WHERE faalent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("faal_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
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
      INITIALIZE g_faal_m.* TO NULL
      CALL g_glab_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.faalld,t0.faal001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.faalstus,t0.faalld,t0.faal001 ",
                  " FROM faal_t t0",
                  "  ",
                  "  LEFT JOIN glab_t ON glabent = faalent AND faalld = glabld AND faal001 = glab002 ", "  ", 
                  #add-point:browser_fill段sql(glab_t1) name="browser_fill.join.glab_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.faalent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("faal_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.faalstus,t0.faalld,t0.faal001 ",
                  " FROM faal_t t0",
                  "  ",
                  
                  " WHERE t0.faalent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("faal_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY faalld,faal001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"faal_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_faalld,g_browser[g_cnt].b_faal001 
 
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
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
      END CASE
 
 
 
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
   
   IF cl_null(g_browser[g_cnt].b_faalld) THEN
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
 
{<section id="afai021.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afai021_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_faal_m.faalld = g_browser[g_current_idx].b_faalld   
   LET g_faal_m.faal001 = g_browser[g_current_idx].b_faal001   
 
   EXECUTE afai021_master_referesh USING g_faal_m.faalld,g_faal_m.faal001 INTO g_faal_m.faalld,g_faal_m.faal001, 
       g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus, 
       g_faal_m.faalownid,g_faal_m.faalowndp,g_faal_m.faalcrtid,g_faal_m.faalcrtdp,g_faal_m.faalcrtdt, 
       g_faal_m.faalmodid,g_faal_m.faalmoddt,g_faal_m.faalld_desc,g_faal_m.faal001_desc,g_faal_m.faalownid_desc, 
       g_faal_m.faalowndp_desc,g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp_desc,g_faal_m.faalmodid_desc 
 
   
   CALL afai021_faal_t_mask()
   CALL afai021_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afai021.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afai021_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afai021.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afai021_ui_browser_refresh()
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
      IF g_browser[l_i].b_faalld = g_faal_m.faalld 
         AND g_browser[l_i].b_faal001 = g_faal_m.faal001 
 
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
 
{<section id="afai021.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afai021_construct()
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
   DEFINE l_ld_str    STRING   #160426-00014#33 add lujh
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_faal_m.* TO NULL
   CALL g_glab_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON faalld,glaacomp_desc,faal001,glaa004_desc,faal002,faal003,faal004,faal005, 
          faal006,faalstus,faalownid,faalowndp,faalcrtid,faalcrtdp,faalcrtdt,faalmodid,faalmoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<faalcrtdt>>----
         AFTER FIELD faalcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<faalmoddt>>----
         AFTER FIELD faalmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<faalcnfdt>>----
         
         #----<<faalpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.faalld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faalld
            #add-point:ON ACTION controlp INFIELD faalld name="construct.c.faalld"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str   #160426-00014#33 add lujh
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')"   #160426-00014#33 add lujh
			   LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faalld  #顯示到畫面上

            NEXT FIELD faalld                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faalld
            #add-point:BEFORE FIELD faalld name="construct.b.faalld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faalld
            
            #add-point:AFTER FIELD faalld name="construct.a.faalld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="construct.c.glaacomp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where = " ooee003 = '1' "
            CALL q_ooef001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaacomp  #顯示到畫面上
            LET g_qryparam.where = ""

            NEXT FIELD glaacomp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="construct.b.glaacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="construct.a.glaacomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp_desc
            #add-point:BEFORE FIELD glaacomp_desc name="construct.b.glaacomp_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp_desc
            
            #add-point:AFTER FIELD glaacomp_desc name="construct.a.glaacomp_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaacomp_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp_desc
            #add-point:ON ACTION controlp INFIELD glaacomp_desc name="construct.c.glaacomp_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faal001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal001
            #add-point:ON ACTION controlp INFIELD faal001 name="construct.c.faal001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_faac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faal001  #顯示到畫面上

            NEXT FIELD faal001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal001
            #add-point:BEFORE FIELD faal001 name="construct.b.faal001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal001
            
            #add-point:AFTER FIELD faal001 name="construct.a.faal001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa004
            #add-point:ON ACTION controlp INFIELD glaa004 name="construct.c.glaa004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooal002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa004  #顯示到畫面上

            NEXT FIELD glaa004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa004
            #add-point:BEFORE FIELD glaa004 name="construct.b.glaa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa004
            
            #add-point:AFTER FIELD glaa004 name="construct.a.glaa004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa004_desc
            #add-point:BEFORE FIELD glaa004_desc name="construct.b.glaa004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa004_desc
            
            #add-point:AFTER FIELD glaa004_desc name="construct.a.glaa004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa004_desc
            #add-point:ON ACTION controlp INFIELD glaa004_desc name="construct.c.glaa004_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal002
            #add-point:BEFORE FIELD faal002 name="construct.b.faal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal002
            
            #add-point:AFTER FIELD faal002 name="construct.a.faal002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal002
            #add-point:ON ACTION controlp INFIELD faal002 name="construct.c.faal002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal003
            #add-point:BEFORE FIELD faal003 name="construct.b.faal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal003
            
            #add-point:AFTER FIELD faal003 name="construct.a.faal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal003
            #add-point:ON ACTION controlp INFIELD faal003 name="construct.c.faal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal004
            #add-point:BEFORE FIELD faal004 name="construct.b.faal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal004
            
            #add-point:AFTER FIELD faal004 name="construct.a.faal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal004
            #add-point:ON ACTION controlp INFIELD faal004 name="construct.c.faal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal005
            #add-point:BEFORE FIELD faal005 name="construct.b.faal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal005
            
            #add-point:AFTER FIELD faal005 name="construct.a.faal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal005
            #add-point:ON ACTION controlp INFIELD faal005 name="construct.c.faal005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal006
            #add-point:BEFORE FIELD faal006 name="construct.b.faal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal006
            
            #add-point:AFTER FIELD faal006 name="construct.a.faal006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faal006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal006
            #add-point:ON ACTION controlp INFIELD faal006 name="construct.c.faal006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faalstus
            #add-point:BEFORE FIELD faalstus name="construct.b.faalstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faalstus
            
            #add-point:AFTER FIELD faalstus name="construct.a.faalstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faalstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faalstus
            #add-point:ON ACTION controlp INFIELD faalstus name="construct.c.faalstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faalownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faalownid
            #add-point:ON ACTION controlp INFIELD faalownid name="construct.c.faalownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faalownid  #顯示到畫面上

            NEXT FIELD faalownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faalownid
            #add-point:BEFORE FIELD faalownid name="construct.b.faalownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faalownid
            
            #add-point:AFTER FIELD faalownid name="construct.a.faalownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faalowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faalowndp
            #add-point:ON ACTION controlp INFIELD faalowndp name="construct.c.faalowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
           # LET g_qryparam.where = " ooee003 = '1' "              #161024-00008#6
           # CALL q_ooef001_10()                          #呼叫開窗 #161024-00008#6
            CALL q_ooeg001_9 ()                                     #161024-00008#6
            DISPLAY g_qryparam.return1 TO faalowndp  #顯示到畫面上
            LET g_qryparam.where = ""

            NEXT FIELD faalowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faalowndp
            #add-point:BEFORE FIELD faalowndp name="construct.b.faalowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faalowndp
            
            #add-point:AFTER FIELD faalowndp name="construct.a.faalowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faalcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faalcrtid
            #add-point:ON ACTION controlp INFIELD faalcrtid name="construct.c.faalcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faalcrtid  #顯示到畫面上

            NEXT FIELD faalcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faalcrtid
            #add-point:BEFORE FIELD faalcrtid name="construct.b.faalcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faalcrtid
            
            #add-point:AFTER FIELD faalcrtid name="construct.a.faalcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faalcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faalcrtdp
            #add-point:ON ACTION controlp INFIELD faalcrtdp name="construct.c.faalcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooee003 = '1' "                #161024-00008#6
            #CALL q_ooef001_10()                          #呼叫開窗  #161024-00008#6
            CALL q_ooeg001_9 ()                                     #161024-00008#6
            DISPLAY g_qryparam.return1 TO faalcrtdp  #顯示到畫面上
            LET g_qryparam.where = ""

            NEXT FIELD faalcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faalcrtdp
            #add-point:BEFORE FIELD faalcrtdp name="construct.b.faalcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faalcrtdp
            
            #add-point:AFTER FIELD faalcrtdp name="construct.a.faalcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faalcrtdt
            #add-point:BEFORE FIELD faalcrtdt name="construct.b.faalcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.faalmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faalmodid
            #add-point:ON ACTION controlp INFIELD faalmodid name="construct.c.faalmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faalmodid  #顯示到畫面上

            NEXT FIELD faalmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faalmodid
            #add-point:BEFORE FIELD faalmodid name="construct.b.faalmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faalmodid
            
            #add-point:AFTER FIELD faalmodid name="construct.a.faalmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faalmoddt
            #add-point:BEFORE FIELD faalmoddt name="construct.b.faalmoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON glab001,glab003,glab003_desc,glab005,glab011
           FROM s_detail1[1].glab001,s_detail1[1].glab003,s_detail1[1].glab003_desc,s_detail1[1].glab005, 
               s_detail1[1].glab011
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab001
            #add-point:BEFORE FIELD glab001 name="construct.b.page1.glab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab001
            
            #add-point:AFTER FIELD glab001 name="construct.a.page1.glab001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab001
            #add-point:ON ACTION controlp INFIELD glab001 name="construct.c.page1.glab001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab003
            #add-point:BEFORE FIELD glab003 name="construct.b.page1.glab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab003
            
            #add-point:AFTER FIELD glab003 name="construct.a.page1.glab003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab003
            #add-point:ON ACTION controlp INFIELD glab003 name="construct.c.page1.glab003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab003_desc
            #add-point:BEFORE FIELD glab003_desc name="construct.b.page1.glab003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab003_desc
            
            #add-point:AFTER FIELD glab003_desc name="construct.a.page1.glab003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glab003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab003_desc
            #add-point:ON ACTION controlp INFIELD glab003_desc name="construct.c.page1.glab003_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005 name="construct.c.page1.glab005"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where = " glac003 <> '1' "
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glab005  #顯示到畫面上

            NEXT FIELD glab005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005 name="construct.b.page1.glab005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005
            
            #add-point:AFTER FIELD glab005 name="construct.a.page1.glab005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab011
            #add-point:BEFORE FIELD glab011 name="construct.b.page1.glab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab011
            
            #add-point:AFTER FIELD glab011 name="construct.a.page1.glab011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab011
            #add-point:ON ACTION controlp INFIELD glab011 name="construct.c.page1.glab011"
            
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
                  WHEN la_wc[li_idx].tableid = "faal_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "glab_t" 
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
       
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afai021.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afai021_query()
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
   CALL g_glab_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afai021_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afai021_browser_fill("")
      CALL afai021_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL afai021_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afai021_fetch("F") 
      #顯示單身筆數
      CALL afai021_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afai021.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afai021_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
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
   
   LET g_faal_m.faalld = g_browser[g_current_idx].b_faalld
   LET g_faal_m.faal001 = g_browser[g_current_idx].b_faal001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afai021_master_referesh USING g_faal_m.faalld,g_faal_m.faal001 INTO g_faal_m.faalld,g_faal_m.faal001, 
       g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus, 
       g_faal_m.faalownid,g_faal_m.faalowndp,g_faal_m.faalcrtid,g_faal_m.faalcrtdp,g_faal_m.faalcrtdt, 
       g_faal_m.faalmodid,g_faal_m.faalmoddt,g_faal_m.faalld_desc,g_faal_m.faal001_desc,g_faal_m.faalownid_desc, 
       g_faal_m.faalowndp_desc,g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp_desc,g_faal_m.faalmodid_desc 
 
   
   #遮罩相關處理
   LET g_faal_m_mask_o.* =  g_faal_m.*
   CALL afai021_faal_t_mask()
   LET g_faal_m_mask_n.* =  g_faal_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afai021_set_act_visible()   
   CALL afai021_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_faal_m_t.* = g_faal_m.*
   LET g_faal_m_o.* = g_faal_m.*
   
   LET g_data_owner = g_faal_m.faalownid      
   LET g_data_dept  = g_faal_m.faalowndp
   
   #重新顯示   
   CALL afai021_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="afai021.insert" >}
#+ 資料新增
PRIVATE FUNCTION afai021_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_glab_d.clear()   
 
 
   INITIALIZE g_faal_m.* TO NULL             #DEFAULT 設定
   
   LET g_faalld_t = NULL
   LET g_faal001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_faal_m.faalownid = g_user
      LET g_faal_m.faalowndp = g_dept
      LET g_faal_m.faalcrtid = g_user
      LET g_faal_m.faalcrtdp = g_dept 
      LET g_faal_m.faalcrtdt = cl_get_current()
      LET g_faal_m.faalmodid = g_user
      LET g_faal_m.faalmoddt = cl_get_current()
      LET g_faal_m.faalstus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_faal_m.glaa014 = "N"
      LET g_faal_m.glaa008 = "N"
      LET g_faal_m.faal002 = "N"
      LET g_faal_m.faal003 = "N"
      LET g_faal_m.faal004 = "N"
      LET g_faal_m.faal006 = "2"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_faal_m.faalstus = 'Y'     
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_faal_m_t.* = g_faal_m.*
      LET g_faal_m_o.* = g_faal_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faal_m.faalstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL afai021_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      CALL afai021_show()           #20150924 add lujh
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
         INITIALIZE g_faal_m.* TO NULL
         INITIALIZE g_glab_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afai021_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_glab_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afai021_set_act_visible()   
   CALL afai021_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_faalld_t = g_faal_m.faalld
   LET g_faal001_t = g_faal_m.faal001
 
   
   #組合新增資料的條件
   LET g_add_browse = " faalent = " ||g_enterprise|| " AND",
                      " faalld = '", g_faal_m.faalld, "' "
                      ," AND faal001 = '", g_faal_m.faal001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afai021_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afai021_cl
   
   CALL afai021_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afai021_master_referesh USING g_faal_m.faalld,g_faal_m.faal001 INTO g_faal_m.faalld,g_faal_m.faal001, 
       g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus, 
       g_faal_m.faalownid,g_faal_m.faalowndp,g_faal_m.faalcrtid,g_faal_m.faalcrtdp,g_faal_m.faalcrtdt, 
       g_faal_m.faalmodid,g_faal_m.faalmoddt,g_faal_m.faalld_desc,g_faal_m.faal001_desc,g_faal_m.faalownid_desc, 
       g_faal_m.faalowndp_desc,g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp_desc,g_faal_m.faalmodid_desc 
 
   
   
   #遮罩相關處理
   LET g_faal_m_mask_o.* =  g_faal_m.*
   CALL afai021_faal_t_mask()
   LET g_faal_m_mask_n.* =  g_faal_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_faal_m.faalld,g_faal_m.faalld_desc,g_faal_m.glaacomp,g_faal_m.glaacomp_desc,g_faal_m.faal001, 
       g_faal_m.faal001_desc,g_faal_m.glaa004,g_faal_m.glaa004_desc,g_faal_m.glaa014,g_faal_m.glaa008, 
       g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus, 
       g_faal_m.faalownid,g_faal_m.faalownid_desc,g_faal_m.faalowndp,g_faal_m.faalowndp_desc,g_faal_m.faalcrtid, 
       g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp,g_faal_m.faalcrtdp_desc,g_faal_m.faalcrtdt,g_faal_m.faalmodid, 
       g_faal_m.faalmodid_desc,g_faal_m.faalmoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_faal_m.faalownid      
   LET g_data_dept  = g_faal_m.faalowndp
   
   #功能已完成,通報訊息中心
   CALL afai021_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afai021.modify" >}
#+ 資料修改
PRIVATE FUNCTION afai021_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF NOT s_ld_chk_authorization(g_user,g_faal_m.faalld) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_faal_m.faalld
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF  
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_faal_m_t.* = g_faal_m.*
   LET g_faal_m_o.* = g_faal_m.*
   
   IF g_faal_m.faalld IS NULL
   OR g_faal_m.faal001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_faalld_t = g_faal_m.faalld
   LET g_faal001_t = g_faal_m.faal001
 
   CALL s_transaction_begin()
   
   OPEN afai021_cl USING g_enterprise,g_faal_m.faalld,g_faal_m.faal001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afai021_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afai021_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afai021_master_referesh USING g_faal_m.faalld,g_faal_m.faal001 INTO g_faal_m.faalld,g_faal_m.faal001, 
       g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus, 
       g_faal_m.faalownid,g_faal_m.faalowndp,g_faal_m.faalcrtid,g_faal_m.faalcrtdp,g_faal_m.faalcrtdt, 
       g_faal_m.faalmodid,g_faal_m.faalmoddt,g_faal_m.faalld_desc,g_faal_m.faal001_desc,g_faal_m.faalownid_desc, 
       g_faal_m.faalowndp_desc,g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp_desc,g_faal_m.faalmodid_desc 
 
   
   #檢查是否允許此動作
   IF NOT afai021_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_faal_m_mask_o.* =  g_faal_m.*
   CALL afai021_faal_t_mask()
   LET g_faal_m_mask_n.* =  g_faal_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL afai021_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_faalld_t = g_faal_m.faalld
      LET g_faal001_t = g_faal_m.faal001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_faal_m.faalmodid = g_user 
LET g_faal_m.faalmoddt = cl_get_current()
LET g_faal_m.faalmodid_desc = cl_get_username(g_faal_m.faalmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      CALL afai021_b_upd()  #chenying add 1126
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afai021_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE faal_t SET (faalmodid,faalmoddt) = (g_faal_m.faalmodid,g_faal_m.faalmoddt)
          WHERE faalent = g_enterprise AND faalld = g_faalld_t
            AND faal001 = g_faal001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_faal_m.* = g_faal_m_t.*
            CALL afai021_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_faal_m.faalld != g_faal_m_t.faalld
      OR g_faal_m.faal001 != g_faal_m_t.faal001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE glab_t SET glabld = g_faal_m.faalld
                                       ,glab002 = g_faal_m.faal001
 
          WHERE glabent = g_enterprise AND glabld = g_faal_m_t.faalld
            AND glab002 = g_faal_m_t.faal001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "glab_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
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
   CALL afai021_set_act_visible()   
   CALL afai021_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " faalent = " ||g_enterprise|| " AND",
                      " faalld = '", g_faal_m.faalld, "' "
                      ," AND faal001 = '", g_faal_m.faal001, "' "
 
   #填到對應位置
   CALL afai021_browser_fill("")
 
   CLOSE afai021_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afai021_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afai021.input" >}
#+ 資料輸入
PRIVATE FUNCTION afai021_input(p_cmd)
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
   DEFINE  l_glaa004             LIKE glaa_t.glaa004
   DEFINE  l_sql                 STRING
   DEFINE  ls_wc                 STRING    #160426-00014#33 add lujh
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
   DISPLAY BY NAME g_faal_m.faalld,g_faal_m.faalld_desc,g_faal_m.glaacomp,g_faal_m.glaacomp_desc,g_faal_m.faal001, 
       g_faal_m.faal001_desc,g_faal_m.glaa004,g_faal_m.glaa004_desc,g_faal_m.glaa014,g_faal_m.glaa008, 
       g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus, 
       g_faal_m.faalownid,g_faal_m.faalownid_desc,g_faal_m.faalowndp,g_faal_m.faalowndp_desc,g_faal_m.faalcrtid, 
       g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp,g_faal_m.faalcrtdp_desc,g_faal_m.faalcrtdt,g_faal_m.faalmodid, 
       g_faal_m.faalmodid_desc,g_faal_m.faalmoddt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
      
   #end add-point 
   LET g_forupd_sql = "SELECT glab001,glab003,glab005,glab011 FROM glab_t WHERE glabent=? AND glabld=?  
       AND glab002=? AND glab001=? AND glab003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
       
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afai021_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afai021_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afai021_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_faal_m.faalld,g_faal_m.faal001,g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004, 
       g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afai021.input.head" >}
      #單頭段
      INPUT BY NAME g_faal_m.faalld,g_faal_m.faal001,g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004, 
          g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afai021_cl USING g_enterprise,g_faal_m.faalld,g_faal_m.faal001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afai021_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afai021_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afai021_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF p_cmd = 'a' AND l_cmd_t = 'a' THEN
               LET g_faal_m.faalstus = 'Y'
               LET g_faal_m.faal005 = '1'
               DISPLAY BY NAME g_faal_m.faalstus,g_faal_m.faal005
            END IF
            IF p_cmd = 'a' AND l_cmd_t = 'r' THEN
               LET g_faal_m.faalstus = 'Y'
               DISPLAY BY NAME g_faal_m.faalstus
            END IF
            #end add-point
            CALL afai021_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faalld
            
            #add-point:AFTER FIELD faalld name="input.a.faalld"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_faal_m.faalld) AND NOT cl_null(g_faal_m.faal001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_faal_m.faalld != g_faalld_t  OR g_faal_m.faal001 != g_faal001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faal_t WHERE "||"faalent = '" ||g_enterprise|| "' AND "||"faalld = '"||g_faal_m.faalld ||"' AND "|| "faal001 = '"||g_faal_m.faal001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_faal_m.faalld) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faal_m.faalld
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME  
               ELSE
                  LET g_faal_m.faalld = '' 
                  LET g_faal_m.faalld_desc = ''
                  DISPLAY BY NAME g_faal_m.faalld,g_faal_m.faalld_desc
                  NEXT FIELD CURRENT
               END IF   
                
              IF NOT s_ld_chk_authorization(g_user,g_faal_m.faalld) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = g_faal_m.faalld
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_faal_m.faalld = ''
                  LET g_faal_m.faalld_desc = ''
                  DISPLAY BY NAME g_faal_m.faalld,g_faal_m.faalld_desc
                  CALL afai021_init_glaa()
                  NEXT FIELD CURRENT
               END IF     
               IF p_cmd = 'a' AND l_cmd_t = 'r' THEN
                  IF NOT afai021_glaald_chk() THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00138'
                     LET g_errparam.extend = g_faal_m.faalld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_faal_m.faalld = ''
                     LET g_faal_m.faalld_desc = ''
                     DISPLAY BY NAME g_faal_m.faalld,g_faal_m.faalld_desc
                     CALL afai021_init_glaa()
                     NEXT FIELD CURRENT
                     #EXIT DIALOG
                     
                  END IF
               END IF               
            END IF            
            CALL afai021_glabld_desc()
            CALL afai021_get_glaa(g_faal_m.faalld)  

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faalld
            #add-point:BEFORE FIELD faalld name="input.b.faalld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faalld
            #add-point:ON CHANGE faalld name="input.g.faalld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal001
            
            #add-point:AFTER FIELD faal001 name="input.a.faal001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_faal_m.faalld) AND NOT cl_null(g_faal_m.faal001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_faal_m.faalld != g_faalld_t  OR g_faal_m.faal001 != g_faal001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faal_t WHERE "||"faalent = '" ||g_enterprise|| "' AND "||"faalld = '"||g_faal_m.faalld ||"' AND "|| "faal001 = '"||g_faal_m.faal001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_faal_m.faal001) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faal_m.faal001
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00007:sub-01302|afai020|",cl_get_progname("afai020",g_lang,"2"),"|:EXEPROGafai020"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faac001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME  
               ELSE
                  LET g_faal_m.faal001 = '' 
                  LET g_faal_m.faal001_desc = ''
                  DISPLAY BY NAME g_faal_m.faal001,g_faal_m.faal001_desc
                  NEXT FIELD CURRENT
               END IF 
               #160426-00014#8 add s---             
               SELECT faac017 INTO g_faal_m.faal006 FROM faac_t
                WHERE faacent = g_enterprise AND faac001 = g_faal_m.faal001
               DISPLAY  g_faal_m.faal006 TO faal006    
               #160426-00014#8 add e---                   
            END IF            
            CALL afai021_glab002_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal001
            #add-point:BEFORE FIELD faal001 name="input.b.faal001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faal001
            #add-point:ON CHANGE faal001 name="input.g.faal001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal002
            #add-point:BEFORE FIELD faal002 name="input.b.faal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal002
            
            #add-point:AFTER FIELD faal002 name="input.a.faal002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faal002
            #add-point:ON CHANGE faal002 name="input.g.faal002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal003
            #add-point:BEFORE FIELD faal003 name="input.b.faal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal003
            
            #add-point:AFTER FIELD faal003 name="input.a.faal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faal003
            #add-point:ON CHANGE faal003 name="input.g.faal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal004
            #add-point:BEFORE FIELD faal004 name="input.b.faal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal004
            
            #add-point:AFTER FIELD faal004 name="input.a.faal004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faal004
            #add-point:ON CHANGE faal004 name="input.g.faal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal005
            #add-point:BEFORE FIELD faal005 name="input.b.faal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal005
            
            #add-point:AFTER FIELD faal005 name="input.a.faal005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faal005
            #add-point:ON CHANGE faal005 name="input.g.faal005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faal006
            #add-point:BEFORE FIELD faal006 name="input.b.faal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faal006
            
            #add-point:AFTER FIELD faal006 name="input.a.faal006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faal006
            #add-point:ON CHANGE faal006 name="input.g.faal006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faalstus
            #add-point:BEFORE FIELD faalstus name="input.b.faalstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faalstus
            
            #add-point:AFTER FIELD faalstus name="input.a.faalstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faalstus
            #add-point:ON CHANGE faalstus name="input.g.faalstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.faalld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faalld
            #add-point:ON ACTION controlp INFIELD faalld name="input.c.faalld"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faal_m.faalld             #給予default值
            
            #160426-00014#33--add--str--lujh
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc 
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
            #160426-00014#33--add--end--lujh
            
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_faal_m.faalld = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faal_m.faalld TO faalld              #顯示到畫面上
            CALL afai021_glabld_desc()
            CALL afai021_get_glaa(g_faal_m.faalld) 

            NEXT FIELD faalld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faal001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal001
            #add-point:ON ACTION controlp INFIELD faal001 name="input.c.faal001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faal_m.faal001             #給予default值

            #給予arg

            CALL q_faac001()                                #呼叫開窗

            LET g_faal_m.faal001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faal_m.faal001 TO faal001              #顯示到畫面上
            CALL afai021_glab002_desc()
            DISPLAY g_faal_m.faal001_desc TO faal001_desc 

            NEXT FIELD faal001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal002
            #add-point:ON ACTION controlp INFIELD faal002 name="input.c.faal002"
            
            #END add-point
 
 
         #Ctrlp:input.c.faal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal003
            #add-point:ON ACTION controlp INFIELD faal003 name="input.c.faal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.faal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal004
            #add-point:ON ACTION controlp INFIELD faal004 name="input.c.faal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.faal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal005
            #add-point:ON ACTION controlp INFIELD faal005 name="input.c.faal005"
            
            #END add-point
 
 
         #Ctrlp:input.c.faal006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faal006
            #add-point:ON ACTION controlp INFIELD faal006 name="input.c.faal006"
            
            #END add-point
 
 
         #Ctrlp:input.c.faalstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faalstus
            #add-point:ON ACTION controlp INFIELD faalstus name="input.c.faalstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_faal_m.faalld,g_faal_m.faal001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO faal_t (faalent,faalld,faal001,faal002,faal003,faal004,faal005,faal006,faalstus, 
                   faalownid,faalowndp,faalcrtid,faalcrtdp,faalcrtdt,faalmodid,faalmoddt)
               VALUES (g_enterprise,g_faal_m.faalld,g_faal_m.faal001,g_faal_m.faal002,g_faal_m.faal003, 
                   g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus,g_faal_m.faalownid, 
                   g_faal_m.faalowndp,g_faal_m.faalcrtid,g_faal_m.faalcrtdp,g_faal_m.faalcrtdt,g_faal_m.faalmodid, 
                   g_faal_m.faalmoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_faal_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               IF l_cmd_t = 'a' AND p_cmd = 'a' THEN
                  CALL afai021_b_upd()
                  #NEXT FIELD glab005  #chenying add 1126    #20150924 mark lujh
               END IF   
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL afai021_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afai021_b_fill()
                  CALL afai021_b_fill2('0')
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
               CALL afai021_faal_t_mask_restore('restore_mask_o')
               
               UPDATE faal_t SET (faalld,faal001,faal002,faal003,faal004,faal005,faal006,faalstus,faalownid, 
                   faalowndp,faalcrtid,faalcrtdp,faalcrtdt,faalmodid,faalmoddt) = (g_faal_m.faalld,g_faal_m.faal001, 
                   g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006, 
                   g_faal_m.faalstus,g_faal_m.faalownid,g_faal_m.faalowndp,g_faal_m.faalcrtid,g_faal_m.faalcrtdp, 
                   g_faal_m.faalcrtdt,g_faal_m.faalmodid,g_faal_m.faalmoddt)
                WHERE faalent = g_enterprise AND faalld = g_faalld_t
                  AND faal001 = g_faal001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "faal_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afai021_faal_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_faal_m_t)
               LET g_log2 = util.JSON.stringify(g_faal_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                     
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_faalld_t = g_faal_m.faalld
            LET g_faal001_t = g_faal_m.faal001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afai021.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_glab_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            CALL afai021_b_fill()
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glab_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afai021_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_glab_d.getLength()
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
            OPEN afai021_cl USING g_enterprise,g_faal_m.faalld,g_faal_m.faal001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afai021_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afai021_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_glab_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_glab_d[l_ac].glab001 IS NOT NULL
               AND g_glab_d[l_ac].glab003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glab_d_t.* = g_glab_d[l_ac].*  #BACKUP
               LET g_glab_d_o.* = g_glab_d[l_ac].*  #BACKUP
               CALL afai021_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afai021_set_no_entry_b(l_cmd)
               IF NOT afai021_lock_b("glab_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afai021_bcl INTO g_glab_d[l_ac].glab001,g_glab_d[l_ac].glab003,g_glab_d[l_ac].glab005, 
                      g_glab_d[l_ac].glab011
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_glab_d_t.glab001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glab_d_mask_o[l_ac].* =  g_glab_d[l_ac].*
                  CALL afai021_glab_t_mask()
                  LET g_glab_d_mask_n[l_ac].* =  g_glab_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afai021_show()
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
            INITIALIZE g_glab_d[l_ac].* TO NULL 
            INITIALIZE g_glab_d_t.* TO NULL 
            INITIALIZE g_glab_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_glab_d[l_ac].glab001 = "90"
      LET g_glab_d[l_ac].glab011 = "1"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_glab_d_t.* = g_glab_d[l_ac].*     #新輸入資料
            LET g_glab_d_o.* = g_glab_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afai021_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afai021_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glab_d[li_reproduce_target].* = g_glab_d[li_reproduce].*
 
               LET g_glab_d[li_reproduce_target].glab001 = NULL
               LET g_glab_d[li_reproduce_target].glab003 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_glab_d[l_ac].glab001 = '91'
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
            SELECT COUNT(1) INTO l_count FROM glab_t 
             WHERE glabent = g_enterprise AND glabld = g_faal_m.faalld
               AND glab002 = g_faal_m.faal001
 
               AND glab001 = g_glab_d[l_ac].glab001
               AND glab003 = g_glab_d[l_ac].glab003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faal_m.faalld
               LET gs_keys[2] = g_faal_m.faal001
               LET gs_keys[3] = g_glab_d[g_detail_idx].glab001
               LET gs_keys[4] = g_glab_d[g_detail_idx].glab003
               CALL afai021_insert_b('glab_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_glab_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afai021_b_fill()
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
               LET gs_keys[01] = g_faal_m.faalld
               LET gs_keys[gs_keys.getLength()+1] = g_faal_m.faal001
 
               LET gs_keys[gs_keys.getLength()+1] = g_glab_d_t.glab001
               LET gs_keys[gs_keys.getLength()+1] = g_glab_d_t.glab003
 
            
               #刪除同層單身
               IF NOT afai021_delete_b('glab_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afai021_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afai021_key_delete_b(gs_keys,'glab_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afai021_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afai021_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
            
               #end add-point
               LET l_count = g_glab_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
            
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_glab_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab001
            #add-point:BEFORE FIELD glab001 name="input.b.page1.glab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab001
            
            #add-point:AFTER FIELD glab001 name="input.a.page1.glab001"
            #此段落由子樣板a05產生
            IF  g_faal_m.faalld IS NOT NULL AND g_faal_m.faal001 IS NOT NULL AND g_glab_d[g_detail_idx].glab001 IS NOT NULL AND g_glab_d[g_detail_idx].glab003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faal_m.faalld != g_faalld_t OR g_faal_m.faal001 != g_faal001_t OR g_glab_d[g_detail_idx].glab001 != g_glab_d_t.glab001  OR g_glab_d[g_detail_idx].glab003 != g_glab_d_t.glab003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glabld = '"||g_faal_m.faalld ||"' AND "|| "glab001 = '91' AND "|| "glab003 = '"||g_glab_d[g_detail_idx].glab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab001
            #add-point:ON CHANGE glab001 name="input.g.page1.glab001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab003
            
            #add-point:AFTER FIELD glab003 name="input.a.page1.glab003"
                        #此段落由子樣板a05產生
            IF  g_faal_m.faalld IS NOT NULL AND g_glab_d[g_detail_idx].glab001 IS NOT NULL AND g_faal_m.faal001 IS NOT NULL AND g_glab_d[g_detail_idx].glab003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faal_m.faalld != g_faalld_t OR g_glab_d[g_detail_idx].glab001 != g_glab_d_t.glab001 OR g_faal_m.faal001 != g_faal001_t OR g_glab_d[g_detail_idx].glab003 != g_glab_d_t.glab003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glabld = '"||g_faal_m.faalld ||"' AND "|| "glab001 = '"||g_glab_d[g_detail_idx].glab001 ||"' AND "|| "glab002 = '"||g_faal_m.faal001 ||"' AND "|| "glab003 = '"||g_glab_d[g_detail_idx].glab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab003
            #add-point:BEFORE FIELD glab003 name="input.b.page1.glab003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab003
            #add-point:ON CHANGE glab003 name="input.g.page1.glab003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab003_desc
            #add-point:BEFORE FIELD glab003_desc name="input.b.page1.glab003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab003_desc
            
            #add-point:AFTER FIELD glab003_desc name="input.a.page1.glab003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab003_desc
            #add-point:ON CHANGE glab003_desc name="input.g.page1.glab003_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005
            
            #add-point:AFTER FIELD glab005 name="input.a.page1.glab005"
       IF NOT cl_null(g_glab_d[l_ac].glab005) THEN 
             #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG20151130
              LET l_sql = " "
              IF  s_aglt310_getlike_lc_subject(g_faal_m.faalld,g_glab_d[l_ac].glab005,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_faal_m.faalld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_glab_d[l_ac].glab005
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_glab_d[l_ac].glab005
                LET g_qryparam.arg3 = g_faal_m.faalld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_glab_d[l_ac].glab005 = g_qryparam.return1              #將開窗取得的值回傳到變數
           
                 DISPLAY g_glab_d[l_ac].glab005 TO glab005              #顯示到畫面上
           
                 CALL afai021_glab005_desc()
            DISPLAY g_glab_d[l_ac].glab005_desc TO glab005_desc  
              END IF
                IF  NOT s_aglt310_lc_subject(g_faal_m.faalld,g_glab_d[l_ac].glab005,'N') THEN
                      IF l_cmd = 'a' THEN 
                     LET g_glab_d[l_ac].glab005 = ''
                     LET g_glab_d[l_ac].glab005_desc = ''
                  ELSE
                     LET g_glab_d[l_ac].glab005 = g_glab_d_t.glab005
                  END IF
                  DISPLAY BY NAME g_glab_d[l_ac].glab005 
                  DISPLAY BY NAME g_glab_d[l_ac].glab005_desc

 
                  NEXT FIELD CURRENT
                END IF
              
            #  150916-00015#1 END
                        
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faal_m.glaa004
               LET g_chkparam.arg2 = g_glab_d[l_ac].glab005
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #LET  = g_chkparam.return2                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  IF l_cmd = 'a' THEN 
                     LET g_glab_d[l_ac].glab005 = ''
                     LET g_glab_d[l_ac].glab005_desc = ''
                  ELSE
                     LET g_glab_d[l_ac].glab005 = g_glab_d_t.glab005
                  END IF
                  DISPLAY BY NAME g_glab_d[l_ac].glab005 
                  DISPLAY BY NAME g_glab_d[l_ac].glab005_desc

 
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL afai021_glab005_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005 name="input.b.page1.glab005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab005
            #add-point:ON CHANGE glab005 name="input.g.page1.glab005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab011
            #add-point:BEFORE FIELD glab011 name="input.b.page1.glab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab011
            
            #add-point:AFTER FIELD glab011 name="input.a.page1.glab011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab011
            #add-point:ON CHANGE glab011 name="input.g.page1.glab011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab001
            #add-point:ON ACTION controlp INFIELD glab001 name="input.c.page1.glab001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab003
            #add-point:ON ACTION controlp INFIELD glab003 name="input.c.page1.glab003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glab003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab003_desc
            #add-point:ON ACTION controlp INFIELD glab003_desc name="input.c.page1.glab003_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005 name="input.c.page1.glab005"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_d[l_ac].glab005             #給予default值

            #給予arg
            LET g_qryparam.where = " glac003 <> '1' AND glac001 = '",g_faal_m.glaa004,"'",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_faal_m.faalld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()                                #呼叫開窗

            LET g_glab_d[l_ac].glab005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glab_d[l_ac].glab005 TO glab005              #顯示到畫面上

            CALL afai021_glab005_desc()
            DISPLAY g_glab_d[l_ac].glab005_desc TO glab005_desc              

            NEXT FIELD glab005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab011
            #add-point:ON ACTION controlp INFIELD glab011 name="input.c.page1.glab011"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glab_d[l_ac].* = g_glab_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afai021_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_glab_d[l_ac].glab001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_glab_d[l_ac].* = g_glab_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afai021_glab_t_mask_restore('restore_mask_o')
      
               UPDATE glab_t SET (glabld,glab002,glab001,glab003,glab005,glab011) = (g_faal_m.faalld, 
                   g_faal_m.faal001,g_glab_d[l_ac].glab001,g_glab_d[l_ac].glab003,g_glab_d[l_ac].glab005, 
                   g_glab_d[l_ac].glab011)
                WHERE glabent = g_enterprise AND glabld = g_faal_m.faalld 
                  AND glab002 = g_faal_m.faal001 
 
                  AND glab001 = g_glab_d_t.glab001 #項次   
                  AND glab003 = g_glab_d_t.glab003  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_glab_d[l_ac].* = g_glab_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glab_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_glab_d[l_ac].* = g_glab_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faal_m.faalld
               LET gs_keys_bak[1] = g_faalld_t
               LET gs_keys[2] = g_faal_m.faal001
               LET gs_keys_bak[2] = g_faal001_t
               LET gs_keys[3] = g_glab_d[g_detail_idx].glab001
               LET gs_keys_bak[3] = g_glab_d_t.glab001
               LET gs_keys[4] = g_glab_d[g_detail_idx].glab003
               LET gs_keys_bak[4] = g_glab_d_t.glab003
               CALL afai021_update_b('glab_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afai021_glab_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_glab_d[g_detail_idx].glab001 = g_glab_d_t.glab001 
                  AND g_glab_d[g_detail_idx].glab003 = g_glab_d_t.glab003 
 
                  ) THEN
                  LET gs_keys[01] = g_faal_m.faalld
                  LET gs_keys[gs_keys.getLength()+1] = g_faal_m.faal001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_glab_d_t.glab001
                  LET gs_keys[gs_keys.getLength()+1] = g_glab_d_t.glab003
 
                  CALL afai021_key_update_b(gs_keys,'glab_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_faal_m),util.JSON.stringify(g_glab_d_t)
               LET g_log2 = util.JSON.stringify(g_faal_m),util.JSON.stringify(g_glab_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afai021_unlock_b("glab_t","'1'")
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
               LET g_glab_d[li_reproduce_target].* = g_glab_d[li_reproduce].*
 
               LET g_glab_d[li_reproduce_target].glab001 = NULL
               LET g_glab_d[li_reproduce_target].glab003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glab_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glab_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="afai021.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD faalld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD glab001
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afai021.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afai021_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afai021_b_fill() #單身填充
      CALL afai021_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afai021_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL afai021_glab002_desc()
   
   CALL afai021_get_glaa(g_faal_m.faalld)
   CALL afai021_glab002_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faal_m.faalownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_faal_m.faalownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faal_m.faalownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faal_m.faalowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faal_m.faalowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faal_m.faalowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faal_m.faalcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_faal_m.faalcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faal_m.faalcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faal_m.faalcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faal_m.faalcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faal_m.faalcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faal_m.faalmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_faal_m.faalmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faal_m.faalmodid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_faal_m_mask_o.* =  g_faal_m.*
   CALL afai021_faal_t_mask()
   LET g_faal_m_mask_n.* =  g_faal_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_faal_m.faalld,g_faal_m.faalld_desc,g_faal_m.glaacomp,g_faal_m.glaacomp_desc,g_faal_m.faal001, 
       g_faal_m.faal001_desc,g_faal_m.glaa004,g_faal_m.glaa004_desc,g_faal_m.glaa014,g_faal_m.glaa008, 
       g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus, 
       g_faal_m.faalownid,g_faal_m.faalownid_desc,g_faal_m.faalowndp,g_faal_m.faalowndp_desc,g_faal_m.faalcrtid, 
       g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp,g_faal_m.faalcrtdp_desc,g_faal_m.faalcrtdt,g_faal_m.faalmodid, 
       g_faal_m.faalmodid_desc,g_faal_m.faalmoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faal_m.faalstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_glab_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glab_d[l_ac].glab003
            CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE  gzcbl001='9901' AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glab_d[l_ac].glab003_desc = '', g_rtn_fields[1] , ''
            
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_faal_m.glaa004
            #LET g_ref_fields[2] = g_glab_d[l_ac].glab005
            #CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_glab_d[l_ac].glab005_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_glab_d[l_ac].glab005_desc
            CALL afai021_glab005_desc()
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afai021_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afai021.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afai021_detail_show()
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
 
{<section id="afai021.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afai021_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE faal_t.faalld 
   DEFINE l_oldno     LIKE faal_t.faalld 
   DEFINE l_newno02     LIKE faal_t.faal001 
   DEFINE l_oldno02     LIKE faal_t.faal001 
 
   DEFINE l_master    RECORD LIKE faal_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE glab_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_faal_m.faalld IS NULL
   OR g_faal_m.faal001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_faalld_t = g_faal_m.faalld
   LET g_faal001_t = g_faal_m.faal001
 
    
   LET g_faal_m.faalld = ""
   LET g_faal_m.faal001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_faal_m.faalownid = g_user
      LET g_faal_m.faalowndp = g_dept
      LET g_faal_m.faalcrtid = g_user
      LET g_faal_m.faalcrtdp = g_dept 
      LET g_faal_m.faalcrtdt = cl_get_current()
      LET g_faal_m.faalmodid = g_user
      LET g_faal_m.faalmoddt = cl_get_current()
      LET g_faal_m.faalstus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"

   LET g_faal_m.faalld = '' 
   LET g_faal_m.faalld_desc = ''
   DISPLAY BY NAME g_faal_m.faalld,g_faal_m.faalld_desc
   LET g_faal_m.faal001 = ''
   LET g_faal_m.faal001_desc = ''
   DISPLAY BY NAME g_faal_m.faal001,g_faal_m.faal001_desc
   LET g_faal_m.glaa014 = ''
   LET g_faal_m.glaa008 = ''
   LET g_faal_m.glaacomp = ''
   LET g_faal_m.glaacomp_desc = ''
   LET g_faal_m.glaa004 = ''
   LET g_faal_m.glaa004_desc = ''
   DISPLAY BY NAME g_faal_m.glaa014,g_faal_m.glaa008,g_faal_m.glaacomp,g_faal_m.glaacomp_desc,g_faal_m.glaa004,g_faal_m.glaa004_desc
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faal_m.faalstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_faal_m.faalld_desc = ''
   DISPLAY BY NAME g_faal_m.faalld_desc
   LET g_faal_m.faal001_desc = ''
   DISPLAY BY NAME g_faal_m.faal001_desc
 
   
   CALL afai021_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_faal_m.* TO NULL
      INITIALIZE g_glab_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
 
      #end add-point
      CALL afai021_show()
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
   CALL afai021_set_act_visible()   
   CALL afai021_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_faalld_t = g_faal_m.faalld
   LET g_faal001_t = g_faal_m.faal001
 
   
   #組合新增資料的條件
   LET g_add_browse = " faalent = " ||g_enterprise|| " AND",
                      " faalld = '", g_faal_m.faalld, "' "
                      ," AND faal001 = '", g_faal_m.faal001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afai021_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
 
   #end add-point
   
   CALL afai021_idx_chk()
   
   LET g_data_owner = g_faal_m.faalownid      
   LET g_data_dept  = g_faal_m.faalowndp
   
   #功能已完成,通報訊息中心
   CALL afai021_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afai021.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afai021_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE glab_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afai021_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glab_t
    WHERE glabent = g_enterprise AND glabld = g_faalld_t
     AND glab002 = g_faal001_t
 
    INTO TEMP afai021_detail
 
   #將key修正為調整後   
   UPDATE afai021_detail 
      #更新key欄位
      SET glabld = g_faal_m.faalld
          , glab002 = g_faal_m.faal001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO glab_t SELECT * FROM afai021_detail
   
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
   DROP TABLE afai021_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_faalld_t = g_faal_m.faalld
   LET g_faal001_t = g_faal_m.faal001
 
   
END FUNCTION
 
{</section>}
 
{<section id="afai021.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afai021_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_cnt           LIKE type_t.num5  #161026-00014#1 add
   IF NOT s_ld_chk_authorization(g_user,g_faal_m.faalld) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_faal_m.faalld
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_faal_m.faalld IS NULL
   OR g_faal_m.faal001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afai021_cl USING g_enterprise,g_faal_m.faalld,g_faal_m.faal001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afai021_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afai021_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afai021_master_referesh USING g_faal_m.faalld,g_faal_m.faal001 INTO g_faal_m.faalld,g_faal_m.faal001, 
       g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus, 
       g_faal_m.faalownid,g_faal_m.faalowndp,g_faal_m.faalcrtid,g_faal_m.faalcrtdp,g_faal_m.faalcrtdt, 
       g_faal_m.faalmodid,g_faal_m.faalmoddt,g_faal_m.faalld_desc,g_faal_m.faal001_desc,g_faal_m.faalownid_desc, 
       g_faal_m.faalowndp_desc,g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp_desc,g_faal_m.faalmodid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT afai021_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_faal_m_mask_o.* =  g_faal_m.*
   CALL afai021_faal_t_mask()
   LET g_faal_m_mask_n.* =  g_faal_m.*
   
   CALL afai021_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afai021_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      #161026-00014#1 add s---   
         LET l_cnt = 0 
         SELECT COUNT(1) INTO l_cnt FROM faah_t LEFT JOIN faaj_t ON faajent = faahent AND faaj000 = faah000 
            AND faaj001 = faah003 AND faaj002 = faah004 AND faaj037 = faah001
          WHERE faahent = g_enterprise
            AND faah006 = g_faal_m.faal001
            AND faajld = g_faal_m.faalld
            AND faahstus <> 'X'
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-01105'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            RETURN
         END IF   
          
         LET l_cnt = 0 
         SELECT COUNT(1) INTO l_cnt FROM faak_t
          WHERE faakent = g_enterprise
            AND faak006 = g_faal_m.faal001
            AND faakld = g_faal_m.faalld
            AND faakstus <> 'X'
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-01106'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            RETURN
         END IF  
         #161026-00014#1 add e---
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_faalld_t = g_faal_m.faalld
      LET g_faal001_t = g_faal_m.faal001
 
 
      DELETE FROM faal_t
       WHERE faalent = g_enterprise AND faalld = g_faal_m.faalld
         AND faal001 = g_faal_m.faal001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_faal_m.faalld,":",SQLERRMESSAGE  
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
      
      DELETE FROM glab_t
       WHERE glabent = g_enterprise AND glabld = g_faal_m.faalld
         AND glab002 = g_faal_m.faal001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_faal_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afai021_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_glab_d.clear() 
 
     
      CALL afai021_ui_browser_refresh()  
      #CALL afai021_ui_headershow()  
      #CALL afai021_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afai021_browser_fill("")
         CALL afai021_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afai021_cl
 
   #功能已完成,通報訊息中心
   CALL afai021_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afai021.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afai021_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_glab_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT glab001,glab003,'',glab005,'',glab011 FROM glab_t",   
               " WHERE glabent= ? AND glabld=? AND glab001='91' AND glab002=?"  
   LET g_sql = g_sql," AND glab003 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '9901') "                 
   IF NOT cl_null(p_wc2) THEN
      LET g_sql = g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF
  
   #子單身的WC
   
   
   #判斷是否填充
   IF afai021_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY glab_t.glabld,glab_t.glab001,glab_t.glab002,glab_t.glab003"
      
      PREPARE afai021_pb1 FROM g_sql
      DECLARE b_fill_cs1 CURSOR FOR afai021_pb1
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs1 USING g_enterprise,g_faal_m.faalld
 
                                               ,g_faal_m.faal001
 
 
                                               
      FOREACH b_fill_cs1 INTO g_glab_d[l_ac].glab001,g_glab_d[l_ac].glab003,g_glab_d[l_ac].glab003_desc,g_glab_d[l_ac].glab005, 
          g_glab_d[l_ac].glab005_desc,g_glab_d[l_ac].glab011
 
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_glab_d[l_ac].glab003
         CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE  gzcbl001='9901' AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_glab_d[l_ac].glab003_desc = '', g_rtn_fields[1] , ''
         
         CALL afai021_glab005_desc()
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      CALL g_glab_d.deleteElement(g_glab_d.getLength())
 
   END IF
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE afai021_pb1   
   RETURN 
   #end add-point
   
   #判斷是否填充
   IF afai021_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT glab001,glab003,glab005,glab011 ,t1.glacl004 FROM glab_t",   
                     " INNER JOIN faal_t ON faalent = " ||g_enterprise|| " AND faalld = glabld ",
                     " AND faal001 = glab002 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN glacl_t t1 ON t1.glaclent="||g_enterprise||" AND t1.glacl001='' AND t1.glacl002=glab005 AND t1.glacl003='"||g_dlang||"' ",
 
                     " WHERE glabent=? AND glabld=? AND glab002=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
      
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY glab_t.glab001,glab_t.glab003"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afai021_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afai021_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_faal_m.faalld,g_faal_m.faal001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_faal_m.faalld,g_faal_m.faal001 INTO g_glab_d[l_ac].glab001, 
          g_glab_d[l_ac].glab003,g_glab_d[l_ac].glab005,g_glab_d[l_ac].glab011,g_glab_d[l_ac].glab005_desc  
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
   
   #end add-point
   
   CALL g_glab_d.deleteElement(g_glab_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afai021_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_glab_d.getLength()
      LET g_glab_d_mask_o[l_ac].* =  g_glab_d[l_ac].*
      CALL afai021_glab_t_mask()
      LET g_glab_d_mask_n[l_ac].* =  g_glab_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afai021.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afai021_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM glab_t
       WHERE glabent = g_enterprise AND
         glabld = ps_keys_bak[1] AND glab002 = ps_keys_bak[2] AND glab001 = ps_keys_bak[3] AND glab003 = ps_keys_bak[4]
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
         CALL g_glab_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afai021.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afai021_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO glab_t
                  (glabent,
                   glabld,glab002,
                   glab001,glab003
                   ,glab005,glab011) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_glab_d[g_detail_idx].glab005,g_glab_d[g_detail_idx].glab011)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_glab_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afai021.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afai021_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "glab_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afai021_glab_t_mask_restore('restore_mask_o')
               
      UPDATE glab_t 
         SET (glabld,glab002,
              glab001,glab003
              ,glab005,glab011) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_glab_d[g_detail_idx].glab005,g_glab_d[g_detail_idx].glab011) 
         WHERE glabent = g_enterprise AND glabld = ps_keys_bak[1] AND glab002 = ps_keys_bak[2] AND glab001 = ps_keys_bak[3] AND glab003 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glab_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glab_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afai021_glab_t_mask_restore('restore_mask_n')
               
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
 
{<section id="afai021.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afai021_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afai021.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afai021_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afai021.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afai021_lock_b(ps_table,ps_page)
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
   #CALL afai021_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "glab_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afai021_bcl USING g_enterprise,
                                       g_faal_m.faalld,g_faal_m.faal001,g_glab_d[g_detail_idx].glab001, 
                                           g_glab_d[g_detail_idx].glab003     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afai021_bcl:",SQLERRMESSAGE 
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
 
{<section id="afai021.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afai021_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afai021_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afai021.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afai021_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("faalld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("faalld,faal001",TRUE)
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
 
{<section id="afai021.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afai021_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("faalld,faal001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("faalld",FALSE)
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
 
{<section id="afai021.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afai021_set_entry_b(p_cmd)
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
 
{<section id="afai021.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afai021_set_no_entry_b(p_cmd)
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
 
{<section id="afai021.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afai021_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afai021.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afai021_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afai021.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afai021_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afai021.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afai021_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afai021.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afai021_default_search()
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
      LET ls_wc = ls_wc, " faalld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " faal001 = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "faal_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "glab_t" 
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
 
{<section id="afai021.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afai021_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF NOT s_ld_chk_authorization(g_user,g_faal_m.faalld) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_faal_m.faalld
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_faal_m.faalld IS NULL
      OR g_faal_m.faal001 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afai021_cl USING g_enterprise,g_faal_m.faalld,g_faal_m.faal001
   IF STATUS THEN
      CLOSE afai021_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afai021_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afai021_master_referesh USING g_faal_m.faalld,g_faal_m.faal001 INTO g_faal_m.faalld,g_faal_m.faal001, 
       g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus, 
       g_faal_m.faalownid,g_faal_m.faalowndp,g_faal_m.faalcrtid,g_faal_m.faalcrtdp,g_faal_m.faalcrtdt, 
       g_faal_m.faalmodid,g_faal_m.faalmoddt,g_faal_m.faalld_desc,g_faal_m.faal001_desc,g_faal_m.faalownid_desc, 
       g_faal_m.faalowndp_desc,g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp_desc,g_faal_m.faalmodid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT afai021_action_chk() THEN
      CLOSE afai021_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_faal_m.faalld,g_faal_m.faalld_desc,g_faal_m.glaacomp,g_faal_m.glaacomp_desc,g_faal_m.faal001, 
       g_faal_m.faal001_desc,g_faal_m.glaa004,g_faal_m.glaa004_desc,g_faal_m.glaa014,g_faal_m.glaa008, 
       g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus, 
       g_faal_m.faalownid,g_faal_m.faalownid_desc,g_faal_m.faalowndp,g_faal_m.faalowndp_desc,g_faal_m.faalcrtid, 
       g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp,g_faal_m.faalcrtdp_desc,g_faal_m.faalcrtdt,g_faal_m.faalmodid, 
       g_faal_m.faalmodid_desc,g_faal_m.faalmoddt
 
   CASE g_faal_m.faalstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_faal_m.faalstus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_faal_m.faalstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afai021_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_faal_m.faalmodid = g_user
   LET g_faal_m.faalmoddt = cl_get_current()
   LET g_faal_m.faalstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE faal_t 
      SET (faalstus,faalmodid,faalmoddt) 
        = (g_faal_m.faalstus,g_faal_m.faalmodid,g_faal_m.faalmoddt)     
    WHERE faalent = g_enterprise AND faalld = g_faal_m.faalld
      AND faal001 = g_faal_m.faal001
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE afai021_master_referesh USING g_faal_m.faalld,g_faal_m.faal001 INTO g_faal_m.faalld,g_faal_m.faal001, 
          g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006,g_faal_m.faalstus, 
          g_faal_m.faalownid,g_faal_m.faalowndp,g_faal_m.faalcrtid,g_faal_m.faalcrtdp,g_faal_m.faalcrtdt, 
          g_faal_m.faalmodid,g_faal_m.faalmoddt,g_faal_m.faalld_desc,g_faal_m.faal001_desc,g_faal_m.faalownid_desc, 
          g_faal_m.faalowndp_desc,g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp_desc,g_faal_m.faalmodid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_faal_m.faalld,g_faal_m.faalld_desc,g_faal_m.glaacomp,g_faal_m.glaacomp_desc, 
          g_faal_m.faal001,g_faal_m.faal001_desc,g_faal_m.glaa004,g_faal_m.glaa004_desc,g_faal_m.glaa014, 
          g_faal_m.glaa008,g_faal_m.faal002,g_faal_m.faal003,g_faal_m.faal004,g_faal_m.faal005,g_faal_m.faal006, 
          g_faal_m.faalstus,g_faal_m.faalownid,g_faal_m.faalownid_desc,g_faal_m.faalowndp,g_faal_m.faalowndp_desc, 
          g_faal_m.faalcrtid,g_faal_m.faalcrtid_desc,g_faal_m.faalcrtdp,g_faal_m.faalcrtdp_desc,g_faal_m.faalcrtdt, 
          g_faal_m.faalmodid,g_faal_m.faalmodid_desc,g_faal_m.faalmoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afai021_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afai021_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afai021.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afai021_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_glab_d.getLength() THEN
         LET g_detail_idx = g_glab_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glab_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glab_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afai021.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afai021_b_fill2(pi_idx)
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
   
   CALL afai021_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afai021.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afai021_fill_chk(ps_idx)
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
 
{<section id="afai021.status_show" >}
PRIVATE FUNCTION afai021_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afai021.mask_functions" >}
&include "erp/afa/afai021_mask.4gl"
 
{</section>}
 
{<section id="afai021.signature" >}
   
 
{</section>}
 
{<section id="afai021.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afai021_set_pk_array()
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
   LET g_pk_array[1].values = g_faal_m.faalld
   LET g_pk_array[1].column = 'faalld'
   LET g_pk_array[2].values = g_faal_m.faal001
   LET g_pk_array[2].column = 'faal001'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afai021.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afai021.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afai021_msgcentre_notify(lc_state)
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
   CALL afai021_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_faal_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afai021.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afai021_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afai021.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 根據帳套帶出歸屬法人、科目參照表、帳套編號、平行記帳否
# Memo...........:
# Usage..........: CALL afai021_get_glaa(p_glabld)
#                   
# Input parameter: p_glabld       帳套編號 
#                :  
# Return code....: 
#                :  
# Date & Author..: 2014/1/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afai021_get_glaa(p_glabld)
DEFINE p_glabld  LIKE glab_t.glabld
DEFINE l_count   LIKE type_t.num5
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glabld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp,glaa008,glaa014,glaa004 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_faal_m.glaacomp = g_rtn_fields[1]
   LET g_faal_m.glaa008 = g_rtn_fields[2]
   LET g_faal_m.glaa014 = g_rtn_fields[3]
   LET g_faal_m.glaa004 = g_rtn_fields[4]

   #檢查帶出的歸屬法人是否符合法人否= 'Y'
   IF NOT cl_null(g_rtn_fields[1]) THEN 
     # SELECT COUNT(*) INTO l_count FROM ooef_t,ooee_t WHERE ooefent = ooeeent AND ooef001 = ooee001 
     #  AND ooee002 = '1' AND ooee003 = '1' AND ooefent = g_enterprise AND ooef001 = g_rtn_fields[1]
      SELECT COUNT(*) INTO l_count FROM ooef_t
       WHERE ooefent = g_enterprise AND ooef001 = g_rtn_fields[1] AND  ooef003 = 'Y'
      IF l_count = 0 THEN 
         LET g_rtn_fields[1] = ''
         LET g_faal_m.glaacomp = g_rtn_fields[1] 
      END IF
   END IF   
       
   
   DISPLAY BY NAME g_faal_m.glaacomp,g_faal_m.glaa008,g_faal_m.glaa014,g_faal_m.glaa004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faal_m.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faal_m.glaacomp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_faal_m.glaacomp_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faal_m.glaa004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='0' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faal_m.glaa004_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_faal_m.glaa004_desc 
END FUNCTION
################################################################################
# Descriptions...: 科目說明顯示
# Memo...........:
# Usage..........: CALL afai021_glab005_desc()
#                  
# Input parameter:  
#                :  
# Return code....: 
#                :  
# Date & Author..: 2014/1/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afai021_glab005_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faal_m.glaa004
   LET g_ref_fields[2] = g_glab_d[l_ac].glab005
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glab_d[l_ac].glab005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glab_d[l_ac].glab005_desc   
END FUNCTION
################################################################################
# Descriptions...: 帳套說明顯示
# Memo...........:
# Usage..........: CALL afai021_glabld_desc()
#                   
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/1/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afai021_glabld_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faal_m.faalld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faal_m.faalld_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_faal_m.faalld_desc
END FUNCTION
################################################################################
# Descriptions...: 主要類型說明顯示
# Memo...........:
# Usage..........: CALL afai021_glab002_desc()
#                  
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/1/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afai021_glab002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faal_m.faal001
   CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faal_m.faal001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faal_m.faal001_desc
END FUNCTION
################################################################################
# Descriptions...: 插入單身設定項目說明
# Memo...........:
# Usage..........: CALL afai021_b_upd()
#                   
# Input parameter:  
#                :  
# Return code....:  
#                :  
# Date & Author..: 2014/1/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afai021_b_upd()
#161111-00028#6 -s by 08172
#DEFINE l_glab    RECORD LIKE glab_t.*     
DEFINE l_glab RECORD  #帳套應用會計科目設定檔
       glabent LIKE glab_t.glabent, #企业编号
       glabld LIKE glab_t.glabld, #账套
       glab001 LIKE glab_t.glab001, #设置类型
       glab002 LIKE glab_t.glab002, #分类码
       glab003 LIKE glab_t.glab003, #分类码值
       glab004 LIKE glab_t.glab004, #科目参照表编号
       glab005 LIKE glab_t.glab005, #会计科目编号一
       glab006 LIKE glab_t.glab006, #会计科目编号二
       glab007 LIKE glab_t.glab007, #会计科目编号三
       glab008 LIKE glab_t.glab008, #会计科目编号四
       glab009 LIKE glab_t.glab009, #会计科目编号五
       glab010 LIKE glab_t.glab010, #其他设置值
       glab011 LIKE glab_t.glab011, #科目汇总方式
       glab012 LIKE glab_t.glab012, #会计科目编号六
       glab013 LIKE glab_t.glab013, #会计科目编号七
       glab014 LIKE glab_t.glab014, #代收银据点
       glab015 LIKE glab_t.glab015, #据点账套
       glab016 LIKE glab_t.glab016  #代收银收款科目(流通)
END RECORD
#161111-00028#6 -e by 08172
DEFINE l_sql     STRING
DEFINE l_success LIKE type_t.chr1


   SELECT glaa004
     INTO l_glab.glab004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_faal_m.faalld
      
   LET l_glab.glabent = g_enterprise
   LET l_glab.glabld  = g_faal_m.faalld
   LET l_glab.glab002 = g_faal_m.faal001
   LET l_glab.glab001 = '91'
   LET l_glab.glab005 = '' 
   LET l_glab.glab006 = ''
   LET l_glab.glab007 = ''
   LET l_glab.glab008 = ''
   LET l_glab.glab009 = ''
   LET l_glab.glab010 = ''
   LET l_glab.glab011 = '1'
   
   CALL s_transaction_begin()
   LET l_sql = " DELETE FROM glab_t WHERE glabent = '",g_enterprise,"'",
              "   AND glabld = '",g_faal_m.faalld,"' AND glab002 = '",g_faal_m.faal001,"' AND glab001 ='91'",
              "   AND glab003 NOT IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001 ='9901')" 
   PREPARE glab_del FROM l_sql
   EXECUTE glab_del
   
   LET l_success = 'Y'
   LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 ='9901' ",
               "   AND gzcb002 NOT IN (SELECT glab003 FROM glab_t WHERE glabent = '",g_enterprise,"'",
               "   AND glabld = '",g_faal_m.faalld,"' AND glab002 = '",g_faal_m.faal001,"' AND glab001 ='91')" 
   	PREPARE glab_ins_pre FROM l_sql
   	DECLARE glab_ins CURSOR FOR glab_ins_pre
   	FOREACH glab_ins INTO l_glab.glab003
   	  #161111-00028#6 -s by 08172
#   	   INSERT INTO glab_t VALUES l_glab.*
   	  INSERT INTO glab_t(glabent,glabld, glab001,glab002,glab003,glab004,
   	                     glab005,glab006,glab007,glab008,glab009,glab010,
   	                     glab011,glab012,glab013,glab014,glab015,glab016)
   	              VALUES(l_glab.glabent,l_glab.glabld, l_glab.glab001,l_glab.glab002,l_glab.glab003,l_glab.glab004,
   	                     l_glab.glab005,l_glab.glab006,l_glab.glab007,l_glab.glab008,l_glab.glab009,l_glab.glab010,
   	                     l_glab.glab011,l_glab.glab012,l_glab.glab013,l_glab.glab014,l_glab.glab015,l_glab.glab016)
  	     #161111-00028#6 -e by 08172
  	   IF SQLCA.SQLcode THEN
          LET l_success = 'N'
          EXIT FOREACH
       END IF     
   	END FOREACH
    IF l_success = 'N' THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "glab_t"
       LET g_errparam.popup = TRUE
       CALL cl_err()
  
       CALL s_transaction_end('N','0')                    
    ELSE
       CALL s_transaction_end('Y','0')
    END IF    
END FUNCTION
################################################################################
# Descriptions...: 複製時，若科目參照表不一致則不讓複製
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
PRIVATE FUNCTION afai021_glaald_chk()
DEFINE l_glaa004   LIKE glaa_t.glaa004
DEFINE l_glaa004_t LIKE glaa_t.glaa004
   SELECT glaa004 INTO l_glaa004_t FROM glaa_t WHERE glaaent=g_enterprise AND glaald = g_faalld_t
   SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald = g_faal_m.faalld
   IF l_glaa004_t != l_glaa004 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
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
PUBLIC FUNCTION afai021_init_glaa()
   LET g_faal_m.glaa014 = ''
   LET g_faal_m.glaa008 = ''
   LET g_faal_m.glaacomp = ''
   LET g_faal_m.glaacomp_desc = ''
   LET g_faal_m.glaa004 = ''
   LET g_faal_m.glaa004_desc = ''
   DISPLAY BY NAME g_faal_m.glaa014,g_faal_m.glaa008,g_faal_m.glaacomp,g_faal_m.glaacomp_desc,g_faal_m.glaa004,g_faal_m.glaa004_desc
 
END FUNCTION

 
{</section>}
 
