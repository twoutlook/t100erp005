#該程式未解開Section, 採用最新樣板產出!
{<section id="afaq150.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:21(2017-02-07 10:29:20), PR版次:0021(2017-02-08 10:22:26)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000151
#+ Filename...: afaq150
#+ Description: 資產在冊清單與標籤匯總查詢
#+ Creator....: 01531(2015-01-04 14:41:48)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="afaq150.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150827-00010#1   BY 02291    資產清單页签无法列印
#150908-00002#4   BY 06816    新增欄位-單位、改良或修理、本年度提列數   
#151105-00001#5   BY Jessy    保管人員+保管部門要有二次篩選功能
#151126-00013#8   BY sakura   新增欄位-資產淨值
#160318-00025#43  BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160505-00007#2   BY 02599    程式优化
#160426-00014#9   2016/07/22  BY 01531  查询增加列管与列帐
#160727-00019#1   2016/07/28  BY 08742  系统中定义的临时表名称超过15码在执行时会出错,所以将系统中定义的临时表长度超过15码的全部改掉
#160125-00005#7   2016/08/09  BY 01531  查詢時加上帳套人員權限條件過濾
#160818-00030#1   2016/08/22  BY 00768  修改160426-00014#9增加的faan009栏位，afaq150_tmp01临时表里没增加，导致报表列印不出资料（最后insert临时表时在 INSERT 的字段数量与 VALUES 的数量不符合.）
#160818-00045#1   2016/08/26  BY 02114  “清除条件”按钮不管用
#160922-00014#1   2016/09/22  BY 02114  afaq150单身不能QBE了
#161006-00005#22  2016/10/24  By 06137  組織類型與職能開窗清單需測試及調整開窗內容
#161024-00008#6   2016/10/28  By Hans   AFA組織類型與職能開窗清單調整。 
#161031-00007#1   2016/10/31  By 02114  查询月结档faan_t时，不必锁定资产中心，资产所属法人faancomp符合资产中心组织范围即可
#161111-00049#5   2016/11/16  By 01531  固资栏位过滤
#161205-00013#1   2016/12/05  By 02114  二次筛选时,可开窗的栏位增加开窗功能
#170207-00011#1   170207      By albireo 調整欄位順序符合公式計算順序
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_faai_d RECORD
       #statepic       LIKE type_t.chr1,
       
       ooef001 LIKE ooef_t.ooef001, 
   faan004 LIKE faan_t.faan004, 
   faan005 LIKE faan_t.faan005, 
   faan003 LIKE faan_t.faan003, 
   faah012 LIKE faah_t.faah012, 
   faah013 LIKE faah_t.faah013, 
   faah014 LIKE faah_t.faah014, 
   faah006 LIKE faah_t.faah006, 
   faah006_desc LIKE type_t.chr500, 
   faah007 LIKE faah_t.faah007, 
   faah007_desc LIKE type_t.chr500, 
   faan009 LIKE faan_t.faan009, 
   faan006 LIKE faan_t.faan006, 
   faan008 LIKE faan_t.faan008, 
   faan007 LIKE faan_t.faan007, 
   faah025 LIKE faah_t.faah025, 
   faah025_desc LIKE type_t.chr500, 
   faah026 LIKE faah_t.faah026, 
   faah026_desc LIKE type_t.chr500, 
   faah005 LIKE faah_t.faah005, 
   faah027 LIKE faah_t.faah027, 
   faah027_desc LIKE type_t.chr500, 
   faah028 LIKE faah_t.faah028, 
   faah028_desc LIKE type_t.chr500, 
   faah030 LIKE faah_t.faah030, 
   faah030_desc LIKE type_t.chr500, 
   faah031 LIKE faah_t.faah031, 
   faah031_desc LIKE type_t.chr500, 
   faah009 LIKE faah_t.faah009, 
   faah009_desc LIKE type_t.chr500, 
   faah038 LIKE faah_t.faah038, 
   faah022 LIKE faah_t.faah022, 
   faanld LIKE faan_t.faanld, 
   faan010 LIKE faan_t.faan010, 
   faaj006 LIKE faaj_t.faaj006, 
   faaj007 LIKE faaj_t.faaj007, 
   faaj007_desc LIKE type_t.chr500, 
   faaj003 LIKE faaj_t.faaj003, 
   faaj008 LIKE faaj_t.faaj008, 
   faan012 LIKE faan_t.faan012, 
   faan013 LIKE faan_t.faan013, 
   faan014 LIKE faan_t.faan014, 
   l_faaj020 LIKE type_t.num20_6, 
   faan018 LIKE faan_t.faan018, 
   faan015 LIKE faan_t.faan015, 
   faan020 LIKE faan_t.faan020, 
   l_faan015_faan020 LIKE type_t.num20_6, 
   faan019 LIKE faan_t.faan019, 
   faan016 LIKE faan_t.faan016, 
   faan017 LIKE faan_t.faan017, 
   sum1 LIKE type_t.num20_6, 
   sum2 LIKE type_t.num20_6, 
   sum3 LIKE type_t.num20_6, 
   sum4 LIKE type_t.num20_6, 
   faan100 LIKE faan_t.faan100, 
   faan102 LIKE faan_t.faan102, 
   faan103 LIKE faan_t.faan103, 
   faan104 LIKE faan_t.faan104, 
   faan105 LIKE faan_t.faan105, 
   faan106 LIKE faan_t.faan106, 
   faan107 LIKE faan_t.faan107, 
   faan108 LIKE faan_t.faan108, 
   faan200 LIKE faan_t.faan200, 
   faan202 LIKE faan_t.faan202, 
   faan203 LIKE faan_t.faan203, 
   faan204 LIKE faan_t.faan204, 
   faan205 LIKE faan_t.faan205, 
   faan206 LIKE faan_t.faan206, 
   faan207 LIKE faan_t.faan207, 
   faan208 LIKE faan_t.faan208, 
   faah046 LIKE faah_t.faah046, 
   l_faah017 LIKE type_t.chr10, 
   l_sum_faam013 LIKE type_t.num20_6 
       END RECORD
PRIVATE TYPE type_g_faai3_d RECORD
       ooef001 LIKE ooef_t.ooef001, 
   faan004 LIKE faan_t.faan004, 
   faan005 LIKE faan_t.faan005, 
   faan003 LIKE faan_t.faan003, 
   faaiseq LIKE faai_t.faaiseq, 
   faai004 LIKE faai_t.faai004, 
   faai012 LIKE faai_t.faai012, 
   faai013 LIKE faai_t.faai013, 
   faai005 LIKE faai_t.faai005, 
   faai006 LIKE faai_t.faai006, 
   faai007 LIKE faai_t.faai007, 
   faai008 LIKE faai_t.faai008, 
   faai014 LIKE faai_t.faai014, 
   faai015 LIKE faai_t.faai015, 
   faai016 LIKE faai_t.faai016, 
   faai017 LIKE faai_t.faai017, 
   faai023 LIKE faai_t.faai023
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master2   RECORD 
            faansite      LIKE faan_t.faansite,
            faansite_desc LIKE type_t.chr80,
            ooef001       LIKE ooef_t.ooef001,
            glaa014       LIKE glaa_t.glaa014,
            faan001       LIKE faan_t.faan001,
            faan002       LIKE faan_t.faan002
                   END RECORD 
DEFINE g_master2_t   RECORD 
            faansite      LIKE faan_t.faansite,
            faansite_desc LIKE type_t.chr80,
            ooef001       LIKE ooef_t.ooef001,
            glaa014       LIKE glaa_t.glaa014,
            faan001       LIKE faan_t.faan001,
            faan002       LIKE faan_t.faan002
                   END RECORD 
DEFINE g_glaald   LIKE glaa_t.glaald
DEFINE g_cnt2     LIKE type_t.num10 
DEFINE g_glaa015  LIKE glaa_t.glaa015
DEFINE g_glaa019  LIKE glaa_t.glaa019
DEFINE g_wc_cs_orga          STRING      #160125-00005#7
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_faai_d
DEFINE g_master_t                   type_g_faai_d
DEFINE g_faai_d          DYNAMIC ARRAY OF type_g_faai_d
DEFINE g_faai_d_t        type_g_faai_d
DEFINE g_faai3_d   DYNAMIC ARRAY OF type_g_faai3_d
DEFINE g_faai3_d_t type_g_faai3_d
 
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afaq150.main" >}
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
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afaq150_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afaq150_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afaq150_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afaq150 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afaq150_init()   
 
      #進入選單 Menu (="N")
      CALL afaq150_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afaq150
      
   END IF 
   
   CLOSE afaq150_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afaq150.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afaq150_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_faah005','9903') 
   CALL cl_set_combo_scc('b_faaj006','9912') 
   CALL cl_set_combo_scc('b_faaj003','9904') 
 
   
   #add-point:畫面資料初始化 name="init.init"
#   CALL cl_set_combo_scc('faah005','9903')  #160505-00007#2 mark
   CALL cl_set_combo_scc('b_faah005','9903')
   CALL cl_set_combo_scc('b_faan007','9914')
   CALL cl_set_combo_scc('b_faaj006','9912')
   CALL cl_set_combo_scc('b_faai023','9914')
   CALL cl_set_combo_scc('b_faaj003','9904')
   CALL afaq150_create_tmp()
   CALL s_fin_create_account_center_tmp()
   CALL cl_set_combo_scc('b_faan009','9897') #160426-00014#9
   #营运据点范围
   CALL s_axrt300_get_site(g_user,'','1') RETURNING g_wc_cs_orga #160125-00005#7     
   #end add-point
 
   CALL afaq150_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="afaq150.default_search" >}
PRIVATE FUNCTION afaq150_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " faaiseq = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq150.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afaq150_ui_dialog()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
 
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL afaq150_b_fill()
   ELSE
      CALL afaq150_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_faai_d.clear()
         CALL g_faai3_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL afaq150_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_faai_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL afaq150_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL afaq150_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_faai3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_faai3_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL afaq150_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #160505-00007#2--mod--str--
#               IF NOT cl_ask_confirm("afa-00459") THEN
#                  #按否列印匯總
#                  CALL afaq150_x02('1=1','afaq150_print_tmp2')
#               ELSE
#                  CALL afaq150_x01('1=1','afaq150_print_tmp1',g_glaa015,g_glaa019)
#               END IF
               CALL afaq150_output()
               #160505-00007#2--mod--end
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #160505-00007#2--mod--str--
#               IF NOT cl_ask_confirm("afa-00459") THEN
#                  #按否列印匯總
#                  CALL afaq150_x02('1=1','afaq150_print_tmp2')
#               ELSE
#                  CALL afaq150_x01('1=1','afaq150_print_tmp1',g_glaa015,g_glaa019)
#               END IF
               CALL afaq150_output()
               #160505-00007#2--mod--end
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afaq150_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afaq150_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL afaq150_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_faai_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_faai3_d)
               LET g_export_id[2]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL afaq150_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afaq150_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afaq150_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afaq150_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         
         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq150.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afaq150_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL afaq150_query_1()
   RETURN 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_faai_d.clear()
   CALL g_faai3_d.clear()
 
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON ooef001,faan004,faan005,faan003,faah006,faah007,faan009,faah025,faah026, 
          faah005,faah027,faah028,faah030,faah031,faah009,faah038,faanld,faan010
           FROM s_detail1[1].b_ooef001,s_detail1[1].b_faan004,s_detail1[1].b_faan005,s_detail1[1].b_faan003, 
               s_detail1[1].b_faah006,s_detail1[1].b_faah007,s_detail1[1].b_faan009,s_detail1[1].b_faah025, 
               s_detail1[1].b_faah026,s_detail1[1].b_faah005,s_detail1[1].b_faah027,s_detail1[1].b_faah028, 
               s_detail1[1].b_faah030,s_detail1[1].b_faah031,s_detail1[1].b_faah009,s_detail1[1].b_faah038, 
               s_detail1[1].b_faanld,s_detail1[1].b_faan010
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_ooef001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_ooef001
            #add-point:BEFORE FIELD b_ooef001 name="construct.b.page1.b_ooef001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_ooef001
            
            #add-point:AFTER FIELD b_ooef001 name="construct.a.page1.b_ooef001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_ooef001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ooef001
            #add-point:ON ACTION controlp INFIELD b_ooef001 name="construct.c.page1.b_ooef001"
            
            #END add-point
 
 
         #----<<b_faan004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faan004
            #add-point:BEFORE FIELD b_faan004 name="construct.b.page1.b_faan004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faan004
            
            #add-point:AFTER FIELD b_faan004 name="construct.a.page1.b_faan004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faan004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan004
            #add-point:ON ACTION controlp INFIELD b_faan004 name="construct.c.page1.b_faan004"
            
            #END add-point
 
 
         #----<<b_faan005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faan005
            #add-point:BEFORE FIELD b_faan005 name="construct.b.page1.b_faan005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faan005
            
            #add-point:AFTER FIELD b_faan005 name="construct.a.page1.b_faan005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faan005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan005
            #add-point:ON ACTION controlp INFIELD b_faan005 name="construct.c.page1.b_faan005"
            
            #END add-point
 
 
         #----<<b_faan003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faan003
            #add-point:BEFORE FIELD b_faan003 name="construct.b.page1.b_faan003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faan003
            
            #add-point:AFTER FIELD b_faan003 name="construct.a.page1.b_faan003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faan003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan003
            #add-point:ON ACTION controlp INFIELD b_faan003 name="construct.c.page1.b_faan003"
            
            #END add-point
 
 
         #----<<b_faah012>>----
         #----<<b_faah013>>----
         #----<<b_faah014>>----
         #----<<b_faah006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah006
            #add-point:BEFORE FIELD b_faah006 name="construct.b.page1.b_faah006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah006
            
            #add-point:AFTER FIELD b_faah006 name="construct.a.page1.b_faah006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah006
            #add-point:ON ACTION controlp INFIELD b_faah006 name="construct.c.page1.b_faah006"
            
            #END add-point
 
 
         #----<<b_faah006_desc>>----
         #----<<b_faah007>>----
         #Ctrlp:construct.c.page1.b_faah007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah007
            #add-point:ON ACTION controlp INFIELD b_faah007 name="construct.c.page1.b_faah007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah007  #顯示到畫面上
            NEXT FIELD b_faah007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah007
            #add-point:BEFORE FIELD b_faah007 name="construct.b.page1.b_faah007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah007
            
            #add-point:AFTER FIELD b_faah007 name="construct.a.page1.b_faah007"
            
            #END add-point
            
 
 
         #----<<b_faah007_desc>>----
         #----<<b_faan009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faan009
            #add-point:BEFORE FIELD b_faan009 name="construct.b.page1.b_faan009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faan009
            
            #add-point:AFTER FIELD b_faan009 name="construct.a.page1.b_faan009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faan009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan009
            #add-point:ON ACTION controlp INFIELD b_faan009 name="construct.c.page1.b_faan009"
            
            #END add-point
 
 
         #----<<b_faan006>>----
         #----<<b_faan008>>----
         #----<<b_faan007>>----
         #----<<b_faah025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah025
            #add-point:BEFORE FIELD b_faah025 name="construct.b.page1.b_faah025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah025
            
            #add-point:AFTER FIELD b_faah025 name="construct.a.page1.b_faah025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah025
            #add-point:ON ACTION controlp INFIELD b_faah025 name="construct.c.page1.b_faah025"
            
            #END add-point
 
 
         #----<<b_faah025_desc>>----
         #----<<b_faah026>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah026
            #add-point:BEFORE FIELD b_faah026 name="construct.b.page1.b_faah026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah026
            
            #add-point:AFTER FIELD b_faah026 name="construct.a.page1.b_faah026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah026
            #add-point:ON ACTION controlp INFIELD b_faah026 name="construct.c.page1.b_faah026"
            
            #END add-point
 
 
         #----<<b_faah026_desc>>----
         #----<<b_faah005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah005
            #add-point:BEFORE FIELD b_faah005 name="construct.b.page1.b_faah005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah005
            
            #add-point:AFTER FIELD b_faah005 name="construct.a.page1.b_faah005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah005
            #add-point:ON ACTION controlp INFIELD b_faah005 name="construct.c.page1.b_faah005"
            
            #END add-point
 
 
         #----<<b_faah027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah027
            #add-point:BEFORE FIELD b_faah027 name="construct.b.page1.b_faah027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah027
            
            #add-point:AFTER FIELD b_faah027 name="construct.a.page1.b_faah027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah027
            #add-point:ON ACTION controlp INFIELD b_faah027 name="construct.c.page1.b_faah027"
            
            #END add-point
 
 
         #----<<b_faah027_desc>>----
         #----<<b_faah028>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah028
            #add-point:BEFORE FIELD b_faah028 name="construct.b.page1.b_faah028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah028
            
            #add-point:AFTER FIELD b_faah028 name="construct.a.page1.b_faah028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah028
            #add-point:ON ACTION controlp INFIELD b_faah028 name="construct.c.page1.b_faah028"
            
            #END add-point
 
 
         #----<<b_faah028_desc>>----
         #----<<b_faah030>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah030
            #add-point:BEFORE FIELD b_faah030 name="construct.b.page1.b_faah030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah030
            
            #add-point:AFTER FIELD b_faah030 name="construct.a.page1.b_faah030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah030
            #add-point:ON ACTION controlp INFIELD b_faah030 name="construct.c.page1.b_faah030"
            
            #END add-point
 
 
         #----<<b_faah030_desc>>----
         #----<<b_faah031>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah031
            #add-point:BEFORE FIELD b_faah031 name="construct.b.page1.b_faah031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah031
            
            #add-point:AFTER FIELD b_faah031 name="construct.a.page1.b_faah031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah031
            #add-point:ON ACTION controlp INFIELD b_faah031 name="construct.c.page1.b_faah031"
            
            #END add-point
 
 
         #----<<b_faah031_desc>>----
         #----<<b_faah009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah009
            #add-point:BEFORE FIELD b_faah009 name="construct.b.page1.b_faah009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah009
            
            #add-point:AFTER FIELD b_faah009 name="construct.a.page1.b_faah009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah009
            #add-point:ON ACTION controlp INFIELD b_faah009 name="construct.c.page1.b_faah009"
            
            #END add-point
 
 
         #----<<b_faah009_desc>>----
         #----<<b_faah038>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faah038
            #add-point:BEFORE FIELD b_faah038 name="construct.b.page1.b_faah038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faah038
            
            #add-point:AFTER FIELD b_faah038 name="construct.a.page1.b_faah038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faah038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah038
            #add-point:ON ACTION controlp INFIELD b_faah038 name="construct.c.page1.b_faah038"
            
            #END add-point
 
 
         #----<<b_faah022>>----
         #----<<b_faanld>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faanld
            #add-point:BEFORE FIELD b_faanld name="construct.b.page1.b_faanld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faanld
            
            #add-point:AFTER FIELD b_faanld name="construct.a.page1.b_faanld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faanld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faanld
            #add-point:ON ACTION controlp INFIELD b_faanld name="construct.c.page1.b_faanld"
            
            #END add-point
 
 
         #----<<b_faan010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_faan010
            #add-point:BEFORE FIELD b_faan010 name="construct.b.page1.b_faan010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_faan010
            
            #add-point:AFTER FIELD b_faan010 name="construct.a.page1.b_faan010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_faan010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan010
            #add-point:ON ACTION controlp INFIELD b_faan010 name="construct.c.page1.b_faan010"
            
            #END add-point
 
 
         #----<<b_faaj006>>----
         #----<<b_faaj007>>----
         #----<<b_faaj007_desc>>----
         #----<<b_faaj003>>----
         #----<<b_faaj008>>----
         #----<<b_faan012>>----
         #----<<b_faan013>>----
         #----<<b_faan014>>----
         #----<<l_faaj020>>----
         #----<<b_faan018>>----
         #----<<b_faan015>>----
         #----<<b_faan020>>----
         #----<<l_faan015_faan020>>----
         #----<<b_faan019>>----
         #----<<b_faan016>>----
         #----<<b_faan017>>----
         #----<<sum1>>----
         #----<<sum2>>----
         #----<<sum3>>----
         #----<<sum4>>----
         #----<<b_faan100>>----
         #----<<b_faan102>>----
         #----<<b_faan103>>----
         #----<<b_faan104>>----
         #----<<b_faan105>>----
         #----<<b_faan106>>----
         #----<<b_faan107>>----
         #----<<b_faan108>>----
         #----<<b_faan200>>----
         #----<<b_faan202>>----
         #----<<b_faan203>>----
         #----<<b_faan204>>----
         #----<<b_faan205>>----
         #----<<b_faan206>>----
         #----<<b_faan207>>----
         #----<<b_faan208>>----
         #----<<b_faah046>>----
         #----<<l_faah017>>----
         #----<<l_sum_faam013>>----
         #----<<b_ooef001_2>>----
         #----<<b_faai004>>----
         #----<<b_faai012>>----
         #----<<b_faai013>>----
         #----<<b_faai005>>----
         #----<<b_faai006>>----
         #----<<b_faai007>>----
         #----<<b_faai008>>----
         #----<<b_faai014>>----
         #----<<b_faai015>>----
         #----<<b_faai016>>----
         #----<<b_faai017>>----
         #----<<b_faai023>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         
         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"
      
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL afaq150_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="afaq150.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afaq150_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL afaq150_b2_fill()
   RETURN 
   #end add-point
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','',faai004,faai012, 
       faai013,faai005,faai006,faai007,faai008,faai014,faai015,faai016,faai017,faai023  ,DENSE_RANK() OVER( ORDER BY faai_t.faaiseq) AS RANK FROM faai_t", 
 
 
 
                     "",
                     " WHERE faaient=? AND faai000=? AND faai001=? AND faai002=? AND faai003=? AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("faai_t"),
                     " ORDER BY faai_t.faaiseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','',faai004,faai012,faai013,faai005, 
       faai006,faai007,faai008,faai014,faai015,faai016,faai017,faai023",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afaq150_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afaq150_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_faai_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_faai_d[l_ac].ooef001,g_faai_d[l_ac].faan004,g_faai_d[l_ac].faan005,g_faai_d[l_ac].faan003, 
       g_faai_d[l_ac].faah012,g_faai_d[l_ac].faah013,g_faai_d[l_ac].faah014,g_faai_d[l_ac].faah006,g_faai_d[l_ac].faah006_desc, 
       g_faai_d[l_ac].faah007,g_faai_d[l_ac].faah007_desc,g_faai_d[l_ac].faan009,g_faai_d[l_ac].faan006, 
       g_faai_d[l_ac].faan008,g_faai_d[l_ac].faan007,g_faai_d[l_ac].faah025,g_faai_d[l_ac].faah025_desc, 
       g_faai_d[l_ac].faah026,g_faai_d[l_ac].faah026_desc,g_faai_d[l_ac].faah005,g_faai_d[l_ac].faah027, 
       g_faai_d[l_ac].faah027_desc,g_faai_d[l_ac].faah028,g_faai_d[l_ac].faah028_desc,g_faai_d[l_ac].faah030, 
       g_faai_d[l_ac].faah030_desc,g_faai_d[l_ac].faah031,g_faai_d[l_ac].faah031_desc,g_faai_d[l_ac].faah009, 
       g_faai_d[l_ac].faah009_desc,g_faai_d[l_ac].faah038,g_faai_d[l_ac].faah022,g_faai_d[l_ac].faanld, 
       g_faai_d[l_ac].faan010,g_faai_d[l_ac].faaj006,g_faai_d[l_ac].faaj007,g_faai_d[l_ac].faaj007_desc, 
       g_faai_d[l_ac].faaj003,g_faai_d[l_ac].faaj008,g_faai_d[l_ac].faan012,g_faai_d[l_ac].faan013,g_faai_d[l_ac].faan014, 
       g_faai_d[l_ac].l_faaj020,g_faai_d[l_ac].faan018,g_faai_d[l_ac].faan015,g_faai_d[l_ac].faan020, 
       g_faai_d[l_ac].l_faan015_faan020,g_faai_d[l_ac].faan019,g_faai_d[l_ac].faan016,g_faai_d[l_ac].faan017, 
       g_faai_d[l_ac].sum1,g_faai_d[l_ac].sum2,g_faai_d[l_ac].sum3,g_faai_d[l_ac].sum4,g_faai_d[l_ac].faan100, 
       g_faai_d[l_ac].faan102,g_faai_d[l_ac].faan103,g_faai_d[l_ac].faan104,g_faai_d[l_ac].faan105,g_faai_d[l_ac].faan106, 
       g_faai_d[l_ac].faan107,g_faai_d[l_ac].faan108,g_faai_d[l_ac].faan200,g_faai_d[l_ac].faan202,g_faai_d[l_ac].faan203, 
       g_faai_d[l_ac].faan204,g_faai_d[l_ac].faan205,g_faai_d[l_ac].faan206,g_faai_d[l_ac].faan207,g_faai_d[l_ac].faan208, 
       g_faai_d[l_ac].faah046,g_faai_d[l_ac].l_faah017,g_faai_d[l_ac].l_sum_faam013,g_faai3_d[l_ac].ooef001, 
       g_faai3_d[l_ac].faan004,g_faai3_d[l_ac].faan005,g_faai3_d[l_ac].faan003,g_faai3_d[l_ac].faaiseq, 
       g_faai3_d[l_ac].faai004,g_faai3_d[l_ac].faai012,g_faai3_d[l_ac].faai013,g_faai3_d[l_ac].faai005, 
       g_faai3_d[l_ac].faai006,g_faai3_d[l_ac].faai007,g_faai3_d[l_ac].faai008,g_faai3_d[l_ac].faai014, 
       g_faai3_d[l_ac].faai015,g_faai3_d[l_ac].faai016,g_faai3_d[l_ac].faai017,g_faai3_d[l_ac].faai023 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_faai_d[l_ac].statepic = cl_get_actipic(g_faai_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL afaq150_detail_show("'1'")      
 
      CALL afaq150_faai_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_faai_d.deleteElement(g_faai_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_faai_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afaq150_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afaq150_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afaq150_detail_action_trans()
 
   IF g_faai_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL afaq150_fetch()
   END IF
   
      CALL afaq150_filter_show('ooef001','b_ooef001')
   CALL afaq150_filter_show('faan004','b_faan004')
   CALL afaq150_filter_show('faan005','b_faan005')
   CALL afaq150_filter_show('faan003','b_faan003')
   CALL afaq150_filter_show('faah006','b_faah006')
   CALL afaq150_filter_show('faah007','b_faah007')
   CALL afaq150_filter_show('faan009','b_faan009')
   CALL afaq150_filter_show('faah025','b_faah025')
   CALL afaq150_filter_show('faah026','b_faah026')
   CALL afaq150_filter_show('faah005','b_faah005')
   CALL afaq150_filter_show('faah027','b_faah027')
   CALL afaq150_filter_show('faah028','b_faah028')
   CALL afaq150_filter_show('faah030','b_faah030')
   CALL afaq150_filter_show('faah031','b_faah031')
   CALL afaq150_filter_show('faah009','b_faah009')
   CALL afaq150_filter_show('faah038','b_faah038')
   CALL afaq150_filter_show('faanld','b_faanld')
   CALL afaq150_filter_show('faan010','b_faan010')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq150.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afaq150_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_glaa015   LIKE glaa_t.glaa015
   DEFINE l_glaa019   LIKE glaa_t.glaa019
   DEFINE l_faansite_desc LIKE type_t.chr500
   DEFINE l_faai023_desc  LIKE type_t.chr500
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   CALL g_faai3_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"
#160505-00007#2--mark--str--  
#   DELETE FROM afaq150_print_tmp2
#   LET l_faansite_desc = g_master2.faansite,"    ",g_master2.faansite_desc
#160505-00007#2--mark--end
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"

#   LET g_sql = "SELECT  UNIQUE faan004,faan005,faan003,faanld,faan010,faan012,faan013,faan014,",
#               "               faan015,faan016,faan017,faan018,faan019,faan020,faan100,faan102,faan103,faan104,faan105,",
#               "               faan106,faan107,faan108,faan200,faan202,faan203,faan204,faan205,faan206,faan207,faan208 ",
#               "  FROM faan_t,faah_t,faaj_t ",
#               " WHERE faanent = faahent ",
#               "   AND faan004 = faah003 ",
#               "   AND faan005 = faah004 ",
#               "   AND faan003 = faah001 ",
#               "   AND faanent = faajent ",
#               "   AND faan004 = faaj001 ",
#               "   AND faan005 = faaj002 ",
#               "   AND faan003 = faaj037 ",
#               "   AND faanld = faajld ",
#               "   AND faajld <> '",g_glaald,"'",
#               "   AND faanent = '",g_enterprise,"'",
#               "   AND faan001 = '",g_master2.faan001,"'",
#               "   AND faan002 = '",g_master2.faan002,"'",
#               "   AND faansite = '",g_master2.faansite,"'",
#               "   AND faancomp = '",g_master2.ooef001,"'",
#               "   AND ",g_wc CLIPPED, 
#               " ORDER BY faan004,faan005,faan003 "
#   PREPARE afaq150_pb3 FROM g_sql
#   DECLARE b_fill_curs3 CURSOR FOR afaq150_pb3
#   CALL g_faai2_d.clear()
#   LET g_cnt = 1
#   CALL cl_set_comp_visible("b_faan100_2,b_faan102_2,b_faan103_2,b_faan104_2,b_faan105_2,b_faan106_2,b_faan107_2,b_faan108_2",FALSE)
#   CALL cl_set_comp_visible("b_faan200_2,b_faan202_2,b_faan203_2,b_faan204_2,b_faan205_2,b_faan206_2,b_faan207_2,b_faan208_2",FALSE)
#   FOREACH b_fill_curs3 INTO g_faai2_d[g_cnt].*
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
#      SELECT glaa015,glaa019
#        INTO l_glaa015,l_glaa019
#        FROM glaa_t
#       WHERE glaald = g_faai2_d[g_cnt].faanld
#         AND glaaent = g_enterprise
#      IF l_glaa015 = 'Y' THEN 
#         CALL cl_set_comp_visible("b_faan100_2,b_faan102_2,b_faan103_2,b_faan104_2,b_faan105_2,b_faan106_2,b_faan107_2,b_faan108_2",TRUE)
#      END IF 
#      IF l_glaa019 = 'Y' THEN 
#         CALL cl_set_comp_visible("b_faan200_2,b_faan202_2,b_faan203_2,b_faan204_2,b_faan205_2,b_faan206_2,b_faan207_2,b_faan208_2",TRUE)
#      END IF
#      IF l_ac > g_max_rec THEN
#         IF g_error_show = 1 THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend =  "" 
#            LET g_errparam.code   =  9035 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#         END IF
#         EXIT FOREACH
#      END IF
#      LET g_cnt = g_cnt + 1
#      
#   END FOREACH
   
   LET g_sql = "SELECT  UNIQUE ooef001,faan004,faan005,faan003,faaiseq,faai004,faai012,faai013,faai005,faai006,faai007,faai008,faai014,faai015,faai016,faai017,faai023 ",
               "  FROM faan_t,faah_t,faai_t,ooef_t,glaa_t ",
               " WHERE faanent = faaient ",
               "   AND faan004 = faai002 ",
               "   AND faan005 = faai003 ",
               "   AND faan003 = faai001 ",
               "   AND faanent = faahent ",
               "   AND faan004 = faah003 ",
               "   AND faan005 = faah004 ",
               "   AND faan003 = faah001 ", 
               "   AND faancomp = ooef001 ",
               "   AND ooef003 = 'Y' ",
               "   AND faanld = glaald ",
               "   AND faanent = '",g_enterprise,"'",
               "   AND faan001 = '",g_master2.faan001,"'",
               "   AND faan002 = '",g_master2.faan002,"'",
               "   AND faansite = '",g_master2.faansite,"'",
               "   AND ",g_wc CLIPPED
   IF g_master2.glaa014 = 'Y' THEN 
      LET g_sql = g_sql,"   AND glaa014 = '",g_master2.glaa014,"'",
                        " ORDER BY ooef001,faan004,faan005,faan003,faaiseq "
   ELSE 
      LET g_sql = g_sql," ORDER BY ooef001,faan004,faan005,faan003,faaiseq "
   END IF 
   PREPARE afaq150_pb4 FROM g_sql
   DECLARE b_fill_curs4 CURSOR FOR afaq150_pb4
   CALL g_faai3_d.clear()
   LET g_cnt2 = 1
   FOREACH b_fill_curs4 INTO g_faai3_d[g_cnt2].*
      
#      LET l_faai023_desc = g_faai3_d[g_cnt2].faai023,":",s_desc_gzcbl004_desc('9914',g_faai3_d[g_cnt2].faai023) #160505-00007#2 mark
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
#160505-00007#2--mark--str--
#      #XG用
#      INSERT INTO afaq150_print_tmp2 VALUES(l_faansite_desc,g_master2.faan001,g_master2.faan002,
#      g_faai3_d[g_cnt2].ooef001,g_faai3_d[g_cnt2].faan004,g_faai3_d[g_cnt2].faan005,g_faai3_d[g_cnt2].faan003, 
#      g_faai3_d[g_cnt2].faaiseq,g_faai3_d[g_cnt2].faai004,g_faai3_d[g_cnt2].faai012,g_faai3_d[g_cnt2].faai013, 
#      g_faai3_d[g_cnt2].faai005,g_faai3_d[g_cnt2].faai006,g_faai3_d[g_cnt2].faai007,g_faai3_d[g_cnt2].faai008, 
#      g_faai3_d[g_cnt2].faai014,g_faai3_d[g_cnt2].faai015,g_faai3_d[g_cnt2].faai016,g_faai3_d[g_cnt2].faai017,
#      l_faai023_desc)
#160505-00007#2--mark--end      
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET g_cnt2 = g_cnt2 + 1
      
   END FOREACH
   #end add-point 
   
   CALL g_faai3_d.deleteElement(g_faai3_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_faai3_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="afaq150.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afaq150_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
 
      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq150.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afaq150_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   #161205-00013#1--add--str--lujh
   DEFINE l_origin_str  STRING     
   DEFINE l_ld_str      STRING
   #161205-00013#1--add--end--lujh
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON ooef001,faan004,faan005,faan003,faah006,faah007,faan009,faah025,faah026, 
          faah005,faah027,faah028,faah030,faah031,faah009,faah038,faanld,faan010
                          FROM s_detail1[1].b_ooef001,s_detail1[1].b_faan004,s_detail1[1].b_faan005, 
                              s_detail1[1].b_faan003,s_detail1[1].b_faah006,s_detail1[1].b_faah007,s_detail1[1].b_faan009, 
                              s_detail1[1].b_faah025,s_detail1[1].b_faah026,s_detail1[1].b_faah005,s_detail1[1].b_faah027, 
                              s_detail1[1].b_faah028,s_detail1[1].b_faah030,s_detail1[1].b_faah031,s_detail1[1].b_faah009, 
                              s_detail1[1].b_faah038,s_detail1[1].b_faanld,s_detail1[1].b_faan010
 
         BEFORE CONSTRUCT
                     DISPLAY afaq150_filter_parser('ooef001') TO s_detail1[1].b_ooef001
            DISPLAY afaq150_filter_parser('faan004') TO s_detail1[1].b_faan004
            DISPLAY afaq150_filter_parser('faan005') TO s_detail1[1].b_faan005
            DISPLAY afaq150_filter_parser('faan003') TO s_detail1[1].b_faan003
            DISPLAY afaq150_filter_parser('faah006') TO s_detail1[1].b_faah006
            DISPLAY afaq150_filter_parser('faah007') TO s_detail1[1].b_faah007
            DISPLAY afaq150_filter_parser('faan009') TO s_detail1[1].b_faan009
            DISPLAY afaq150_filter_parser('faah025') TO s_detail1[1].b_faah025
            DISPLAY afaq150_filter_parser('faah026') TO s_detail1[1].b_faah026
            DISPLAY afaq150_filter_parser('faah005') TO s_detail1[1].b_faah005
            DISPLAY afaq150_filter_parser('faah027') TO s_detail1[1].b_faah027
            DISPLAY afaq150_filter_parser('faah028') TO s_detail1[1].b_faah028
            DISPLAY afaq150_filter_parser('faah030') TO s_detail1[1].b_faah030
            DISPLAY afaq150_filter_parser('faah031') TO s_detail1[1].b_faah031
            DISPLAY afaq150_filter_parser('faah009') TO s_detail1[1].b_faah009
            DISPLAY afaq150_filter_parser('faah038') TO s_detail1[1].b_faah038
            DISPLAY afaq150_filter_parser('faanld') TO s_detail1[1].b_faanld
            DISPLAY afaq150_filter_parser('faan010') TO s_detail1[1].b_faan010
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_ooef001>>----
         #Ctrlp:construct.c.filter.page1.b_ooef001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_ooef001
            #add-point:ON ACTION controlp INFIELD b_ooef001 name="construct.c.filter.page1.b_ooef001"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	         LET g_qryparam.reqry = FALSE
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN(",l_origin_str CLIPPED,") "  	        
	         CALL q_ooef001_2()
            DISPLAY g_qryparam.return1 TO b_ooef001             #顯示到畫面上
            NEXT FIELD b_ooef001                                #返回原欄位 
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faan004>>----
         #Ctrlp:construct.c.filter.page1.b_faan004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan004
            #add-point:ON ACTION controlp INFIELD b_faan004 name="construct.c.filter.page1.b_faan004"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "	             
            CALL q_faah003()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faan004  #顯示到畫面上
            NEXT FIELD b_faan004                     #返回原欄位
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faan005>>----
         #Ctrlp:construct.c.filter.page1.b_faan005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan005
            #add-point:ON ACTION controlp INFIELD b_faan005 name="construct.c.filter.page1.b_faan005"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL                                            
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "	           
            CALL q_faah004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faan005      #顯示到畫面上
            NEXT FIELD b_faan005   
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faan003>>----
         #Ctrlp:construct.c.filter.page1.b_faan003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan003
            #add-point:ON ACTION controlp INFIELD b_faan003 name="construct.c.filter.page1.b_faan003"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "	           
            CALL q_faah001()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faan003      #顯示到畫面上
            NEXT FIELD b_faan003                         #返回原欄位    
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faah012>>----
         #----<<b_faah013>>----
         #----<<b_faah014>>----
         #----<<b_faah006>>----
         #Ctrlp:construct.c.filter.page1.b_faah006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah006
            #add-point:ON ACTION controlp INFIELD b_faah006 name="construct.c.filter.page1.b_faah006"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " faalld IN (SELECT glaald FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaacomp IN(",l_origin_str CLIPPED,") )"
            CALL q_faal001_1()             
            DISPLAY g_qryparam.return1 TO b_faah006      #顯示到畫面上
            NEXT FIELD b_faah006                         #返回原欄位
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faah006_desc>>----
         #----<<b_faah007>>----
         #Ctrlp:construct.c.page1.b_faah007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah007
            #add-point:ON ACTION controlp INFIELD b_faah007 name="construct.c.filter.page1.b_faah007"
            #161205-00013#1--mark--str--lujh
            ##應用 a08 樣板自動產生(Version:2)
            ##開窗c段
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #CALL q_faad001()                         #呼叫開窗
            #DISPLAY g_qryparam.return1 TO b_faah007  #顯示到畫面上
            #NEXT FIELD b_faah007                     #返回原欄位
            #161205-00013#1--mark--end--lujh
    
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE	
			   CALL s_axrt300_get_site(g_user,g_master2.faansite,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")				   
			   LET g_qryparam.where = " faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND ",l_ld_str,")"
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND faalld IN (SELECT glaald FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaacomp IN(",l_origin_str CLIPPED,") ))"			   	   
            CALL q_faad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah007    #顯示到畫面上
            NEXT FIELD b_faah007                       #返回原欄位
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faah007_desc>>----
         #----<<b_faan009>>----
         #Ctrlp:construct.c.filter.page1.b_faan009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan009
            #add-point:ON ACTION controlp INFIELD b_faan009 name="construct.c.filter.page1.b_faan009"
            
            #END add-point
 
 
         #----<<b_faan006>>----
         #----<<b_faan008>>----
         #----<<b_faan007>>----
         #----<<b_faah025>>----
         #Ctrlp:construct.c.filter.page1.b_faah025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah025
            #add-point:ON ACTION controlp INFIELD b_faah025 name="construct.c.filter.page1.b_faah025"
            #151105-00001#5 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah025      #顯示到畫面上
            NEXT FIELD b_faah025                         #返回原欄位
            #151105-00001#5 --e
            #END add-point
 
 
         #----<<b_faah025_desc>>----
         #----<<b_faah026>>----
         #Ctrlp:construct.c.filter.page1.b_faah026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah026
            #add-point:ON ACTION controlp INFIELD b_faah026 name="construct.c.filter.page1.b_faah026"
            #151105-00001#5 --s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah026    #顯示到畫面上
            NEXT FIELD b_faah026 
            #151105-00001#5 --e
            #END add-point
 
 
         #----<<b_faah026_desc>>----
         #----<<b_faah005>>----
         #Ctrlp:construct.c.filter.page1.b_faah005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah005
            #add-point:ON ACTION controlp INFIELD b_faah005 name="construct.c.filter.page1.b_faah005"
            
            #END add-point
 
 
         #----<<b_faah027>>----
         #Ctrlp:construct.c.filter.page1.b_faah027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah027
            #add-point:ON ACTION controlp INFIELD b_faah027 name="construct.c.filter.page1.b_faah027"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3900'
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = "( oocq004 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 IN (",l_origin_str,")) OR oocq004 IS NULL)"  		        
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah027  #顯示到畫面上
            NEXT FIELD b_faah027                     #返回原欄位
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faah027_desc>>----
         #----<<b_faah028>>----
         #Ctrlp:construct.c.filter.page1.b_faah028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah028
            #add-point:ON ACTION controlp INFIELD b_faah028 name="construct.c.filter.page1.b_faah028"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " ooef017 IN(",l_origin_str CLIPPED,") "           
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah028  #顯示到畫面上
            NEXT FIELD b_faah028                     #返回原欄位
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faah028_desc>>----
         #----<<b_faah030>>----
         #Ctrlp:construct.c.filter.page1.b_faah030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah030
            #add-point:ON ACTION controlp INFIELD b_faah030 name="construct.c.filter.page1.b_faah030"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef207 = 'Y' "   
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = g_qryparam.where," AND ooef017 IN(",l_origin_str CLIPPED,") "        
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah030  #顯示到畫面上
            NEXT FIELD b_faah030                     #返回原欄位
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faah030_desc>>----
         #----<<b_faah031>>----
         #Ctrlp:construct.c.filter.page1.b_faah031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah031
            #add-point:ON ACTION controlp INFIELD b_faah031 name="construct.c.filter.page1.b_faah031"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef204 = 'Y' "
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = g_qryparam.where," AND ooef017 IN(",l_origin_str CLIPPED,") "            
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO b_faah031  #顯示到畫面上
            NEXT FIELD b_faah031                     #返回原欄位返回原欄位
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faah031_desc>>----
         #----<<b_faah009>>----
         #Ctrlp:construct.c.filter.page1.b_faah009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah009
            #add-point:ON ACTION controlp INFIELD b_faah009 name="construct.c.filter.page1.b_faah009"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite IN (",l_origin_str,")) "
            CALL q_pmaa001_1()                         
            DISPLAY g_qryparam.return1 TO b_faah009    #顯示到畫面上
            NEXT FIELD b_faah009                       #返回原欄位
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faah009_desc>>----
         #----<<b_faah038>>----
         #Ctrlp:construct.c.filter.page1.b_faah038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faah038
            #add-point:ON ACTION controlp INFIELD b_faah038 name="construct.c.filter.page1.b_faah038"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmdldocno()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah038    #顯示到畫面上
            NEXT FIELD b_faah038                       #返回原欄位
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faah022>>----
         #----<<b_faanld>>----
         #Ctrlp:construct.c.filter.page1.b_faanld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faanld
            #add-point:ON ACTION controlp INFIELD b_faanld name="construct.c.filter.page1.b_faanld"
            #161205-00013#1--add--str--lujh
            CALL s_fin_create_account_center_tmp()   
            #取得资产組織下所屬成員
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str
            LET l_origin_str=l_origin_str.substring(3,l_origin_str.getLength()-2)
            CALL s_axrt300_get_site(g_user,l_origin_str,'2') RETURNING l_ld_str 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')"
            CALL q_authorised_ld()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faanld     #顯示到畫面上
            NEXT FIELD b_faanld                        #返回原欄位
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faan010>>----
         #Ctrlp:construct.c.filter.page1.b_faan010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_faan010
            #add-point:ON ACTION controlp INFIELD b_faan010 name="construct.c.filter.page1.b_faan010"
            #161205-00013#1--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faan010    #顯示到畫面上
            NEXT FIELD b_faan010                       #返回原欄位
            #161205-00013#1--add--end--lujh
            #END add-point
 
 
         #----<<b_faaj006>>----
         #----<<b_faaj007>>----
         #----<<b_faaj007_desc>>----
         #----<<b_faaj003>>----
         #----<<b_faaj008>>----
         #----<<b_faan012>>----
         #----<<b_faan013>>----
         #----<<b_faan014>>----
         #----<<l_faaj020>>----
         #----<<b_faan018>>----
         #----<<b_faan015>>----
         #----<<b_faan020>>----
         #----<<l_faan015_faan020>>----
         #----<<b_faan019>>----
         #----<<b_faan016>>----
         #----<<b_faan017>>----
         #----<<sum1>>----
         #----<<sum2>>----
         #----<<sum3>>----
         #----<<sum4>>----
         #----<<b_faan100>>----
         #----<<b_faan102>>----
         #----<<b_faan103>>----
         #----<<b_faan104>>----
         #----<<b_faan105>>----
         #----<<b_faan106>>----
         #----<<b_faan107>>----
         #----<<b_faan108>>----
         #----<<b_faan200>>----
         #----<<b_faan202>>----
         #----<<b_faan203>>----
         #----<<b_faan204>>----
         #----<<b_faan205>>----
         #----<<b_faan206>>----
         #----<<b_faan207>>----
         #----<<b_faan208>>----
         #----<<b_faah046>>----
         #----<<l_faah017>>----
         #----<<l_sum_faam013>>----
         #----<<b_ooef001_2>>----
         #----<<b_faai004>>----
         #----<<b_faai012>>----
         #----<<b_faai013>>----
         #----<<b_faai005>>----
         #----<<b_faai006>>----
         #----<<b_faai007>>----
         #----<<b_faai008>>----
         #----<<b_faai014>>----
         #----<<b_faai015>>----
         #----<<b_faai016>>----
         #----<<b_faai017>>----
         #----<<b_faai023>>----
   
 
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
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL afaq150_filter_show('ooef001','b_ooef001')
   CALL afaq150_filter_show('faan004','b_faan004')
   CALL afaq150_filter_show('faan005','b_faan005')
   CALL afaq150_filter_show('faan003','b_faan003')
   CALL afaq150_filter_show('faah006','b_faah006')
   CALL afaq150_filter_show('faah007','b_faah007')
   CALL afaq150_filter_show('faan009','b_faan009')
   CALL afaq150_filter_show('faah025','b_faah025')
   CALL afaq150_filter_show('faah026','b_faah026')
   CALL afaq150_filter_show('faah005','b_faah005')
   CALL afaq150_filter_show('faah027','b_faah027')
   CALL afaq150_filter_show('faah028','b_faah028')
   CALL afaq150_filter_show('faah030','b_faah030')
   CALL afaq150_filter_show('faah031','b_faah031')
   CALL afaq150_filter_show('faah009','b_faah009')
   CALL afaq150_filter_show('faah038','b_faah038')
   CALL afaq150_filter_show('faanld','b_faanld')
   CALL afaq150_filter_show('faan010','b_faan010')
 
    
   CALL afaq150_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq150.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afaq150_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
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
 
{<section id="afaq150.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afaq150_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = afaq150_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq150.insert" >}
#+ insert
PRIVATE FUNCTION afaq150_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afaq150.modify" >}
#+ modify
PRIVATE FUNCTION afaq150_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq150.reproduce" >}
#+ reproduce
PRIVATE FUNCTION afaq150_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq150.delete" >}
#+ delete
PRIVATE FUNCTION afaq150_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afaq150.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afaq150_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="afaq150.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afaq150_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="deatil_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_faai_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_faai_d.getLength() AND g_faai_d.getLength() > 0
            LET g_detail_idx = g_faai_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_faai_d.getLength() THEN
               LET g_detail_idx = g_faai_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afaq150.mask_functions" >}
 &include "erp/afa/afaq150_mask.4gl"
 
{</section>}
 
{<section id="afaq150.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢條件設定
# Memo...........:
# Usage..........: CALL afaq150_query_1()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq150_query_1()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   DEFINE l_origin_str  STRING
   DEFINE l_ld_str      STRING   #160922-00014#1 add lujh
   DEFINE l_comp_str    STRING   #161111-00049#5
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_faai_d.clear()
   CALL g_faai3_d.clear()
   LET g_wc_filter = " 1=1"
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
   INITIALIZE g_master2.* TO NULL 
   INITIALIZE g_master2_t.* TO NULL 
   #160818-00045#1--mark--str--lujh
   ##預設值
   #LET g_master2.faansite = g_site 
   #CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_master2.ooef001,g_glaald
   #CALL s_fin_account_center_with_ld_chk(g_site,g_glaald,g_user,'5','N','',g_today) RETURNING g_sub_success,g_errno
   #IF NOT g_sub_success THEN 
   #   LET g_master2.ooef001 = ''
   #   LET g_glaald = ''
   #END IF
   #LET g_master2.glaa014 = 'Y'
   #CALL cl_get_para(g_enterprise,g_master2.ooef001,'S-FIN-9018') RETURNING g_master2.faan001
   #CALL cl_get_para(g_enterprise,g_master2.ooef001,'S-FIN-9019') RETURNING g_master2.faan002
   #LET g_master2_t.* = g_master2.*
   #160818-00045#1--mark--end--lujh
   CALL afaq150_qbeclear()    #160818-00045#1 add lujh
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      INPUT BY NAME g_master2.faansite,g_master2.glaa014,g_master2.faan001,g_master2.faan002
       ATTRIBUTE(WITHOUT DEFAULTS)
      
         BEFORE INPUT    
            CALL afaq150_get_faansite_desc()
            CALL afaq150_get_ooef001_desc()
            DISPLAY BY NAME g_master2.faansite,g_master2.faansite_desc,g_master2.glaa014,
                            g_master2.faan001,g_master2.faan002
      
         AFTER FIELD faansite
            IF NOT cl_null(g_master2.faansite) THEN 
                #检查组织资料的合理性
               IF NOT s_afat502_site_chk(g_master2.faansite) THEN
                  LET g_master2.faansite = g_master2_t.faansite
                  CALL afaq150_get_faansite_desc()
                  DISPLAY BY NAME g_master2.faansite
                  NEXT FIELD CURRENT
               END IF
               #user需要檢查和資產中心的權限
               IF NOT s_afat502_site_user_chk(g_master2.faansite,g_user) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master2.faansite
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_master2.faansite = g_master2_t.faansite
                  CALL afaq150_get_faansite_desc()
                  DISPLAY BY NAME g_master2.faansite
                  NEXT FIELD CURRENT  
               END IF 
               CALL afaq150_get_faansite_desc()
            ELSE
               CALL afaq150_get_faansite_desc()
               DISPLAY BY NAME g_master2.faansite
            END IF 
            CALL s_fin_orga_get_comp_ld(g_master2_t.faansite) RETURNING g_sub_success,g_errno,g_master2.ooef001,g_glaald

#         AFTER FIELD ooef001
#            IF NOT cl_null(g_master2.ooef001) THEN
#               INITIALIZE g_chkparam.* TO NULL
#               LET g_chkparam.arg1 = g_master2.ooef001
#               IF cl_chk_exist("v_ooef001_7") THEN
#               ELSE
#                  LET g_master2.ooef001 = g_master2_t.ooef001
#                  CALL afaq150_get_ooef001_desc()
#                  DISPLAY BY NAME g_master2.ooef001,g_master2.ooef001_desc
#                  NEXT FIELD CURRENT
#               END IF 
#               IF NOT cl_null(g_master2.faansite) THEN 
#                  IF NOT afaq150_site_comp_chk(g_master2.faansite,g_master2.ooef001) THEN 
#                     LET g_master2.ooef001 = g_master2_t.ooef001
#                     CALL afaq150_get_ooef001_desc()
#                     DISPLAY BY NAME g_master2.ooef001,g_master2.ooef001_desc
#                     NEXT FIELD CURRENT
#                  END IF 
#               END IF 
#               #获取主帐套
#               CALL afaq150_glaald_get()
#            END IF
#            CALL afaq150_get_ooef001_desc()
     
#          ON ACTION controlp INFIELD ooef001
#	          INITIALIZE g_qryparam.* TO NULL
#             LET g_qryparam.state = 'i'
#	          LET g_qryparam.reqry = FALSE
#             LET g_qryparam.default1 = g_master2.ooef001      #給予default值
#             IF NOT cl_null(g_master2.faansite) THEN 
#                CALL s_fin_create_account_center_tmp()
#                CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
#                CALL s_fin_account_center_comp_str()RETURNING l_origin_str
#                CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
#                LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN(",l_origin_str CLIPPED,") "
#             END IF 
#             CALL q_ooef001()                              #呼叫開窗
#             LET g_master2.ooef001 = g_qryparam.return1       #將開窗取得的值回傳到變數
#             DISPLAY g_master2.ooef001 TO ooef001             #顯示到畫面上
#             CALL afaq150_get_ooef001_desc()
#             NEXT FIELD ooef001                              #返回原欄位  
            
          ON ACTION controlp INFIELD faansite
	          INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
	          LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_master2.faansite      #給予default值
             LET g_qryparam.where = " ooef207 = 'Y' "
             #160426-00014#33--mark--str--lujh
             ##160125-00005#7--add--str--
             #IF NOT cl_null(g_wc_cs_orga) THEN
			    #   LET g_qryparam.where = g_wc_cs_orga
			    #END IF
			    ##160125-00005#7--add--end 
			    #160426-00014#33--mark--end--lujh
             #CALL q_ooef001()     #161006-00005#22 Mark By Ken 161024
             CALL q_ooef001_47()   #161006-00005#22 Add By Ken 161024 
             LET g_master2.faansite = g_qryparam.return1       #將開窗取得的值回傳到變數
             DISPLAY g_master2.faansite TO faansite             #顯示到畫面上
             CALL afaq150_get_faansite_desc()
             NEXT FIELD faansite                              #返回原欄位  
     
        AFTER INPUT
     
     END INPUT
     CONSTRUCT g_wc ON ooef001,faan004,faan005,faan003,faan007,
                       faah025,faah026,faah005,faah014,faah006,  #160922-00014#1 add faah014 lujh
                       faah007,faan009,faah027,faah028,faah030,  #160426-00014#9 add faan009  #160922-00014#1 add faah007 lujh
                       faah031,faah009,faah038,faanld ,faan010   #160922-00014#1 add faah009,faah038,faanld,faan010 lujh
                       
          FROM s_detail1[1].b_ooef001,s_detail1[1].b_faan004,s_detail1[1].b_faan005,s_detail1[1].b_faan003, 
               s_detail1[1].b_faan007,s_detail1[1].b_faah025,s_detail1[1].b_faah026,s_detail1[1].b_faah005,
               s_detail1[1].b_faah014,s_detail1[1].b_faah006,s_detail1[1].b_faah007,s_detail1[1].b_faan009, #160426-00014#9 add faan009   #160922-00014#1 add faah014,faah007 lujh
               s_detail1[1].b_faah027,s_detail1[1].b_faah028,s_detail1[1].b_faah030,s_detail1[1].b_faah031,
               s_detail1[1].b_faah009,s_detail1[1].b_faah038,s_detail1[1].b_faanld ,s_detail1[1].b_faan010  #160922-00014#1 add lujh        
                  

 
                     
        BEFORE CONSTRUCT
 
        ON ACTION controlp INFIELD b_ooef001
	        INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
	        LET g_qryparam.reqry = FALSE
	        #161111-00049#5 add s--
           CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
           CALL s_fin_account_center_comp_str()RETURNING l_origin_str
           CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
           LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN(",l_origin_str CLIPPED,") "  	        
	        CALL q_ooef001_2()
	        #161111-00049#5 add e---
           #CALL q_ooef001()  #161111-00049#5 mark
           DISPLAY g_qryparam.return1 TO b_ooef001             #顯示到畫面上
           NEXT FIELD b_ooef001                                #返回原欄位  
 
        ON ACTION controlp INFIELD b_faan004
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
			  #161111-00049#5 add s--- 
           CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
           CALL s_fin_account_center_comp_str()RETURNING l_origin_str
           CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
           LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "	  
			  #161111-00049#5 add e---           
           CALL q_faah003()                       #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faan004  #顯示到畫面上
           NEXT FIELD b_faan004                     #返回原欄位
           
        ON ACTION controlp INFIELD b_faan005
           INITIALIZE g_qryparam.* TO NULL                                            
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
			  #161111-00049#5 add s--- 
           CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
           CALL s_fin_account_center_comp_str()RETURNING l_origin_str
           CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
           LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "	  
			  #161111-00049#5 add e---            
           CALL q_faah004()                           #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faan005      #顯示到畫面上
           NEXT FIELD b_faan005   
           
        ON ACTION controlp INFIELD b_faan003
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
			  #161111-00049#5 add s--- 
           CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
           CALL s_fin_account_center_comp_str()RETURNING l_origin_str
           CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
           LET g_qryparam.where = " faah032 IN(",l_origin_str CLIPPED,") "	  
			  #161111-00049#5 add e---            
           CALL q_faah001()                           #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faan003      #顯示到畫面上
           NEXT FIELD b_faan003                         #返回原欄位    
           
        ON ACTION controlp INFIELD b_faah006
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
           #161111-00049#5 add s---
           CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
           CALL s_fin_account_center_comp_str()RETURNING l_origin_str
           CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
           LET g_qryparam.where = " faalld IN (SELECT glaald FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaacomp IN(",l_origin_str CLIPPED,") )"
           CALL q_faal001_1() 
           #161111-00049#5 add e---            
           #CALL q_faac001()  #161111-00049#5   
           DISPLAY g_qryparam.return1 TO b_faah006      #顯示到畫面上
           NEXT FIELD b_faah006                         #返回原欄位

        ON ACTION controlp INFIELD b_faah025
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
           CALL q_ooag001()                         #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah025      #顯示到畫面上
           NEXT FIELD b_faah025                         #返回原欄位
           
        ON ACTION controlp INFIELD b_faah026
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
           LET g_qryparam.arg1 = g_today
           CALL q_ooeg001_4()                         #呼叫開窗
           DISPLAY g_qryparam.return1 TO b_faah026      #顯示到畫面上
           NEXT FIELD b_faah026                         #返回原欄位
            
         ON ACTION controlp INFIELD b_faah027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3900'
			   #161111-00049#5 add s---
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = "( oocq004 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 IN (",l_origin_str,")) OR oocq004 IS NULL)"  		   
            #161111-00049#5 add e---        
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah027  #顯示到畫面上
            NEXT FIELD b_faah027                     #返回原欄位
            
         ON ACTION controlp INFIELD b_faah028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   #161111-00049#5 add s--- 
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " ooef017 IN(",l_origin_str CLIPPED,") "
			   #161111-00049#5 add e---            
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah028  #顯示到畫面上
            NEXT FIELD b_faah028                     #返回原欄位
            
         ON ACTION controlp INFIELD b_faah030
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef207 = 'Y' "    #161006-00005#22 Add By Ken 161024
			   #161111-00049#5 add s--- 
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = g_qryparam.where," AND ooef017 IN(",l_origin_str CLIPPED,") "
			   #161111-00049#5 add e---              
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah030  #顯示到畫面上
            NEXT FIELD b_faah030                     #返回原欄位
            
         ON ACTION controlp INFIELD b_faah031
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161024-00008#6---s---
            #LET g_qryparam.where = " ooef204 = 'Y' OR ooef003 = 'Y' " 
            #CALL q_ooef001_10()                           #呼叫開窗 
            LET g_qryparam.where = " ooef204 = 'Y' "
			   #161111-00049#5 add s--- 
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = g_qryparam.where," AND ooef017 IN(",l_origin_str CLIPPED,") "
			   #161111-00049#5 add e---               
            CALL q_ooef001()
            #161024-00008#6---e---
            DISPLAY g_qryparam.return1 TO b_faah031  #顯示到畫面上
            NEXT FIELD b_faah031                     #返回原欄位返回原欄位
         
         #160922-00014#1--add--str--lujh    
         ON ACTION controlp INFIELD b_faah007
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE	
			   #161111-00049#5 add s---
			   CALL s_axrt300_get_site(g_user,g_master2.faansite,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")				   
			   LET g_qryparam.where = " faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND ",l_ld_str,")"
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " faad002 IN (SELECT faal001 FROM faal_t WHERE faalent = ",g_enterprise," AND faalld IN (SELECT glaald FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaacomp IN(",l_origin_str CLIPPED,") ))"			   
			   #161111-00049#5 add e---			   
            CALL q_faad001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah007    #顯示到畫面上
            NEXT FIELD b_faah007                       #返回原欄位


         ON ACTION controlp INFIELD b_faah009
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            #161111-00049#5 mod s--
            #CALL q_pmaa001_10()              #呼叫開窗                                #呼叫開窗
            LET g_qryparam.arg1 = "('1','3')"
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM pmab_t WHERE pmabent = ",g_enterprise," AND pmaa001 = pmab001 AND pmabsite IN (",l_origin_str,")) "
            CALL q_pmaa001_1()               
            #161111-00049#5 mod e--              
            DISPLAY g_qryparam.return1 TO b_faah009    #顯示到畫面上
            NEXT FIELD b_faah009                       #返回原欄位
            
         ON ACTION controlp INFIELD b_faah038
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmdldocno()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faah038    #顯示到畫面上
            NEXT FIELD b_faah038                       #返回原欄位
            
         ON ACTION controlp INFIELD b_faanld
            CALL s_fin_create_account_center_tmp()   
            #取得资产組織下所屬成員
            CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str
            LET l_origin_str=l_origin_str.substring(3,l_origin_str.getLength()-2)
            CALL s_axrt300_get_site(g_user,l_origin_str,'2') RETURNING l_ld_str 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')"
            CALL q_authorised_ld()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faanld     #顯示到畫面上
            NEXT FIELD b_faanld                        #返回原欄位
            
         ON ACTION controlp INFIELD b_faan010
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_faan010    #顯示到畫面上
            NEXT FIELD b_faan010                       #返回原欄位
         #160922-00014#1--add--end--lujh
      END CONSTRUCT
      
      #160922-00014#1--add--str--lujh
      BEFORE DIALOG
         LET g_faai_d[1].faan004 = ""
         DISPLAY ARRAY g_faai_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
      #160922-00014#1--add--end--lujh
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
      
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
      
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #160818-00045#1--add--str--lujh
         CALL afaq150_qbeclear()      
         CALL g_faai_d.clear()  
         #160818-00045#1--add--end--lujh
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      RETURN 
   ELSE
      LET g_master_idx = 1
   END IF
   LET g_error_show = 1
   CALL afaq150_set_entry()
   CALL afaq150_b_fill()
   LET l_ac = g_master_idx
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION

################################################################################
# Descriptions...: 獲取資產中心名稱
# Memo...........:
# Usage..........: CALL afaq150_get_faansite_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/01/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq150_get_faansite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master2.faansite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master2.faansite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master2.faansite_desc
END FUNCTION

################################################################################
# Descriptions...: 獲取法人組織名稱
# Memo...........:
# Usage..........: CALL afaq150_get_ooef001_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq150_get_ooef001_desc()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_master2.ooef001
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_master2.ooef001_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_master2.ooef001_desc
END FUNCTION

################################################################################
# Descriptions...: 获取主帐套
# Memo...........:
# Usage..........: CALL afaq150_glaald_get()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/01/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq150_glaald_get()
#   SELECT glaald INTO g_glaald
#     FROM glaa_t
#    WHERE glaacomp = g_master2.ooef001
#      AND glaa014 = 'Y'
END FUNCTION

################################################################################
# Descriptions...: 资产中心与法人检查
# Memo...........:
# Usage..........: CALL afaq150_site_comp_chk(p_site,p_comp)
# Input parameter: p_site         资产中心 
#                : p_comp         法人
# Return code....: r_success
# Date & Author..: 2015/01/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq150_site_comp_chk(p_site,p_comp)
DEFINE p_site      LIKE faba_t.fabasite
DEFINE p_comp      LIKE faba_t.fabacomp
DEFINE l_sql       STRING
DEFINE l_count     LIKE type_t.num5
DEFINE l_origin_str  STRING

  LET g_errno = ''
  
  CALL s_fin_account_center_sons_query('5',p_site,g_today,'1')
  CALL s_fin_account_center_comp_str() RETURNING l_origin_str
  CALL s_afat502_change_to_sql(l_origin_str)RETURNING l_origin_str
  LET l_origin_str = "(",l_origin_str,")"
  LET l_sql = " SELECT COUNT(*) FROM ooef_t ",
              "  WHERE ooefent = '",g_enterprise,"' AND ooef017='",p_comp,"'",
              "    AND ooef001 IN ",l_origin_str
   PREPARE sel_fabacomp FROM l_sql
   EXECUTE sel_fabacomp INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET g_errno = 'afa-00306'
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 填充单身一
# Memo...........:
# Usage..........: CALL afaq150_b2_fill()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/01/05 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq150_b2_fill()
#160505-00007#2--mark--str--
#   DEFINE l_faan          RECORD LIKE faan_t.*
#   DEFINE l_faan014_sum   LIKE faan_t.faan014
#   DEFINE l_faan015_sum   LIKE faan_t.faan015   
#   DEFINE l_faan016_sum   LIKE faan_t.faan016
#   DEFINE l_faan017_sum   LIKE faan_t.faan017
#   DEFINE l_faan018_sum   LIKE faan_t.faan018
#   DEFINE l_faan019_sum   LIKE faan_t.faan019
#   DEFINE l_faan020_sum   LIKE faan_t.faan020
#   DEFINE l_faan015_faan020_sum LIKE faan_t.faan015   #151126-00013#8
#   DEFINE l_sum1          LIKE type_t.num20_6
#   DEFINE l_sum2          LIKE type_t.num20_6
#   DEFINE l_sum3          LIKE type_t.num20_6
#   DEFINE l_sum4          LIKE type_t.num20_6
#   DEFINE l_faan102_sum   LIKE faan_t.faan102
#   DEFINE l_faan103_sum   LIKE faan_t.faan103
#   DEFINE l_faan104_sum   LIKE faan_t.faan104
#   DEFINE l_faan105_sum   LIKE faan_t.faan105
#   DEFINE l_faan106_sum   LIKE faan_t.faan106
#   DEFINE l_faan107_sum   LIKE faan_t.faan107
#   DEFINE l_faan108_sum   LIKE faan_t.faan108
#   DEFINE l_faan202_sum   LIKE faan_t.faan202
#   DEFINE l_faan203_sum   LIKE faan_t.faan203
#   DEFINE l_faan204_sum   LIKE faan_t.faan204
#   DEFINE l_faan205_sum   LIKE faan_t.faan205
#   DEFINE l_faan206_sum   LIKE faan_t.faan206
#   DEFINE l_faan207_sum   LIKE faan_t.faan207
#   DEFINE l_faan208_sum   LIKE faan_t.faan208
#   DEFINE l_sum5          LIKE type_t.num20_6 #150908-00002#4 add
#   DEFINE l_sum6          LIKE type_t.num20_6 #150908-00002#4 add
#160505-00007#2--mark--end
   DEFINE l_sql           STRING  #160505-00007#2 add
   DEFINE l_faansite_desc LIKE type_t.chr500
   DEFINE ls_wc      LIKE type_t.chr500       #151105-00001#5
   #DEFINE b_faan          RECORD LIKE faan_t.*    #20150605
   DEFINE l_origin_str  STRING  #160125-00005#7
   DEFINE l_ld_str      STRING  #160125-00005#7
   
   
   #151105-00001#5 --s
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
   #160125-00005#7 add s---
   CALL s_fin_create_account_center_tmp()   
   #取得资产組織下所屬成員
   CALL s_fin_account_center_sons_query('5',g_master2.faansite,g_today,'1')
   #取得资产中心下所屬成員之帳別   
   CALL s_fin_account_center_comp_str() RETURNING l_origin_str
   #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str
   LET l_origin_str=l_origin_str.substring(3,l_origin_str.getLength()-2)
   #账套范围
   CALL s_axrt300_get_site(g_user,l_origin_str,'2')  RETURNING l_ld_str 
   IF NOT cl_null(l_ld_str) THEN   
      LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faanld")
      LET ls_wc = ls_wc, " AND ",l_ld_str
   END IF
   #160125-00005#7 add e---
   
   #151105-00001#5 --e
   
   #161111-00049#5 add s---
   CALL s_axrt300_get_site(g_user,l_origin_str,'2')  RETURNING l_ld_str
   #161111-00049#5 add e---
   
   
   #170207-00011#1 mark-----s
   #LET g_sql = "SELECT  UNIQUE ooef001,faan004,faan005,faan003,faah012,faah013,faah014,faah006,faacl003,faah007,faadl003,faan009,faan006,faan008,faan007,faah025,ooag011,faah026,t1.ooefl003,faah005,",  #20150618 add faah007,faadl003 lujh #160426-00014#9 add faan009
   #            "               faah027,oocql004,faah028,t2.ooefl003,faah030,t3.ooefl003,faah031,t4.ooefl003,faah009,pmaal004,faah038,faah022,faanld,faan010,faaj006,faaj007,t5.ooefl003,faaj003,faaj008,faan012,faan013,faan014,", #160505-00007#2 mod ''->t5.ooefl003
   #            #160505-00007#2--mod--str--
#  #             "               faan015,faan016,faan017,faan018,faan019,faan020,(faan015-faan020),0,0,0,0,faan100,faan102,faan103,faan104,faan105,", #151126-00013#8 add (faan015-faan020) 
   #            "               faan015,faan016,faan017,faan018,faan019,faan020,(faan015-faan020),",
   #            "               (faan040+faan050+faan060+faan080),(faan031+faan041+faan051+faan061+faan071+faan081),",
   #            "               (faan032+faan042+faan052+faan062+faan082),(faan043+faan053+faan063+faan083),",
   #            "               faan100,faan102,faan103,faan104,faan105,",
   #            #160505-00007#2--mod--end
   #            "               faan106,faan107,faan108,faan200,faan202,faan203,faan204,faan205,faan206,faan207,faan208,faah046,faah017,faaj020,'' ",#150908-00002#4 faah017,faaj020,''
   ##170207-00011#1 mark-----e
   #170207-00011#1-----s
   LET g_sql = "SELECT  UNIQUE ooef001,faan004,faan005,faan003,faah012,faah013,faah014,faah006,faacl003,faah007,faadl003,faan009,faan006,faan008,faan007,faah025,ooag011,faah026,t1.ooefl003,faah005,",  
               "               faah027,oocql004,faah028,t2.ooefl003,faah030,t3.ooefl003,faah031,t4.ooefl003,faah009,pmaal004,faah038,faah022,faanld,faan010,faaj006,faaj007,t5.ooefl003,faaj003,faaj008,faan012,faan013,faan014,", 
               "               faaj020,faan018,faan015,faan020,(faan015-faan020),faan019,faan016,faan017,",
               "               (faan040+faan050+faan060+faan080),(faan031+faan041+faan051+faan061+faan071+faan081),",
               "               (faan032+faan042+faan052+faan062+faan082),(faan043+faan053+faan063+faan083),",
               "               faan100,faan102,faan103,faan104,faan105,",
               "               faan106,faan107,faan108,faan200,faan202,faan203,faan204,faan205,faan206,faan207,faan208,faah046,faah017,'' ",
   #170207-00011#1-----e
               #160505-00007#2--mod--str--
#               "  FROM faan_t,faaj_t,ooef_t,glaa_t,faah_t LEFT JOIN ooag_t ON faahent = ooagent AND faah025 = ooag001 ",
               "  FROM faan_t,faaj_t LEFT JOIN ooefl_t t5 ON faajent = t5.ooeflent AND faaj007 = t5.ooefl001 AND t5.ooefl002 = '",g_lang,"',",
               "       ooef_t,glaa_t,",
               "       faah_t LEFT JOIN ooag_t ON faahent = ooagent AND faah025 = ooag001 ",
               #160505-00007#2--mod--end
               "                                          LEFT JOIN faacl_t ON faahent = faaclent AND faah006 = faacl001 AND faacl002 = '",g_lang,"'",
               "                                          LEFT JOIN faadl_t ON faahent = faadlent AND faah007 = faadl001 AND faadl002 = '",g_lang,"'",   #20150618 add lujh
               "                                          LEFT JOIN pmaal_t ON faahent = pmaalent AND faah009 = pmaal001 AND pmaal002 = '",g_lang,"'",
               "                                          LEFT JOIN ooefl_t t1 ON faahent = t1.ooeflent AND faah026 = t1.ooefl001 AND t1.ooefl002 = '",g_lang,"'",
               "                                          LEFT JOIN oocql_t ON faahent = oocqlent AND oocql001 = '3900' AND faah027 = oocql002 AND oocql003 = '",g_lang,"'",
               "                                          LEFT JOIN ooefl_t t2 ON faahent = t2.ooeflent AND faah028 = t2.ooefl001 AND t2.ooefl002 = '",g_lang,"'",
               "                                          LEFT JOIN ooefl_t t3 ON faahent = t3.ooeflent AND faah030 = t3.ooefl001 AND t3.ooefl002 = '",g_lang,"'",
               "                                          LEFT JOIN ooefl_t t4 ON faahent = t4.ooeflent AND faah031 = t4.ooefl001 AND t4.ooefl002 = '",g_lang,"'",
               " WHERE faanent = faahent AND faan004 = faah003 AND faan005 = faah004 ",
               "   AND faan003 = faah001 AND faanent = faajent AND faan004 = faaj001 ",
               "   AND faan005 = faaj002 AND faan003 = faaj037 AND faancomp = ooef001 ",
               "   AND ooef003 = 'Y' AND faanld = faajld AND faanld = glaald ",
               "   AND faanent = '",g_enterprise,"'",
               "   AND faan001 = '",g_master2.faan001,"'",
               "   AND faan002 = '",g_master2.faan002,"'",
               #"   AND faansite = '",g_master2.faansite,"'",     #161031-00007#1 mark lujh
               #"   AND ",g_wc CLIPPED        #151105-00001#5 mark
               "   AND ",ls_wc CLIPPED        #151105-00001#5
               
   IF g_master2.glaa014 = 'Y' THEN 
      LET g_sql = g_sql,"   AND glaa014 = '",g_master2.glaa014,"'",
                        " ORDER BY ooef001,faan004,faan005,faan003 "
   ELSE 
      LET g_sql = g_sql," ORDER BY ooef001,faan004,faan005,faan003 "
   END IF 
   PREPARE afaq150_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR afaq150_pb2
   CALL g_faai_d.clear()
   LET g_cnt = l_ac
   LET l_ac = 1 
   
#160505-00007#2--mark--str--   
#   DELETE FROM afaq150_print_tmp1 
#   LET l_faansite_desc = g_master2.faansite,"    ",g_master2.faansite_desc
#   LET l_faan014_sum = 0
#   LET l_faan015_sum = 0
#   LET l_faan016_sum = 0
#   LET l_faan017_sum = 0
#   LET l_faan018_sum = 0
#   LET l_faan019_sum = 0
#   LET l_faan020_sum = 0
#   LET l_faan015_faan020_sum = 0   #151126-00013#8
#   LET l_sum1        = 0
#   LET l_sum2        = 0
#   LET l_sum3        = 0
#   LET l_sum4        = 0
#   LET l_faan102_sum = 0
#   LET l_faan103_sum = 0
#   LET l_faan104_sum = 0
#   LET l_faan105_sum = 0
#   LET l_faan106_sum = 0
#   LET l_faan107_sum = 0
#   LET l_faan108_sum = 0
#   LET l_faan202_sum = 0
#   LET l_faan203_sum = 0
#   LET l_faan204_sum = 0
#   LET l_faan205_sum = 0
#   LET l_faan206_sum = 0
#   LET l_faan207_sum = 0
#   LET l_faan208_sum = 0
#   LET l_sum5        = 0 #150908-00002#4 add
#   LET l_sum6        = 0 #150908-00002#4 add
#160505-00007#2--mark--end
#160505-00007#2--add--str--
   LET l_sql = "SELECT SUM(faam013) FROM faam_t ",
               " WHERE faament = ",g_enterprise," AND faamld ='",g_glaald,"'",
               "   AND faam004 = ",g_master2.faan001," AND faam005 <= ",g_master2.faan002,
               "   AND (faam007 = '1' OR faam007 = '2' )",
               "   AND faam000 = ? AND faam001 = ? AND faam002 = ? "
   PREPARE afaq150_sum_pr FROM l_sql
#160505-00007#2--add--end

   FOREACH b_fill_curs2 INTO g_faai_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #####################add by huangtao
#160505-00007#2--mark--str--
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_faai_d[l_ac].faaj007
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_faai_d[l_ac].faaj007_desc = '', g_rtn_fields[1] , ''  
#160505-00007#2--mark--end
      #####################add by huangtao
      #150908-00002#4 add---start
#160505-00007#2--mod--str--
#      SELECT SUM(faam013) INTO g_faai_d[l_ac].l_sum_faam013
#        FROM faam_t
#       WHERE faament = g_enterprise AND faamld = g_glaald AND faam000 = g_faai_d[l_ac].faan003
#        AND faam001 = g_faai_d[l_ac].faan004  AND faam002 = g_faai_d[l_ac].faan005
#        AND faam004 = g_master2.faan001 AND faam005 <= g_master2.faan002
#        AND (faam007 = '1' OR faam007 = '2' )
      EXECUTE afaq150_sum_pr USING g_faai_d[l_ac].faan003,g_faai_d[l_ac].faan004,g_faai_d[l_ac].faan005
                             INTO g_faai_d[l_ac].l_sum_faam013
#160505-00007#2--mod--end
      IF cl_null(g_faai_d[l_ac].l_sum_faam013) THEN LET g_faai_d[l_ac].l_sum_faam013 = 0 END IF
      #150908-00002#4 add---end
      
#160505-00007#2--mark--str--
#      INITIALIZE l_faan.* TO NULL
#      SELECT * INTO l_faan.* 
#        FROM faan_t
#       WHERE faanent = g_enterprise
#         AND faan001 = g_master2.faan001
#         AND faan002 = g_master2.faan002
#         AND faan003 = g_faai_d[l_ac].faan003
#         AND faan004 = g_faai_d[l_ac].faan004
#         AND faan005 = g_faai_d[l_ac].faan005
#         AND faanld = g_faai_d[l_ac].faanld
      #20150605--add--str--
      ###晓峰确认规格把异动处置数量、异动处置成本、异动处置累折、异动处置减值准备要显示累计额
      #INITIALIZE b_faan.* TO NULL
      #SELECT SUM(faan040),SUM(faan050),SUM(faan060),SUM(faan080),
      #       SUM(faan031),SUM(faan041),SUM(faan051),SUM(faan061),
      #       SUM(faan071),SUM(faan081),SUM(faan032),SUM(faan042),
      #       SUM(faan052),SUM(faan062),SUM(faan082),SUM(faan043),
      #       SUM(faan053),SUM(faan063),SUM(faan083)
      #  INTO b_faan.faan040,b_faan.faan050,b_faan.faan060,b_faan.faan080,
      #       b_faan.faan031,b_faan.faan041,b_faan.faan051,b_faan.faan061,
      #       b_faan.faan071,b_faan.faan081,b_faan.faan032,b_faan.faan042,
      #       b_faan.faan052,b_faan.faan062,b_faan.faan082,b_faan.faan043,
      #       b_faan.faan053,b_faan.faan063,b_faan.faan083
      #  FROM faan_t
      # WHERE faanent = g_enterprise
      #   AND faan001 < g_master2.faan001
      #    OR (faan001= g_master2.faan001 AND faan002 < g_master2.faan002)
      #   AND faan003 = g_faai_d[l_ac].faan003
      #   AND faan004 = g_faai_d[l_ac].faan004
      #   AND faan005 = g_faai_d[l_ac].faan005
      #   AND faanld = g_faai_d[l_ac].faanld
      #IF cl_null(b_faan.faan040) THEN LET b_faan.faan040=0 END IF
      #IF cl_null(b_faan.faan050) THEN LET b_faan.faan050=0 END IF
      #IF cl_null(b_faan.faan060) THEN LET b_faan.faan060=0 END IF
      #IF cl_null(b_faan.faan080) THEN LET b_faan.faan080=0 END IF
      #IF cl_null(b_faan.faan031) THEN LET b_faan.faan031=0 END IF
      #IF cl_null(b_faan.faan041) THEN LET b_faan.faan041=0 END IF
      #IF cl_null(b_faan.faan051) THEN LET b_faan.faan051=0 END IF
      #IF cl_null(b_faan.faan061) THEN LET b_faan.faan061=0 END IF
      #IF cl_null(b_faan.faan071) THEN LET b_faan.faan071=0 END IF
      #IF cl_null(b_faan.faan081) THEN LET b_faan.faan081=0 END IF
      #IF cl_null(b_faan.faan032) THEN LET b_faan.faan032=0 END IF
      #IF cl_null(b_faan.faan042) THEN LET b_faan.faan042=0 END IF
      #IF cl_null(b_faan.faan052) THEN LET b_faan.faan052=0 END IF
      #IF cl_null(b_faan.faan062) THEN LET b_faan.faan062=0 END IF
      #IF cl_null(b_faan.faan082) THEN LET b_faan.faan082=0 END IF
      #IF cl_null(b_faan.faan043) THEN LET b_faan.faan043=0 END IF
      #IF cl_null(b_faan.faan053) THEN LET b_faan.faan053=0 END IF
      #IF cl_null(b_faan.faan063) THEN LET b_faan.faan063=0 END IF
      #IF cl_null(b_faan.faan083) THEN LET b_faan.faan083=0 END IF
      #20150605--add--end--
#      IF cl_null(l_faan.faan040) THEN 
#         LET l_faan.faan040 = 0
#      END IF
#      IF cl_null(l_faan.faan050) THEN 
#         LET l_faan.faan050 = 0
#      END IF
#      IF cl_null(l_faan.faan060) THEN 
#         LET l_faan.faan060 = 0
#      END IF
#      IF cl_null(l_faan.faan080) THEN 
#         LET l_faan.faan080 = 0
#      END IF
#      IF cl_null(l_faan.faan031) THEN 
#         LET l_faan.faan031 = 0
#      END IF
#      IF cl_null(l_faan.faan041) THEN 
#         LET l_faan.faan041 = 0
#      END IF
#      IF cl_null(l_faan.faan051) THEN 
#         LET l_faan.faan051 = 0
#      END IF
#      IF cl_null(l_faan.faan061) THEN 
#         LET l_faan.faan061 = 0
#      END IF
#      IF cl_null(l_faan.faan071) THEN 
#         LET l_faan.faan071 = 0
#      END IF
#      IF cl_null(l_faan.faan081) THEN 
#         LET l_faan.faan081 = 0
#      END IF
#      IF cl_null(l_faan.faan032) THEN 
#         LET l_faan.faan032 = 0
#      END IF
#      IF cl_null(l_faan.faan042) THEN 
#         LET l_faan.faan042 = 0
#      END IF
#      IF cl_null(l_faan.faan052) THEN 
#         LET l_faan.faan052 = 0
#      END IF
#      IF cl_null(l_faan.faan062) THEN 
#         LET l_faan.faan062 = 0
#      END IF
#      IF cl_null(l_faan.faan082) THEN 
#         LET l_faan.faan082 = 0
#      END IF
#      IF cl_null(l_faan.faan043) THEN 
#         LET l_faan.faan043 = 0
#      END IF
#      IF cl_null(l_faan.faan053) THEN 
#         LET l_faan.faan053 = 0
#      END IF
#      IF cl_null(l_faan.faan063) THEN 
#         LET l_faan.faan063 = 0
#      END IF
#      IF cl_null(l_faan.faan083) THEN 
#         LET l_faan.faan083 = 0
#      END IF
      
      
      
#      #20150605--mod--str--
#      ###只有重估和改良需要累加,其他的还是用当期金额
#      LET g_faai_d[l_ac].sum1 = l_faan.faan040 + l_faan.faan050 + l_faan.faan060 + l_faan.faan080
#      LET g_faai_d[l_ac].sum2 = l_faan.faan031 + l_faan.faan041 + l_faan.faan051 + l_faan.faan061
#                              + l_faan.faan071 + l_faan.faan081
#      LET g_faai_d[l_ac].sum3 = l_faan.faan032 + l_faan.faan042 + l_faan.faan052 + l_faan.faan062
#                              + l_faan.faan082
#      LET g_faai_d[l_ac].sum4 = l_faan.faan043 + l_faan.faan053 + l_faan.faan063 + l_faan.faan083
#160505-00007#2--mark--end
      #LET g_faai_d[l_ac].sum1 = l_faan.faan040 + l_faan.faan050 + l_faan.faan060 + l_faan.faan080
      #LET g_faai_d[l_ac].sum2 = b_faan.faan031 + l_faan.faan041 + l_faan.faan051 + l_faan.faan061
      #                        + b_faan.faan071 + l_faan.faan081
      #LET g_faai_d[l_ac].sum3 = b_faan.faan032 + l_faan.faan042 + l_faan.faan052 + l_faan.faan062
      #                        + l_faan.faan082
      #LET g_faai_d[l_ac].sum4 = l_faan.faan043 + l_faan.faan053 + l_faan.faan063 + l_faan.faan083
      #20150605--mod--end--
#160505-00007#2--mark--str--
#      LET l_faan014_sum = l_faan014_sum + g_faai_d[l_ac].faan014
#      LET l_faan015_sum = l_faan015_sum + g_faai_d[l_ac].faan015   
#      LET l_faan016_sum = l_faan016_sum + g_faai_d[l_ac].faan016
#      LET l_faan017_sum = l_faan017_sum + g_faai_d[l_ac].faan017
#      LET l_faan018_sum = l_faan018_sum + g_faai_d[l_ac].faan018
#      LET l_faan019_sum = l_faan019_sum + g_faai_d[l_ac].faan019
#      LET l_faan020_sum = l_faan020_sum + g_faai_d[l_ac].faan020
#      LET l_faan015_faan020_sum = l_faan015_faan020_sum + g_faai_d[l_ac].l_faan015_faan020   #151126-00013#8
#      LET l_sum1        = l_sum1 + g_faai_d[l_ac].sum1
#      LET l_sum2        = l_sum2 + g_faai_d[l_ac].sum2
#      LET l_sum3        = l_sum3 + g_faai_d[l_ac].sum3
#      LET l_sum4        = l_sum4 + g_faai_d[l_ac].sum4      
#      LET l_faan102_sum = l_faan102_sum + g_faai_d[l_ac].faan102
#      LET l_faan103_sum = l_faan103_sum + g_faai_d[l_ac].faan103
#      LET l_faan104_sum = l_faan104_sum + g_faai_d[l_ac].faan104
#      LET l_faan105_sum = l_faan105_sum + g_faai_d[l_ac].faan105
#      LET l_faan106_sum = l_faan106_sum + g_faai_d[l_ac].faan106
#      LET l_faan107_sum = l_faan107_sum + g_faai_d[l_ac].faan107
#      LET l_faan108_sum = l_faan108_sum + g_faai_d[l_ac].faan108
#      LET l_faan202_sum = l_faan202_sum + g_faai_d[l_ac].faan202
#      LET l_faan203_sum = l_faan203_sum + g_faai_d[l_ac].faan203
#      LET l_faan204_sum = l_faan204_sum + g_faai_d[l_ac].faan204
#      LET l_faan205_sum = l_faan205_sum + g_faai_d[l_ac].faan205
#      LET l_faan206_sum = l_faan206_sum + g_faai_d[l_ac].faan206
#      LET l_faan207_sum = l_faan207_sum + g_faai_d[l_ac].faan207
#      LET l_faan208_sum = l_faan208_sum + g_faai_d[l_ac].faan208
#      LET l_sum5        = l_sum5 + g_faai_d[l_ac].l_faaj020      #150908-00002#4 add
#      LET l_sum6        = l_sum6 + g_faai_d[l_ac].l_sum_faam013  #150908-00002#4 add
#160505-00007#2--mark--end
#      #資產性質
#      CASE g_faai_d[l_ac].faah005
#         WHEN '1'
#                 LET g_faai_d[l_ac].faah005 = cl_getmsg("afa-00424",g_lang)
#         WHEN '2'
#                 LET g_faai_d[l_ac].faah005 = cl_getmsg("afa-00425",g_lang)
#         WHEN '3'
#                 LET g_faai_d[l_ac].faah005 = cl_getmsg("afa-00426",g_lang)
#         WHEN '4'
#                 LET g_faai_d[l_ac].faah005 = cl_getmsg("afa-00427",g_lang)
#         WHEN '5'
#                 LET g_faai_d[l_ac].faah005 = cl_getmsg("afa-00428",g_lang)
#      END CASE 
#      #資產狀態
#      CASE g_faai_d[l_ac].faan007
#         WHEN '0'
#                LET g_faai_d[l_ac].faan007 = cl_getmsg("afa-00438",g_lang)
#         WHEN '1'
#                LET g_faai_d[l_ac].faan007 = cl_getmsg("afa-00439",g_lang)
#         WHEN '2'
#                LET g_faai_d[l_ac].faan007 = cl_getmsg("afa-00440",g_lang)
#         WHEN '3'
#                LET g_faai_d[l_ac].faan007 = cl_getmsg("afa-00441",g_lang)
#         WHEN '4'
#                LET g_faai_d[l_ac].faan007 = cl_getmsg("afa-00442",g_lang)
#         WHEN '5'
#                LET g_faai_d[l_ac].faan007 = cl_getmsg("afa-00443",g_lang)
#         WHEN '6'
#                LET g_faai_d[l_ac].faan007 = cl_getmsg("afa-00444",g_lang)
#         WHEN '7'
#                LET g_faai_d[l_ac].faan007 = cl_getmsg("afa-00445",g_lang)
#         WHEN '8'
#                LET g_faai_d[l_ac].faan007 = cl_getmsg("afa-00446",g_lang)
#         WHEN '9'
#                LET g_faai_d[l_ac].faan007 = cl_getmsg("afa-00447",g_lang)
#         WHEN '10'
#                LET g_faai_d[l_ac].faan007 = cl_getmsg("afa-00448",g_lang)
#      END CASE 
#      #折舊方式
#      CASE g_faai_d[l_ac].faaj003
#         WHEN '1'
#                LET g_faai_d[l_ac].faaj003 = cl_getmsg("afa-00429",g_lang)
#         WHEN '2'
#                LET g_faai_d[l_ac].faaj003 = cl_getmsg("afa-00430",g_lang)
#         WHEN '3'
#                LET g_faai_d[l_ac].faaj003 = cl_getmsg("afa-00431",g_lang)
#         WHEN '4'
#                LET g_faai_d[l_ac].faaj003 = cl_getmsg("afa-00432",g_lang)
#         WHEN '5'
#                LET g_faai_d[l_ac].faaj003 = cl_getmsg("afa-00433",g_lang)
#         WHEN '6'
#                LET g_faai_d[l_ac].faaj003 = cl_getmsg("afa-00434",g_lang)
#      END CASE 
#      #分攤方式
#      CASE g_faai_d[l_ac].faaj006
#         WHEN '1'
#                LET g_faai_d[l_ac].faaj006 = cl_getmsg("afa-00435",g_lang)
#         WHEN '2'
#                LET g_faai_d[l_ac].faaj006 = cl_getmsg("afa-00436",g_lang)
#         WHEN '3'
#                LET g_faai_d[l_ac].faaj006 = cl_getmsg("afa-00437",g_lang)
#      END CASE 
      
      #XG用
      
#      INSERT INTO afaq150_print_tmp1 VALUES(l_faansite_desc,g_master2.faan001,g_master2.faan002,g_faai_d[l_ac].*) 
#160505-00007#2--mark--end
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   CALL g_faai_d.deleteElement(g_faai_d.getLength())
#160505-00007#2--mark--str--
#   IF g_faai_d.getLength() > 0 THEN 
#      LET g_faai_d[g_faai_d.getLength()+1].faaj007 = cl_getmsg("aps-00134", g_lang)
#      LET g_faai_d[g_faai_d.getLength()].faan014 = l_faan014_sum
#      LET g_faai_d[g_faai_d.getLength()].faan015 = l_faan015_sum
#      LET g_faai_d[g_faai_d.getLength()].faan016 = l_faan016_sum
#      LET g_faai_d[g_faai_d.getLength()].faan017 = l_faan017_sum
#      LET g_faai_d[g_faai_d.getLength()].faan018 = l_faan018_sum
#      LET g_faai_d[g_faai_d.getLength()].faan019 = l_faan019_sum
#      LET g_faai_d[g_faai_d.getLength()].faan020 = l_faan020_sum
#      LET g_faai_d[g_faai_d.getLength()].l_faan015_faan020 = l_faan015_faan020_sum   #151126-00013#8
#      LET g_faai_d[g_faai_d.getLength()].sum1    = l_sum1
#      LET g_faai_d[g_faai_d.getLength()].sum2    = l_sum2
#      LET g_faai_d[g_faai_d.getLength()].sum3    = l_sum3
#      LET g_faai_d[g_faai_d.getLength()].sum4    = l_sum4
#      LET g_faai_d[g_faai_d.getLength()].faan102 = l_faan102_sum
#      LET g_faai_d[g_faai_d.getLength()].faan103 = l_faan103_sum
#      LET g_faai_d[g_faai_d.getLength()].faan104 = l_faan104_sum
#      LET g_faai_d[g_faai_d.getLength()].faan105 = l_faan105_sum
#      LET g_faai_d[g_faai_d.getLength()].faan106 = l_faan106_sum
#      LET g_faai_d[g_faai_d.getLength()].faan107 = l_faan107_sum
#      LET g_faai_d[g_faai_d.getLength()].faan108 = l_faan108_sum
#      LET g_faai_d[g_faai_d.getLength()].faan202 = l_faan202_sum
#      LET g_faai_d[g_faai_d.getLength()].faan203 = l_faan203_sum
#      LET g_faai_d[g_faai_d.getLength()].faan204 = l_faan204_sum
#      LET g_faai_d[g_faai_d.getLength()].faan205 = l_faan205_sum
#      LET g_faai_d[g_faai_d.getLength()].faan206 = l_faan206_sum
#      LET g_faai_d[g_faai_d.getLength()].faan207 = l_faan207_sum
#      LET g_faai_d[g_faai_d.getLength()].faan208 = l_faan208_sum
#      LET g_faai_d[g_faai_d.getLength()].l_faaj020 = l_sum5           #150908-00002#4 add
#      LET g_faai_d[g_faai_d.getLength()].l_sum_faam013 = l_sum6       #150908-00002#4 add
#   END IF 
#160505-00007#2--mark--end
   LET g_detail_cnt = g_faai_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_tot_cnt = g_detail_cnt   #160505-00007#2 add
   LET l_ac = g_cnt
   LET g_cnt = 0
   LET l_ac = 1
   CALL afaq150_fetch()
 
END FUNCTION

################################################################################
# Descriptions...: 设置栏位开启关闭
# Memo...........:
# Usage..........: CALL afaq150_set_entry()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/01/08 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq150_set_entry()
   DEFINE l_glaa015   LIKE glaa_t.glaa015
   DEFINE l_glaa019   LIKE glaa_t.glaa019
   DEFINE l_n         LIKE type_t.num5
   
   SELECT glaa015,glaa019
     INTO l_glaa015,l_glaa019
     FROM glaa_t
    WHERE glaald = g_glaald
      AND glaaent = g_enterprise
   
   LET g_glaa015 = l_glaa015
   LET g_glaa019 = l_glaa019
   IF l_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible("b_faan100,b_faan102,b_faan103,b_faan104,b_faan105,b_faan106,b_faan107,b_faan108",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_faan100,b_faan102,b_faan103,b_faan104,b_faan105,b_faan106,b_faan107,b_faan108",FALSE)
   END IF 
   IF l_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible("b_faan200,b_faan202,b_faan203,b_faan204,b_faan205,b_faan206,b_faan207,b_faan208",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_faan200,b_faan202,b_faan203,b_faan204,b_faan205,b_faan206,b_faan207,b_faan208",FALSE)
   END IF
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaa014 <> 'Y'
      AND glaacomp = g_master2.ooef001
   IF l_n = 0 THEN 
      CALL cl_set_comp_visible("page_2",FALSE)
   ELSE
      CALL cl_set_comp_visible("page_2",TRUE)
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 新建臨時表
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq150_create_tmp()
   DROP TABLE afaq150_tmp01;               # 160727-00019#1 Mod  afaq150_print_tmp1--> afaq150_tmp01
      CREATE TEMP TABLE afaq150_tmp01(     # 160727-00019#1 Mod  afaq150_print_tmp1--> afaq150_tmp01
   faansite_desc LIKE type_t.chr500,
   faan001 LIKE faan_t.faan001,
   faan002 LIKE faan_t.faan002,
   ooef001 LIKE ooef_t.ooef001, 
   faan004 LIKE faan_t.faan004, 
   faan005 LIKE faan_t.faan005, 
   faan003 LIKE faan_t.faan003, 
   faah012 LIKE faah_t.faah012, 
   faah013 LIKE faah_t.faah013, 
   faah014 LIKE faah_t.faah014, 
   faah006 LIKE faah_t.faah006, 
   faah006_desc LIKE type_t.chr500, 
   faah007 LIKE faah_t.faah007,     #150827-00010#1 add
   faah007_desc LIKE type_t.chr500, #150827-00010#1 add
   faan009 LIKE faan_t.faan009,     #160818-00030#1 add
   faan006 LIKE faan_t.faan006, 
   faan008 LIKE faan_t.faan008, 
   faan007 LIKE type_t.chr80, 
   faah025 LIKE faah_t.faah025, 
   faah025_desc LIKE type_t.chr500, 
   faah026 LIKE faah_t.faah026, 
   faah026_desc LIKE type_t.chr500, 
   faah005 LIKE type_t.chr80, 
   faah027 LIKE faah_t.faah027, 
   faah027_desc LIKE type_t.chr500, 
   faah028 LIKE faah_t.faah028, 
   faah028_desc LIKE type_t.chr500, 
   faah030 LIKE faah_t.faah030, 
   faah030_desc LIKE type_t.chr500, 
   faah031 LIKE faah_t.faah031, 
   faah031_desc LIKE type_t.chr500, 
   faah009 LIKE faah_t.faah009, 
   faah009_desc LIKE type_t.chr500, 
   faah038 LIKE faah_t.faah038, 
   faah022 LIKE faah_t.faah022, 
   faanld LIKE faan_t.faanld, 
   faan010 LIKE faan_t.faan010, 
   faaj006 LIKE type_t.chr80, 
   faaj007 LIKE faaj_t.faaj007, 
   faaj007_desc LIKE type_t.chr500, 
   faaj003 LIKE type_t.chr80, 
   faaj008 LIKE faaj_t.faaj008, 
   faan012 LIKE faan_t.faan012, 
   faan013 LIKE faan_t.faan013, 
   faan014 LIKE faan_t.faan014, 
   faan015 LIKE faan_t.faan015, 
   faan016 LIKE faan_t.faan016, 
   faan017 LIKE faan_t.faan017, 
   faan018 LIKE faan_t.faan018, 
   faan019 LIKE faan_t.faan019, 
   faan020 LIKE faan_t.faan020,
   l_faan015_faan020_sum LIKE faan_t.faan015, #151228-00011#1   
   sum1 LIKE type_t.num20_6, 
   sum2 LIKE type_t.num20_6, 
   sum3 LIKE type_t.num20_6, 
   sum4 LIKE type_t.num20_6, 
   faan100 LIKE faan_t.faan100, 
   faan102 LIKE faan_t.faan102, 
   faan103 LIKE faan_t.faan103, 
   faan104 LIKE faan_t.faan104, 
   faan105 LIKE faan_t.faan105, 
   faan106 LIKE faan_t.faan106, 
   faan107 LIKE faan_t.faan107, 
   faan108 LIKE faan_t.faan108, 
   faan200 LIKE faan_t.faan200, 
   faan202 LIKE faan_t.faan202, 
   faan203 LIKE faan_t.faan203, 
   faan204 LIKE faan_t.faan204, 
   faan205 LIKE faan_t.faan205, 
   faan206 LIKE faan_t.faan206, 
   faan207 LIKE faan_t.faan207, 
   faan208 LIKE faan_t.faan208, 
   faah046 LIKE faah_t.faah046,
   l_faah017 LIKE type_t.chr10,              #150908-00002#4 add
   l_faaj020 LIKE type_t.num20_6,            #150908-00002#4 add
   l_sum_faam013 LIKE type_t.num20_6         #150908-00002#4 add
       )
       
   DROP TABLE afaq150_tmp02;                 # 160727-00019#1 Mod  afaq150_print_tmp2--> afaq150_tmp02
      CREATE TEMP TABLE afaq150_tmp02(       # 160727-00019#1 Mod  afaq150_print_tmp2--> afaq150_tmp02
   faansite_desc LIKE type_t.chr500,
   faan001 LIKE faan_t.faan001,
   faan002 LIKE faan_t.faan002,    
   ooef001 LIKE ooef_t.ooef001, 
   faan004 LIKE faan_t.faan004, 
   faan005 LIKE faan_t.faan005, 
   faan003 LIKE faan_t.faan003, 
   faaiseq LIKE faai_t.faaiseq, 
   faai004 LIKE faai_t.faai004, 
   faai012 LIKE faai_t.faai012, 
   faai013 LIKE faai_t.faai013, 
   faai005 LIKE faai_t.faai005, 
   faai006 LIKE faai_t.faai006, 
   faai007 LIKE faai_t.faai007, 
   faai008 LIKE faai_t.faai008, 
   faai014 LIKE faai_t.faai014, 
   faai015 LIKE faai_t.faai015, 
   faai016 LIKE faai_t.faai016, 
   faai017 LIKE faai_t.faai017, 
   faai023 LIKE type_t.chr500
       )
END FUNCTION

################################################################################
# Descriptions...: 报表
# Memo...........: #160505-00007#2
# Usage..........: CALL afaq150_output()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/05/12 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq150_output()
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_faansite_desc LIKE type_t.chr500
   DEFINE l_faai023_desc  LIKE type_t.chr500
   DEFINE l_faah005_1     LIKE type_t.chr80,
          l_faah005_2     LIKE type_t.chr80,
          l_faah005_3     LIKE type_t.chr80,
          l_faah005_4     LIKE type_t.chr80,
          l_faah005_5     LIKE type_t.chr80,
          l_faan007_0     LIKE type_t.chr80,
          l_faan007_1     LIKE type_t.chr80,
          l_faan007_2     LIKE type_t.chr80,
          l_faan007_3     LIKE type_t.chr80,
          l_faan007_4     LIKE type_t.chr80,
          l_faan007_5     LIKE type_t.chr80,
          l_faan007_6     LIKE type_t.chr80,
          l_faan007_7     LIKE type_t.chr80,
          l_faan007_8     LIKE type_t.chr80,
          l_faan007_9     LIKE type_t.chr80,
          l_faan007_10    LIKE type_t.chr80,
          l_faaj003_1     LIKE type_t.chr80,
          l_faaj003_2     LIKE type_t.chr80,
          l_faaj003_3     LIKE type_t.chr80,
          l_faaj003_4     LIKE type_t.chr80,
          l_faaj003_5     LIKE type_t.chr80,
          l_faaj003_6     LIKE type_t.chr80,
          l_faaj006_1     LIKE type_t.chr80,
          l_faaj006_2     LIKE type_t.chr80,
          l_faaj006_3     LIKE type_t.chr80
   
   #询问是列印资产清单还是标签信息
   IF NOT cl_ask_confirm("afa-00459") THEN
      #标签信息
      DELETE FROM afaq150_tmp02              # 160727-00019#1 Mod  afaq150_print_tmp2--> afaq150_tmp02
      LET l_faansite_desc = g_master2.faansite,"    ",g_master2.faansite_desc
      LET l_count = g_faai3_d.getLength()
      FOR  l_i = 1 TO l_count
         LET l_faai023_desc = g_faai3_d[l_i].faai023,":",s_desc_gzcbl004_desc('9914',g_faai3_d[l_i].faai023)
         INSERT INTO afaq150_tmp02 VALUES(l_faansite_desc,g_master2.faan001,g_master2.faan002,      # 160727-00019#1 Mod  afaq150_print_tmp2--> afaq150_tmp02
         g_faai3_d[l_i].ooef001,g_faai3_d[l_i].faan004,g_faai3_d[l_i].faan005,g_faai3_d[l_i].faan003, 
         g_faai3_d[l_i].faaiseq,g_faai3_d[l_i].faai004,g_faai3_d[l_i].faai012,g_faai3_d[l_i].faai013, 
         g_faai3_d[l_i].faai005,g_faai3_d[l_i].faai006,g_faai3_d[l_i].faai007,g_faai3_d[l_i].faai008, 
         g_faai3_d[l_i].faai014,g_faai3_d[l_i].faai015,g_faai3_d[l_i].faai016,g_faai3_d[l_i].faai017,
         l_faai023_desc)
      END FOR 
      CALL afaq150_x02('1=1','afaq150_tmp02')              # 160727-00019#1 Mod  afaq150_print_tmp2--> afaq150_tmp02
   ELSE
      #资产清单
      DELETE FROM afaq150_tmp01                             # 160727-00019#1 Mod  afaq150_print_tmp1--> afaq150_tmp01
      LET l_faansite_desc = g_master2.faansite,"    ",g_master2.faansite_desc
      LET l_count = g_faai_d.getLength()
      #資產性質
      LET l_faah005_1 = cl_getmsg("afa-00424",g_lang)
      LET l_faah005_2 = cl_getmsg("afa-00425",g_lang)
      LET l_faah005_3 = cl_getmsg("afa-00426",g_lang)
      LET l_faah005_4 = cl_getmsg("afa-00427",g_lang)
      LET l_faah005_5 = cl_getmsg("afa-00428",g_lang)
      #資產狀態
      LET l_faan007_0 = cl_getmsg("afa-00438",g_lang)
      LET l_faan007_1 = cl_getmsg("afa-00439",g_lang)
      LET l_faan007_2 = cl_getmsg("afa-00440",g_lang)
      LET l_faan007_3 = cl_getmsg("afa-00441",g_lang)
      LET l_faan007_4 = cl_getmsg("afa-00442",g_lang)
      LET l_faan007_5 = cl_getmsg("afa-00443",g_lang)
      LET l_faan007_6 = cl_getmsg("afa-00444",g_lang)
      LET l_faan007_7 = cl_getmsg("afa-00445",g_lang)
      LET l_faan007_8 = cl_getmsg("afa-00446",g_lang)
      LET l_faan007_9 = cl_getmsg("afa-00447",g_lang)
      LET l_faan007_10= cl_getmsg("afa-00448",g_lang)
      #折舊方式
      LET l_faaj003_1 = cl_getmsg("afa-00429",g_lang)
      LET l_faaj003_2 = cl_getmsg("afa-00430",g_lang)
      LET l_faaj003_3 = cl_getmsg("afa-00431",g_lang)
      LET l_faaj003_4 = cl_getmsg("afa-00432",g_lang)
      LET l_faaj003_5 = cl_getmsg("afa-00433",g_lang)
      LET l_faaj003_6 = cl_getmsg("afa-00434",g_lang)
      #分攤方式
      LET l_faaj006_1 = cl_getmsg("afa-00435",g_lang)
      LET l_faaj006_2 = cl_getmsg("afa-00436",g_lang)
      LET l_faaj006_3 = cl_getmsg("afa-00437",g_lang)
      FOR  l_i = 1 TO l_count
         #資產性質
         CASE g_faai_d[l_ac].faah005
            WHEN '1'
                    LET g_faai_d[l_i].faah005 = l_faah005_1
            WHEN '2'
                    LET g_faai_d[l_i].faah005 = l_faah005_2
            WHEN '3'
                    LET g_faai_d[l_i].faah005 = l_faah005_3
            WHEN '4'
                    LET g_faai_d[l_i].faah005 = l_faah005_4
            WHEN '5'
                    LET g_faai_d[l_i].faah005 = l_faah005_5
         END CASE
         #資產狀態
         CASE g_faai_d[l_ac].faan007
            WHEN '0'
                   LET g_faai_d[l_i].faan007 = l_faan007_0
            WHEN '1'
                   LET g_faai_d[l_i].faan007 = l_faan007_1
            WHEN '2'
                   LET g_faai_d[l_i].faan007 = l_faan007_2
            WHEN '3'
                   LET g_faai_d[l_i].faan007 = l_faan007_3
            WHEN '4'
                   LET g_faai_d[l_i].faan007 = l_faan007_4
            WHEN '5'
                   LET g_faai_d[l_i].faan007 = l_faan007_5
            WHEN '6'
                   LET g_faai_d[l_i].faan007 = l_faan007_6
            WHEN '7'
                   LET g_faai_d[l_i].faan007 = l_faan007_7
            WHEN '8'
                   LET g_faai_d[l_i].faan007 = l_faan007_8
            WHEN '9'
                   LET g_faai_d[l_i].faan007 = l_faan007_9
            WHEN '10'
                   LET g_faai_d[l_i].faan007 = l_faan007_10
         END CASE 
         #折舊方式
         CASE g_faai_d[l_ac].faaj003
            WHEN '1'
                   LET g_faai_d[l_i].faaj003 = l_faaj003_1
            WHEN '2'
                   LET g_faai_d[l_i].faaj003 = l_faaj003_2
            WHEN '3'
                   LET g_faai_d[l_i].faaj003 = l_faaj003_3
            WHEN '4'
                   LET g_faai_d[l_i].faaj003 = l_faaj003_4
            WHEN '5'
                   LET g_faai_d[l_i].faaj003 = l_faaj003_5
            WHEN '6'
                   LET g_faai_d[l_i].faaj003 = l_faaj003_6
         END CASE 
         #分攤方式
         CASE g_faai_d[l_i].faaj006
            WHEN '1'
                   LET g_faai_d[l_i].faaj006 = l_faaj006_1
            WHEN '2'
                   LET g_faai_d[l_i].faaj006 = l_faaj006_2
            WHEN '3'
                   LET g_faai_d[l_i].faaj006 = l_faaj006_3
         END CASE         
         #INSERT INTO afaq150_tmp01 VALUES(l_faansite_desc,g_master2.faan001,g_master2.faan002,g_faai_d[l_i].*)   # 160727-00019#1 Mod  afaq150_print_tmp1--> afaq150_tmp01   #170207-00011#1 mark
         #170207-00011#1-----s
         INSERT INTO afaq150_tmp01(faansite_desc,faan001,faan002,ooef001,faan004,
                                   faan005,faan003,faah012,faah013,faah014,
                                   faah006,faah006_desc,faah007,faah007_desc,faan009,
                                   faan006,faan008,faan007,faah025,faah025_desc,
                                   faah026,faah026_desc,faah005,faah027,faah027_desc,
                                   faah028,faah028_desc,faah030,faah030_desc,faah031,
                                   faah031_desc,faah009,faah009_desc,faah038,faah022,
                                   faanld,faan010,faaj006,faaj007,faaj007_desc,faaj003,
                                   faaj008,faan012,faan013,faan014,faan015,
                                   faan016,faan017,faan018,faan019,faan020,
                                   l_faan015_faan020_sum,sum1,sum2,sum3,
                                   sum4,faan100,faan102,faan103,faan104,
                                   faan105,faan106,faan107,faan108,faan200,
                                   faan202,faan203,faan204,faan205,faan206,
                                   faan207,faan208,faah046,l_faah017,l_faaj020,
                                   l_sum_faam013)
          VALUES(l_faansite_desc,g_master2.faan001,g_master2.faan002,g_faai_d[l_i].ooef001,g_faai_d[l_i].faan004,     
                 g_faai_d[l_i].faan005,g_faai_d[l_i].faan003,g_faai_d[l_i].faah012,g_faai_d[l_i].faah013,g_faai_d[l_i].faah014,     
                 g_faai_d[l_i].faah006,g_faai_d[l_i].faah006_desc,g_faai_d[l_i].faah007,g_faai_d[l_i].faah007_desc,g_faai_d[l_i].faan009,
                 g_faai_d[l_i].faan006,g_faai_d[l_i].faan008,g_faai_d[l_i].faan007,g_faai_d[l_i].faah025,g_faai_d[l_i].faah025_desc,
                 g_faai_d[l_i].faah026,g_faai_d[l_i].faah026_desc,g_faai_d[l_i].faah005,g_faai_d[l_i].faah027,g_faai_d[l_i].faah027_desc,
                 g_faai_d[l_i].faah028,g_faai_d[l_i].faah028_desc,g_faai_d[l_i].faah030,g_faai_d[l_i].faah030_desc,g_faai_d[l_i].faah031,
                 g_faai_d[l_i].faah031_desc,g_faai_d[l_i].faah009,g_faai_d[l_i].faah009_desc,g_faai_d[l_i].faah038 ,g_faai_d[l_i].faah022 ,
                 g_faai_d[l_i].faanld ,g_faai_d[l_i].faan010 ,g_faai_d[l_i].faaj006 ,g_faai_d[l_i].faaj007 ,g_faai_d[l_i].faaj007_desc,
                 g_faai_d[l_i].faaj003 ,g_faai_d[l_i].faaj008,g_faai_d[l_i].faan012,g_faai_d[l_i].faan013,g_faai_d[l_i].faan014,
                 g_faai_d[l_i].faan015,g_faai_d[l_i].faan016,g_faai_d[l_i].faan017,g_faai_d[l_i].faan018,g_faai_d[l_i].faan019,
                 g_faai_d[l_i].faan020,g_faai_d[l_i].l_faan015_faan020,g_faai_d[l_i].sum1 ,g_faai_d[l_i].sum2 ,g_faai_d[l_i].sum3 ,
                 g_faai_d[l_i].sum4 ,g_faai_d[l_i].faan100, g_faai_d[l_i].faan102, g_faai_d[l_i].faan103 ,g_faai_d[l_i].faan104 ,
                 g_faai_d[l_i].faan105 ,g_faai_d[l_i].faan106 ,g_faai_d[l_i].faan107 ,g_faai_d[l_i].faan108 ,g_faai_d[l_i].faan200 ,
                 g_faai_d[l_i].faan202 ,g_faai_d[l_i].faan203 ,g_faai_d[l_i].faan204 ,g_faai_d[l_i].faan205 ,g_faai_d[l_i].faan206 ,
                 g_faai_d[l_i].faan207 ,g_faai_d[l_i].faan208 ,g_faai_d[l_i].faah046 ,g_faai_d[l_i].l_faah017,g_faai_d[l_i].l_faaj020,
                 g_faai_d[l_i].l_sum_faam013)          
         #170207-00011#1-----e
      END FOR
      CALL afaq150_x01('1=1','afaq150_tmp01',g_glaa015,g_glaa019)               # 160727-00019#1 Mod  afaq150_print_tmp1--> afaq150_tmp01
   END IF
END FUNCTION
# 清除条件重新给默认值
#160818-00045#1 add lujh
PRIVATE FUNCTION afaq150_qbeclear()
   #預設值
   LET g_master2.faansite = g_site 
   CALL afaq150_get_faansite_desc()
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_master2.ooef001,g_glaald
   CALL s_fin_account_center_with_ld_chk(g_site,g_glaald,g_user,'5','N','',g_today) RETURNING g_sub_success,g_errno
   IF NOT g_sub_success THEN 
      LET g_master2.ooef001 = ''
      LET g_glaald = ''
   END IF
   LET g_master2.glaa014 = 'Y'
   CALL cl_get_para(g_enterprise,g_master2.ooef001,'S-FIN-9018') RETURNING g_master2.faan001
   CALL cl_get_para(g_enterprise,g_master2.ooef001,'S-FIN-9019') RETURNING g_master2.faan002
   LET g_master2_t.* = g_master2.*
END FUNCTION

 
{</section>}
 
