#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt402.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2015-05-27 14:13:11), PR版次:0015(2016-11-23 17:52:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000515
#+ Filename...: ammt402
#+ Description: 會員卡領用申請維護作業
#+ Creator....: 02296(2013-08-13 17:30:19)
#+ Modifier...: 01533 -SD/PR- 02159
 
{</section>}
 
{<section id="ammt402.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#24  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160411-00033#1   2016/04/12 by 08172   错误信息更改
#160318-00025#20  2016/04/19 BY 07900   校验代码重复错误讯息的修改
#160604-00009#50  2016/07/22 by 08172   库区预设值
#160816-00001#6   2016/08/17 By 08742   抓取理由碼改CALL sub
#160818-00017#22  2016/08/26 By 08742   删除修改未重新判断状态码
#160905-00007#6   2016/09/05 By 02599   SQL条件增加ent
#160824-00007#121 2016/11/23 By sakura  新舊值備份處理
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
PRIVATE type type_g_mmay_m        RECORD
       mmaysite LIKE mmay_t.mmaysite, 
   mmaysite_desc LIKE type_t.chr80, 
   mmaydocdt LIKE mmay_t.mmaydocdt, 
   mmaydocno LIKE mmay_t.mmaydocno, 
   mmayunit LIKE mmay_t.mmayunit, 
   mmay001 LIKE mmay_t.mmay001, 
   mmay001_desc LIKE type_t.chr80, 
   mmay002 LIKE mmay_t.mmay002, 
   mmay002_desc LIKE type_t.chr80, 
   mmay003 LIKE mmay_t.mmay003, 
   mmay003_desc LIKE type_t.chr80, 
   mmay000 LIKE mmay_t.mmay000, 
   mmaystus LIKE mmay_t.mmaystus, 
   mmayownid LIKE mmay_t.mmayownid, 
   mmayownid_desc LIKE type_t.chr80, 
   mmayowndp LIKE mmay_t.mmayowndp, 
   mmayowndp_desc LIKE type_t.chr80, 
   mmaycrtid LIKE mmay_t.mmaycrtid, 
   mmaycrtid_desc LIKE type_t.chr80, 
   mmaycrtdp LIKE mmay_t.mmaycrtdp, 
   mmaycrtdp_desc LIKE type_t.chr80, 
   mmaycrtdt LIKE mmay_t.mmaycrtdt, 
   mmaymodid LIKE mmay_t.mmaymodid, 
   mmaymodid_desc LIKE type_t.chr80, 
   mmaymoddt LIKE mmay_t.mmaymoddt, 
   mmaycnfid LIKE mmay_t.mmaycnfid, 
   mmaycnfid_desc LIKE type_t.chr80, 
   mmaycnfdt LIKE mmay_t.mmaycnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mmaz_d        RECORD
       mmazseq LIKE mmaz_t.mmazseq, 
   mmazsite LIKE mmaz_t.mmazsite, 
   mmazsite_desc LIKE type_t.chr500, 
   mmaz000 LIKE mmaz_t.mmaz000, 
   mmaz002 LIKE mmaz_t.mmaz002, 
   mmaz003 LIKE mmaz_t.mmaz003, 
   mmaz003_desc LIKE type_t.chr500, 
   mmaz004 LIKE mmaz_t.mmaz004, 
   mmaz004_desc LIKE type_t.chr500, 
   mmaz005 LIKE mmaz_t.mmaz005, 
   mmaz005_desc LIKE type_t.chr500, 
   mmaz001 LIKE mmaz_t.mmaz001, 
   mmaz001_desc LIKE type_t.chr500, 
   mmaz006 LIKE mmaz_t.mmaz006, 
   mmaz007 LIKE mmaz_t.mmaz007, 
   mmaz008 LIKE mmaz_t.mmaz008, 
   mmaz009 LIKE mmaz_t.mmaz009, 
   mmazunit LIKE mmaz_t.mmazunit
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mmaydocno LIKE mmay_t.mmaydocno,
      b_mmaydocdt LIKE mmay_t.mmaydocdt,
      b_mmaysite LIKE mmay_t.mmaysite,
   b_mmaysite_desc LIKE type_t.chr80,
      b_mmay001 LIKE mmay_t.mmay001,
   b_mmay001_desc LIKE type_t.chr80,
      b_mmay002 LIKE mmay_t.mmay002,
   b_mmay002_desc LIKE type_t.chr80,
      b_mmay003 LIKE mmay_t.mmay003,
   b_mmay003_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_type                LIKE type_t.chr1   #'1'時代表是 會員卡領用維護作業  '2'時代表是 會員券領用維護作業
DEFINE g_acc                 LIKE gzcb_t.gzcb007
#end add-point
       
#模組變數(Module Variables)
DEFINE g_mmay_m          type_g_mmay_m
DEFINE g_mmay_m_t        type_g_mmay_m
DEFINE g_mmay_m_o        type_g_mmay_m
DEFINE g_mmay_m_mask_o   type_g_mmay_m #轉換遮罩前資料
DEFINE g_mmay_m_mask_n   type_g_mmay_m #轉換遮罩後資料
 
   DEFINE g_mmaydocno_t LIKE mmay_t.mmaydocno
 
 
DEFINE g_mmaz_d          DYNAMIC ARRAY OF type_g_mmaz_d
DEFINE g_mmaz_d_t        type_g_mmaz_d
DEFINE g_mmaz_d_o        type_g_mmaz_d
DEFINE g_mmaz_d_mask_o   DYNAMIC ARRAY OF type_g_mmaz_d #轉換遮罩前資料
DEFINE g_mmaz_d_mask_n   DYNAMIC ARRAY OF type_g_mmaz_d #轉換遮罩後資料
 
 
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
 
{<section id="ammt402.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amm","")
 
   #add-point:作業初始化 name="main.init"
   IF NOT cl_null(g_argv[1]) THEN
      LET g_type = g_argv[1]
   END IF
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位二]的欄位值
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog   #160816-00001#6  mark
   LET g_acc = s_fin_get_scc_value('24',g_prog,'2')  #160816-00001#6  Add
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent = g_enterprise
   CREATE TEMP TABLE ammt402_tmp
   (
      mmap003 varchar(30)
   );
   DELETE from ammt402_tmp
   IF SQLCA.sqlcode THEN
      LET g_errno = SQLCA.sqlcode
      RETURN
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mmaysite,'',mmaydocdt,mmaydocno,mmayunit,mmay001,'',mmay002,'',mmay003, 
       '',mmay000,mmaystus,mmayownid,'',mmayowndp,'',mmaycrtid,'',mmaycrtdp,'',mmaycrtdt,mmaymodid,'', 
       mmaymoddt,mmaycnfid,'',mmaycnfdt", 
                      " FROM mmay_t",
                      " WHERE mmayent= ? AND mmaydocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt402_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mmaysite,t0.mmaydocdt,t0.mmaydocno,t0.mmayunit,t0.mmay001,t0.mmay002, 
       t0.mmay003,t0.mmay000,t0.mmaystus,t0.mmayownid,t0.mmayowndp,t0.mmaycrtid,t0.mmaycrtdp,t0.mmaycrtdt, 
       t0.mmaymodid,t0.mmaymoddt,t0.mmaycnfid,t0.mmaycnfdt,t1.ooefl003 ,t2.ooefl003 ,t3.ooefl003 ,t4.inayl003 , 
       t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooag011",
               " FROM mmay_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmaysite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mmay001 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mmay002 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t4 ON t4.inaylent="||g_enterprise||" AND t4.inayl001=t0.mmay003 AND t4.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.mmayownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.mmayowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.mmaycrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.mmaycrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.mmaymodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.mmaycnfid  ",
 
               " WHERE t0.mmayent = " ||g_enterprise|| " AND t0.mmaydocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ammt402_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammt402 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammt402_init()   
 
      #進入選單 Menu (="N")
      CALL ammt402_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammt402
      
   END IF 
   
   CLOSE ammt402_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ammt402.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ammt402_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_msg   LIKE gzze_t.gzze003
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
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
      CALL cl_set_combo_scc_part('mmaystus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   IF g_type='2' THEN
      LET l_msg = null
      SELECT gzze003 INTO l_msg FROM gzze_t WHERE gzze001 = 'agc-00031'
        AND gzze002 = g_dlang AND gzzestus = 'Y'
      CALL cl_set_comp_att_text("mmaz001",l_msg)         
      LET l_msg = null
      SELECT gzze003 INTO l_msg FROM gzze_t WHERE gzze001 = 'agc-00032'
        AND gzze002 = g_dlang AND gzzestus = 'Y'
      CALL cl_set_comp_att_text("mmaz001_desc",l_msg)
      LET l_msg = null
      SELECT gzze003 INTO l_msg FROM gzze_t WHERE gzze001 = 'agc-00033'
        AND gzze002 = g_dlang AND gzzestus = 'Y'
      CALL cl_set_comp_att_text("mmaz008",l_msg)
      LET l_msg = null
      SELECT gzze003 INTO l_msg FROM gzze_t WHERE gzze001 = 'agc-00034'
        AND gzze002 = g_dlang AND gzzestus = 'Y'
      CALL cl_set_comp_att_text("mmaz009",l_msg)
   END IF
   CALL cl_set_comp_visible("mmaz002,mmaz007",false)
   CALL cl_set_comp_entry("mmaastus",false)
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
   
   #初始化搜尋條件
   CALL ammt402_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="ammt402.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION ammt402_ui_dialog()
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
 
   #因應查詢方案進行處理
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL ammt402_insert()
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
         INITIALIZE g_mmay_m.* TO NULL
         CALL g_mmaz_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL ammt402_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
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
               
               CALL ammt402_fetch('') # reload data
               LET l_ac = 1
               CALL ammt402_ui_detailshow() #Setting the current row 
         
               CALL ammt402_idx_chk()
               #NEXT FIELD mmazseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mmaz_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt402_idx_chk()
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
               CALL ammt402_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL ammt402_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
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
               CALL ammt402_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL ammt402_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL ammt402_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL ammt402_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL ammt402_set_act_visible()   
            CALL ammt402_set_act_no_visible()
            IF NOT (g_mmay_m.mmaydocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mmayent = " ||g_enterprise|| " AND",
                                  " mmaydocno = '", g_mmay_m.mmaydocno, "' "
 
               #填到對應位置
               CALL ammt402_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mmay_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmaz_t" 
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
               CALL ammt402_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mmay_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmaz_t" 
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
                  CALL ammt402_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL ammt402_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL ammt402_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL ammt402_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt402_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL ammt402_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt402_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL ammt402_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt402_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL ammt402_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt402_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL ammt402_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt402_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mmaz_d)
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
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
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
               NEXT FIELD mmazseq
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
               CALL ammt402_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL ammt402_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL ammt402_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL ammt402_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/amm/ammt402_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/amm/ammt402_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL ammt402_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL ammt402_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL ammt402_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammt402_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammt402_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mmay_m.mmaydocdt)
 
 
 
         
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
 
{<section id="ammt402.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION ammt402_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
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
   CALL s_aooi500_sql_where(g_prog,'mmaysite') RETURNING l_where
   IF cl_null(l_wc) THEN
      LET l_wc=" 1=1"
   END IF
   IF cl_null(l_wc2) THEN
      LET l_wc2=" 1=1"
   END IF
   LET l_wc=l_wc," AND mmay000='",g_type clipped,"' AND ",l_where
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT mmaydocno ",
                      " FROM mmay_t ",
                      " ",
                      " LEFT JOIN mmaz_t ON mmazent = mmayent AND mmaydocno = mmazdocno ", "  ",
                      #add-point:browser_fill段sql(mmaz_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE mmayent = " ||g_enterprise|| " AND mmazent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mmay_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mmaydocno ",
                      " FROM mmay_t ", 
                      "  ",
                      "  ",
                      " WHERE mmayent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mmay_t")
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
      INITIALIZE g_mmay_m.* TO NULL
      CALL g_mmaz_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mmaydocno,t0.mmaydocdt,t0.mmaysite,t0.mmay001,t0.mmay002,t0.mmay003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmaystus,t0.mmaydocno,t0.mmaydocdt,t0.mmaysite,t0.mmay001,t0.mmay002, 
          t0.mmay003,t1.ooefl003 ,t2.ooefl003 ,t3.ooefl003 ,t4.inayl003 ",
                  " FROM mmay_t t0",
                  "  ",
                  "  LEFT JOIN mmaz_t ON mmazent = mmayent AND mmaydocno = mmazdocno ", "  ", 
                  #add-point:browser_fill段sql(mmaz_t1) name="browser_fill.join.mmaz_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmaysite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mmay001 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mmay002 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t4 ON t4.inaylent="||g_enterprise||" AND t4.inayl001=t0.mmay003 AND t4.inayl002='"||g_dlang||"' ",
 
                  " WHERE t0.mmayent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mmay_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmaystus,t0.mmaydocno,t0.mmaydocdt,t0.mmaysite,t0.mmay001,t0.mmay002, 
          t0.mmay003,t1.ooefl003 ,t2.ooefl003 ,t3.ooefl003 ,t4.inayl003 ",
                  " FROM mmay_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmaysite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.mmay001 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mmay002 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t4 ON t4.inaylent="||g_enterprise||" AND t4.inayl001=t0.mmay003 AND t4.inayl002='"||g_dlang||"' ",
 
                  " WHERE t0.mmayent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mmay_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mmaydocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mmay_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmaydocno,g_browser[g_cnt].b_mmaydocdt, 
          g_browser[g_cnt].b_mmaysite,g_browser[g_cnt].b_mmay001,g_browser[g_cnt].b_mmay002,g_browser[g_cnt].b_mmay003, 
          g_browser[g_cnt].b_mmaysite_desc,g_browser[g_cnt].b_mmay001_desc,g_browser[g_cnt].b_mmay002_desc, 
          g_browser[g_cnt].b_mmay003_desc
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
      
         #遮罩相關處理
         CALL ammt402_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_mmaydocno) THEN
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
 
{<section id="ammt402.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION ammt402_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mmay_m.mmaydocno = g_browser[g_current_idx].b_mmaydocno   
 
   EXECUTE ammt402_master_referesh USING g_mmay_m.mmaydocno INTO g_mmay_m.mmaysite,g_mmay_m.mmaydocdt, 
       g_mmay_m.mmaydocno,g_mmay_m.mmayunit,g_mmay_m.mmay001,g_mmay_m.mmay002,g_mmay_m.mmay003,g_mmay_m.mmay000, 
       g_mmay_m.mmaystus,g_mmay_m.mmayownid,g_mmay_m.mmayowndp,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtdp, 
       g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymoddt,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfdt, 
       g_mmay_m.mmaysite_desc,g_mmay_m.mmay001_desc,g_mmay_m.mmay002_desc,g_mmay_m.mmay003_desc,g_mmay_m.mmayownid_desc, 
       g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid_desc,g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaymodid_desc, 
       g_mmay_m.mmaycnfid_desc
   
   CALL ammt402_mmay_t_mask()
   CALL ammt402_show()
      
END FUNCTION
 
{</section>}
 
{<section id="ammt402.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION ammt402_ui_detailshow()
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
 
{<section id="ammt402.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION ammt402_ui_browser_refresh()
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
      IF g_browser[l_i].b_mmaydocno = g_mmay_m.mmaydocno 
 
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
 
{<section id="ammt402.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammt402_construct()
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
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_mmay_m.* TO NULL
   CALL g_mmaz_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON mmaysite,mmaydocdt,mmaydocno,mmayunit,mmay001,mmay002,mmay003,mmay000, 
          mmaystus,mmayownid,mmayowndp,mmaycrtid,mmaycrtdp,mmaycrtdt,mmaymodid,mmaymoddt,mmaycnfid,mmaycnfdt 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            DISPLAY g_type to mmay000
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmaycrtdt>>----
         AFTER FIELD mmaycrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mmaymoddt>>----
         AFTER FIELD mmaymoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmaycnfdt>>----
         AFTER FIELD mmaycnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmaypstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mmaysite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaysite
            #add-point:ON ACTION controlp INFIELD mmaysite name="construct.c.mmaysite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004_3()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaysite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()
            LET g_qryparam.arg2 = null
            DISPLAY g_qryparam.return1 TO mmaysite  #顯示到畫面上

            NEXT FIELD mmaysite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaysite
            #add-point:BEFORE FIELD mmaysite name="construct.b.mmaysite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaysite
            
            #add-point:AFTER FIELD mmaysite name="construct.a.mmaysite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaydocdt
            #add-point:BEFORE FIELD mmaydocdt name="construct.b.mmaydocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaydocdt
            
            #add-point:AFTER FIELD mmaydocdt name="construct.a.mmaydocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaydocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaydocdt
            #add-point:ON ACTION controlp INFIELD mmaydocdt name="construct.c.mmaydocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaydocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaydocno
            #add-point:ON ACTION controlp INFIELD mmaydocno name="construct.c.mmaydocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " mmay000 = '",g_type,"' "
            CALL q_mmaydocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaydocno  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO mmaydocdt #單據日期 

            NEXT FIELD mmaydocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaydocno
            #add-point:BEFORE FIELD mmaydocno name="construct.b.mmaydocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaydocno
            
            #add-point:AFTER FIELD mmaydocno name="construct.a.mmaydocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmayunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmayunit
            #add-point:ON ACTION controlp INFIELD mmayunit name="construct.c.mmayunit"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmayunit  #顯示到畫面上

            NEXT FIELD mmayunit                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmayunit
            #add-point:BEFORE FIELD mmayunit name="construct.b.mmayunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmayunit
            
            #add-point:AFTER FIELD mmayunit name="construct.a.mmayunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmay001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmay001
            #add-point:ON ACTION controlp INFIELD mmay001 name="construct.c.mmay001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmay001') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmay001',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO mmay001  #顯示到畫面上

            NEXT FIELD mmay001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmay001
            #add-point:BEFORE FIELD mmay001 name="construct.b.mmay001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmay001
            
            #add-point:AFTER FIELD mmay001 name="construct.a.mmay001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmay002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmay002
            #add-point:ON ACTION controlp INFIELD mmay002 name="construct.c.mmay002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmay002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmay002',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO mmay002  #顯示到畫面上

            NEXT FIELD mmay002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmay002
            #add-point:BEFORE FIELD mmay002 name="construct.b.mmay002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmay002
            
            #add-point:AFTER FIELD mmay002 name="construct.a.mmay002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmay003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmay003
            #add-point:ON ACTION controlp INFIELD mmay003 name="construct.c.mmay003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmay003  #顯示到畫面上

            NEXT FIELD mmay003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmay003
            #add-point:BEFORE FIELD mmay003 name="construct.b.mmay003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmay003
            
            #add-point:AFTER FIELD mmay003 name="construct.a.mmay003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmay000
            #add-point:BEFORE FIELD mmay000 name="construct.b.mmay000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmay000
            
            #add-point:AFTER FIELD mmay000 name="construct.a.mmay000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmay000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmay000
            #add-point:ON ACTION controlp INFIELD mmay000 name="construct.c.mmay000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaystus
            #add-point:BEFORE FIELD mmaystus name="construct.b.mmaystus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaystus
            
            #add-point:AFTER FIELD mmaystus name="construct.a.mmaystus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaystus
            #add-point:ON ACTION controlp INFIELD mmaystus name="construct.c.mmaystus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmayownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmayownid
            #add-point:ON ACTION controlp INFIELD mmayownid name="construct.c.mmayownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmayownid  #顯示到畫面上

            NEXT FIELD mmayownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmayownid
            #add-point:BEFORE FIELD mmayownid name="construct.b.mmayownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmayownid
            
            #add-point:AFTER FIELD mmayownid name="construct.a.mmayownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmayowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmayowndp
            #add-point:ON ACTION controlp INFIELD mmayowndp name="construct.c.mmayowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmayowndp  #顯示到畫面上

            NEXT FIELD mmayowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmayowndp
            #add-point:BEFORE FIELD mmayowndp name="construct.b.mmayowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmayowndp
            
            #add-point:AFTER FIELD mmayowndp name="construct.a.mmayowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaycrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaycrtid
            #add-point:ON ACTION controlp INFIELD mmaycrtid name="construct.c.mmaycrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaycrtid  #顯示到畫面上

            NEXT FIELD mmaycrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaycrtid
            #add-point:BEFORE FIELD mmaycrtid name="construct.b.mmaycrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaycrtid
            
            #add-point:AFTER FIELD mmaycrtid name="construct.a.mmaycrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaycrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaycrtdp
            #add-point:ON ACTION controlp INFIELD mmaycrtdp name="construct.c.mmaycrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaycrtdp  #顯示到畫面上

            NEXT FIELD mmaycrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaycrtdp
            #add-point:BEFORE FIELD mmaycrtdp name="construct.b.mmaycrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaycrtdp
            
            #add-point:AFTER FIELD mmaycrtdp name="construct.a.mmaycrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaycrtdt
            #add-point:BEFORE FIELD mmaycrtdt name="construct.b.mmaycrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaymodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaymodid
            #add-point:ON ACTION controlp INFIELD mmaymodid name="construct.c.mmaymodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaymodid  #顯示到畫面上

            NEXT FIELD mmaymodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaymodid
            #add-point:BEFORE FIELD mmaymodid name="construct.b.mmaymodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaymodid
            
            #add-point:AFTER FIELD mmaymodid name="construct.a.mmaymodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaymoddt
            #add-point:BEFORE FIELD mmaymoddt name="construct.b.mmaymoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaycnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaycnfid
            #add-point:ON ACTION controlp INFIELD mmaycnfid name="construct.c.mmaycnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaycnfid  #顯示到畫面上

            NEXT FIELD mmaycnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaycnfid
            #add-point:BEFORE FIELD mmaycnfid name="construct.b.mmaycnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaycnfid
            
            #add-point:AFTER FIELD mmaycnfid name="construct.a.mmaycnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaycnfdt
            #add-point:BEFORE FIELD mmaycnfdt name="construct.b.mmaycnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mmazseq,mmazsite,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006, 
          mmaz007,mmaz008,mmaz009
           FROM s_detail1[1].mmazseq,s_detail1[1].mmazsite,s_detail1[1].mmaz000,s_detail1[1].mmaz002, 
               s_detail1[1].mmaz003,s_detail1[1].mmaz004,s_detail1[1].mmaz005,s_detail1[1].mmaz001,s_detail1[1].mmaz006, 
               s_detail1[1].mmaz007,s_detail1[1].mmaz008,s_detail1[1].mmaz009
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmazseq
            #add-point:BEFORE FIELD mmazseq name="construct.b.page1.mmazseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmazseq
            
            #add-point:AFTER FIELD mmazseq name="construct.a.page1.mmazseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmazseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmazseq
            #add-point:ON ACTION controlp INFIELD mmazseq name="construct.c.page1.mmazseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmazsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmazsite
            #add-point:ON ACTION controlp INFIELD mmazsite name="construct.c.page1.mmazsite"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmazsite  #顯示到畫面上

            NEXT FIELD mmazsite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmazsite
            #add-point:BEFORE FIELD mmazsite name="construct.b.page1.mmazsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmazsite
            
            #add-point:AFTER FIELD mmazsite name="construct.a.page1.mmazsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz000
            #add-point:BEFORE FIELD mmaz000 name="construct.b.page1.mmaz000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz000
            
            #add-point:AFTER FIELD mmaz000 name="construct.a.page1.mmaz000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmaz000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz000
            #add-point:ON ACTION controlp INFIELD mmaz000 name="construct.c.page1.mmaz000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mmaz002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz002
            #add-point:ON ACTION controlp INFIELD mmaz002 name="construct.c.page1.mmaz002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaz002  #顯示到畫面上

            NEXT FIELD mmaz002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz002
            #add-point:BEFORE FIELD mmaz002 name="construct.b.page1.mmaz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz002
            
            #add-point:AFTER FIELD mmaz002 name="construct.a.page1.mmaz002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmaz003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz003
            #add-point:ON ACTION controlp INFIELD mmaz003 name="construct.c.page1.mmaz003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaz003  #顯示到畫面上

            NEXT FIELD mmaz003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz003
            #add-point:BEFORE FIELD mmaz003 name="construct.b.page1.mmaz003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz003
            
            #add-point:AFTER FIELD mmaz003 name="construct.a.page1.mmaz003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmaz004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz004
            #add-point:ON ACTION controlp INFIELD mmaz004 name="construct.c.page1.mmaz004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004_3()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmaz004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaz004',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = '8'
               CALL q_ooed004_3()    
            END IF
            DISPLAY g_qryparam.return1 TO mmaz004  #顯示到畫面上
            LET g_qryparam.arg2 = null
            NEXT FIELD mmaz004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz004
            #add-point:BEFORE FIELD mmaz004 name="construct.b.page1.mmaz004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz004
            
            #add-point:AFTER FIELD mmaz004 name="construct.a.page1.mmaz004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmaz005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz005
            #add-point:ON ACTION controlp INFIELD mmaz005 name="construct.c.page1.mmaz005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaz005  #顯示到畫面上

            NEXT FIELD mmaz005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz005
            #add-point:BEFORE FIELD mmaz005 name="construct.b.page1.mmaz005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz005
            
            #add-point:AFTER FIELD mmaz005 name="construct.a.page1.mmaz005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmaz001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz001
            #add-point:ON ACTION controlp INFIELD mmaz001 name="construct.c.page1.mmaz001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_type='1' THEN

               CALL q_mman001()                                #呼叫開窗
            END IF
            IF g_type='2' THEN
               CALL q_gcaf001()
            END IF
            DISPLAY g_qryparam.return1 TO mmaz001  #顯示到畫面上

            NEXT FIELD mmaz001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz001
            #add-point:BEFORE FIELD mmaz001 name="construct.b.page1.mmaz001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz001
            
            #add-point:AFTER FIELD mmaz001 name="construct.a.page1.mmaz001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz006
            #add-point:BEFORE FIELD mmaz006 name="construct.b.page1.mmaz006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz006
            
            #add-point:AFTER FIELD mmaz006 name="construct.a.page1.mmaz006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmaz006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz006
            #add-point:ON ACTION controlp INFIELD mmaz006 name="construct.c.page1.mmaz006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz007
            #add-point:BEFORE FIELD mmaz007 name="construct.b.page1.mmaz007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz007
            
            #add-point:AFTER FIELD mmaz007 name="construct.a.page1.mmaz007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmaz007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz007
            #add-point:ON ACTION controlp INFIELD mmaz007 name="construct.c.page1.mmaz007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz008
            #add-point:BEFORE FIELD mmaz008 name="construct.b.page1.mmaz008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz008
            
            #add-point:AFTER FIELD mmaz008 name="construct.a.page1.mmaz008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmaz008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz008
            #add-point:ON ACTION controlp INFIELD mmaz008 name="construct.c.page1.mmaz008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz009
            #add-point:BEFORE FIELD mmaz009 name="construct.b.page1.mmaz009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz009
            
            #add-point:AFTER FIELD mmaz009 name="construct.a.page1.mmaz009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmaz009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz009
            #add-point:ON ACTION controlp INFIELD mmaz009 name="construct.c.page1.mmaz009"
            
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
                  WHEN la_wc[li_idx].tableid = "mmay_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmaz_t" 
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
 
{<section id="ammt402.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION ammt402_filter()
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
      CONSTRUCT g_wc_filter ON mmaydocno,mmaydocdt,mmaysite,mmay001,mmay002,mmay003
                          FROM s_browse[1].b_mmaydocno,s_browse[1].b_mmaydocdt,s_browse[1].b_mmaysite, 
                              s_browse[1].b_mmay001,s_browse[1].b_mmay002,s_browse[1].b_mmay003
 
         BEFORE CONSTRUCT
               DISPLAY ammt402_filter_parser('mmaydocno') TO s_browse[1].b_mmaydocno
            DISPLAY ammt402_filter_parser('mmaydocdt') TO s_browse[1].b_mmaydocdt
            DISPLAY ammt402_filter_parser('mmaysite') TO s_browse[1].b_mmaysite
            DISPLAY ammt402_filter_parser('mmay001') TO s_browse[1].b_mmay001
            DISPLAY ammt402_filter_parser('mmay002') TO s_browse[1].b_mmay002
            DISPLAY ammt402_filter_parser('mmay003') TO s_browse[1].b_mmay003
      
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
 
      CALL ammt402_filter_show('mmaydocno')
   CALL ammt402_filter_show('mmaydocdt')
   CALL ammt402_filter_show('mmaysite')
   CALL ammt402_filter_show('mmay001')
   CALL ammt402_filter_show('mmay002')
   CALL ammt402_filter_show('mmay003')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt402.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION ammt402_filter_parser(ps_field)
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
 
{<section id="ammt402.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION ammt402_filter_show(ps_field)
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
   LET ls_condition = ammt402_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ammt402.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION ammt402_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
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
   CALL g_mmaz_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL ammt402_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL ammt402_browser_fill("")
      CALL ammt402_fetch("")
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
      CALL ammt402_filter_show('mmaydocno')
   CALL ammt402_filter_show('mmaydocdt')
   CALL ammt402_filter_show('mmaysite')
   CALL ammt402_filter_show('mmay001')
   CALL ammt402_filter_show('mmay002')
   CALL ammt402_filter_show('mmay003')
   CALL ammt402_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL ammt402_fetch("F") 
      #顯示單身筆數
      CALL ammt402_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt402.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION ammt402_fetch(p_flag)
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
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_mmay_m.mmaydocno = g_browser[g_current_idx].b_mmaydocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE ammt402_master_referesh USING g_mmay_m.mmaydocno INTO g_mmay_m.mmaysite,g_mmay_m.mmaydocdt, 
       g_mmay_m.mmaydocno,g_mmay_m.mmayunit,g_mmay_m.mmay001,g_mmay_m.mmay002,g_mmay_m.mmay003,g_mmay_m.mmay000, 
       g_mmay_m.mmaystus,g_mmay_m.mmayownid,g_mmay_m.mmayowndp,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtdp, 
       g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymoddt,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfdt, 
       g_mmay_m.mmaysite_desc,g_mmay_m.mmay001_desc,g_mmay_m.mmay002_desc,g_mmay_m.mmay003_desc,g_mmay_m.mmayownid_desc, 
       g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid_desc,g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaymodid_desc, 
       g_mmay_m.mmaycnfid_desc
   
   #遮罩相關處理
   LET g_mmay_m_mask_o.* =  g_mmay_m.*
   CALL ammt402_mmay_t_mask()
   LET g_mmay_m_mask_n.* =  g_mmay_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt402_set_act_visible()   
   CALL ammt402_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#   IF g_mmay_m.mmaystus <> "N" THEN
#      CALL cl_set_act_visible("delete,modify", FALSE) 
#   ELSE
#      CALL cl_set_act_visible("delete,modify", TRUE)     
#   END IF
   IF g_mmay_m.mmaystus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", true)   
   END IF

   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mmay_m_t.* = g_mmay_m.*
   LET g_mmay_m_o.* = g_mmay_m.*
   
   LET g_data_owner = g_mmay_m.mmayownid      
   LET g_data_dept  = g_mmay_m.mmayowndp
   
   #重新顯示   
   CALL ammt402_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt402.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammt402_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mmaz_d.clear()   
 
 
   INITIALIZE g_mmay_m.* TO NULL             #DEFAULT 設定
   
   LET g_mmaydocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmay_m.mmayownid = g_user
      LET g_mmay_m.mmayowndp = g_dept
      LET g_mmay_m.mmaycrtid = g_user
      LET g_mmay_m.mmaycrtdp = g_dept 
      LET g_mmay_m.mmaycrtdt = cl_get_current()
      LET g_mmay_m.mmaymodid = g_user
      LET g_mmay_m.mmaymoddt = cl_get_current()
      LET g_mmay_m.mmaystus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mmay_m.mmaystus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_mmay_m_t.* TO NULL
      let g_mmay_m.mmay000=g_type
      LET g_mmay_m.mmaystus = "N"
      LET g_mmay_m.mmaydocdt = g_today
#      LET g_mmay_m.mmaysite = g_site
      CALL s_aooi500_default(g_prog,'mmaysite',g_mmay_m.mmaysite)
         RETURNING l_insert,g_mmay_m.mmaysite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_mmay_m.mmayunit = g_mmay_m.mmaysite
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmay_m.mmaysite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmay_m.mmaysite_desc =  g_rtn_fields[1]
      DISPLAY BY NAME g_mmay_m.mmaysite_desc
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_mmay_m.mmaysite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_mmay_m.mmaydocno = l_doctype
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mmay_m_t.* = g_mmay_m.*
      LET g_mmay_m_o.* = g_mmay_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmay_m.mmaystus 
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
 
 
 
    
      CALL ammt402_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
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
         INITIALIZE g_mmay_m.* TO NULL
         INITIALIZE g_mmaz_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL ammt402_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mmaz_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL ammt402_set_act_visible()   
   CALL ammt402_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmaydocno_t = g_mmay_m.mmaydocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmayent = " ||g_enterprise|| " AND",
                      " mmaydocno = '", g_mmay_m.mmaydocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt402_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE ammt402_cl
   
   CALL ammt402_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE ammt402_master_referesh USING g_mmay_m.mmaydocno INTO g_mmay_m.mmaysite,g_mmay_m.mmaydocdt, 
       g_mmay_m.mmaydocno,g_mmay_m.mmayunit,g_mmay_m.mmay001,g_mmay_m.mmay002,g_mmay_m.mmay003,g_mmay_m.mmay000, 
       g_mmay_m.mmaystus,g_mmay_m.mmayownid,g_mmay_m.mmayowndp,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtdp, 
       g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymoddt,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfdt, 
       g_mmay_m.mmaysite_desc,g_mmay_m.mmay001_desc,g_mmay_m.mmay002_desc,g_mmay_m.mmay003_desc,g_mmay_m.mmayownid_desc, 
       g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid_desc,g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaymodid_desc, 
       g_mmay_m.mmaycnfid_desc
   
   
   #遮罩相關處理
   LET g_mmay_m_mask_o.* =  g_mmay_m.*
   CALL ammt402_mmay_t_mask()
   LET g_mmay_m_mask_n.* =  g_mmay_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmay_m.mmaysite,g_mmay_m.mmaysite_desc,g_mmay_m.mmaydocdt,g_mmay_m.mmaydocno,g_mmay_m.mmayunit, 
       g_mmay_m.mmay001,g_mmay_m.mmay001_desc,g_mmay_m.mmay002,g_mmay_m.mmay002_desc,g_mmay_m.mmay003, 
       g_mmay_m.mmay003_desc,g_mmay_m.mmay000,g_mmay_m.mmaystus,g_mmay_m.mmayownid,g_mmay_m.mmayownid_desc, 
       g_mmay_m.mmayowndp,g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtid_desc,g_mmay_m.mmaycrtdp, 
       g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymodid_desc,g_mmay_m.mmaymoddt, 
       g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfid_desc,g_mmay_m.mmaycnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mmay_m.mmayownid      
   LET g_data_dept  = g_mmay_m.mmayowndp
   
   #功能已完成,通報訊息中心
   CALL ammt402_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammt402_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_mmay_m.mmaystus MATCHES "[DR]" THEN 
      LET  g_mmay_m.mmaystus = "N"
   END IF
   IF g_mmay_m.mmaystus <>'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "apm-00035"
      LET g_errparam.extend = g_mmay_m.mmaydocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mmay_m_t.* = g_mmay_m.*
   LET g_mmay_m_o.* = g_mmay_m.*
   
   IF g_mmay_m.mmaydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mmaydocno_t = g_mmay_m.mmaydocno
 
   CALL s_transaction_begin()
   
   OPEN ammt402_cl USING g_enterprise,g_mmay_m.mmaydocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt402_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt402_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt402_master_referesh USING g_mmay_m.mmaydocno INTO g_mmay_m.mmaysite,g_mmay_m.mmaydocdt, 
       g_mmay_m.mmaydocno,g_mmay_m.mmayunit,g_mmay_m.mmay001,g_mmay_m.mmay002,g_mmay_m.mmay003,g_mmay_m.mmay000, 
       g_mmay_m.mmaystus,g_mmay_m.mmayownid,g_mmay_m.mmayowndp,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtdp, 
       g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymoddt,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfdt, 
       g_mmay_m.mmaysite_desc,g_mmay_m.mmay001_desc,g_mmay_m.mmay002_desc,g_mmay_m.mmay003_desc,g_mmay_m.mmayownid_desc, 
       g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid_desc,g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaymodid_desc, 
       g_mmay_m.mmaycnfid_desc
   
   #檢查是否允許此動作
   IF NOT ammt402_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmay_m_mask_o.* =  g_mmay_m.*
   CALL ammt402_mmay_t_mask()
   LET g_mmay_m_mask_n.* =  g_mmay_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL ammt402_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_mmaydocno_t = g_mmay_m.mmaydocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mmay_m.mmaymodid = g_user 
LET g_mmay_m.mmaymoddt = cl_get_current()
LET g_mmay_m.mmaymodid_desc = cl_get_username(g_mmay_m.mmaymodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_mmay_m.mmaystus MATCHES "[DR]" THEN 
         LET  g_mmay_m.mmaystus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL ammt402_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mmay_t SET (mmaymodid,mmaymoddt) = (g_mmay_m.mmaymodid,g_mmay_m.mmaymoddt)
          WHERE mmayent = g_enterprise AND mmaydocno = g_mmaydocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mmay_m.* = g_mmay_m_t.*
            CALL ammt402_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mmay_m.mmaydocno != g_mmay_m_t.mmaydocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mmaz_t SET mmazdocno = g_mmay_m.mmaydocno
 
          WHERE mmazent = g_enterprise AND mmazdocno = g_mmay_m_t.mmaydocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmaz_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
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
   CALL ammt402_set_act_visible()   
   CALL ammt402_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mmayent = " ||g_enterprise|| " AND",
                      " mmaydocno = '", g_mmay_m.mmaydocno, "' "
 
   #填到對應位置
   CALL ammt402_browser_fill("")
 
   CLOSE ammt402_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt402_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="ammt402.input" >}
#+ 資料輸入
PRIVATE FUNCTION ammt402_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
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
   DISPLAY BY NAME g_mmay_m.mmaysite,g_mmay_m.mmaysite_desc,g_mmay_m.mmaydocdt,g_mmay_m.mmaydocno,g_mmay_m.mmayunit, 
       g_mmay_m.mmay001,g_mmay_m.mmay001_desc,g_mmay_m.mmay002,g_mmay_m.mmay002_desc,g_mmay_m.mmay003, 
       g_mmay_m.mmay003_desc,g_mmay_m.mmay000,g_mmay_m.mmaystus,g_mmay_m.mmayownid,g_mmay_m.mmayownid_desc, 
       g_mmay_m.mmayowndp,g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtid_desc,g_mmay_m.mmaycrtdp, 
       g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymodid_desc,g_mmay_m.mmaymoddt, 
       g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfid_desc,g_mmay_m.mmaycnfdt
   
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
   LET g_forupd_sql = "SELECT mmazseq,mmazsite,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006, 
       mmaz007,mmaz008,mmaz009,mmazunit FROM mmaz_t WHERE mmazent=? AND mmazdocno=? AND mmazseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt402_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL ammt402_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL ammt402_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mmay_m.mmaysite,g_mmay_m.mmaydocdt,g_mmay_m.mmaydocno,g_mmay_m.mmayunit,g_mmay_m.mmay001, 
       g_mmay_m.mmay002,g_mmay_m.mmay003,g_mmay_m.mmay000,g_mmay_m.mmaystus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   let g_errshow=1
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent = g_enterprise 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="ammt402.input.head" >}
      #單頭段
      INPUT BY NAME g_mmay_m.mmaysite,g_mmay_m.mmaydocdt,g_mmay_m.mmaydocno,g_mmay_m.mmayunit,g_mmay_m.mmay001, 
          g_mmay_m.mmay002,g_mmay_m.mmay003,g_mmay_m.mmay000,g_mmay_m.mmaystus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN ammt402_cl USING g_enterprise,g_mmay_m.mmaydocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt402_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt402_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL ammt402_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            LET g_mmay_m_t.* = g_mmay_m.*
            CALL ammt402_set_entry(p_cmd)
            CALL ammt402_set_no_entry(p_cmd)
            #let g_mmaydocno_t = g_mmay_m.mmaydocno       #150525-00013#1
            #end add-point
            CALL ammt402_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaysite
            
            #add-point:AFTER FIELD mmaysite name="input.a.mmaysite"
            #此段落由子樣板a05產生
            LET g_mmay_m.mmaysite_desc = NULL
            DISPLAY BY NAME g_mmay_m.mmaysite_desc
            
            IF NOT cl_null(g_mmay_m.mmaysite) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmay_m.mmaysite!= g_mmay_m_t.mmaysite OR g_mmay_m_t.mmaysite IS NULL  ))) THEN #160824-00007#121 by sakura mark
               IF g_mmay_m.mmaysite != g_mmay_m_o.mmaysite OR cl_null(g_mmay_m_o.mmaysite) THEN #160824-00007#121 by sakura add
#                  CALL ammt402_mmay001(g_mmay_m.mmaysite)
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_mmay_m.mmaysite,g_errno,1)
#                     LET g_mmay_m.mmaysite = g_mmay_m_t.mmaysite
#                     CALL ammt402_display_mmaysite()
#                     NEXT FIELD mmaysite
#                  END IF
#                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
# 
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_mmay_m.mmaysite
#                  LET g_chkparam.arg2 = '8'
#                  LET g_chkparam.arg3 = g_site
#
#
#                  #呼叫檢查存在並帶值的library
#                  IF cl_chk_exist("v_ooed004") THEN
#
#                  ELSE
#                     #檢查失敗時後續處理
#                     LET g_mmay_m.mmaysite = g_mmay_m_t.mmaysite
#                     CALL ammt402_display_mmaysite()
#                     NEXT FIELD mmaysite
#                  END IF
                  CALL s_aooi500_chk(g_prog,'mmaysite',g_mmay_m.mmaysite,g_mmay_m.mmaysite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_mmay_m.mmaysite
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     #LET g_mmay_m.mmaysite = g_mmay_m_t.mmaysite #160824-00007#121 by sakura mark
                     LET g_mmay_m.mmaysite = g_mmay_m_o.mmaysite  #160824-00007#121 by sakura add
                     CALL ammt402_display_mmaysite()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL ammt402_display_mmaysite()
            LET g_mmay_m_o.* = g_mmay_m.*   #160824-00007#121 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaysite
            #add-point:BEFORE FIELD mmaysite name="input.b.mmaysite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaysite
            #add-point:ON CHANGE mmaysite name="input.g.mmaysite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaydocdt
            #add-point:BEFORE FIELD mmaydocdt name="input.b.mmaydocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaydocdt
            
            #add-point:AFTER FIELD mmaydocdt name="input.a.mmaydocdt"
#            IF cl_null(g_mmay_m.mmaydocno) THEN
#               NEXT FIELD mmaydocno
#            END IF
#            IF cl_null(g_mmay_m.mmaydocdt) THEN
#               NEXT FIELD mmaydocdt
#            END IF
#            
#            CALL cl_set_comp_entry("mmaydocno,mmaydocdt",FALSE)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaydocdt
            #add-point:ON CHANGE mmaydocdt name="input.g.mmaydocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaydocno
            #add-point:BEFORE FIELD mmaydocno name="input.b.mmaydocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaydocno
            
            #add-point:AFTER FIELD mmaydocno name="input.a.mmaydocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmay_m.mmaydocno)  THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmay_m.mmaydocno != g_mmaydocno_t  ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmay_t WHERE "||"mmayent = '" ||g_enterprise|| "' AND "||"mmaydocno = '"||g_mmay_m.mmaydocno ||"' ",'std-00004',0) THEN 
                     LET g_mmay_m.mmaydocno = g_mmaydocno_t
                     NEXT FIELD mmaydocno
                  END IF
#                  CALL ammt402_mmaydocno(g_mmay_m.mmaydocno)
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_mmay_m.mmaydocno,g_errno,1)
#                     LET g_mmay_m.mmaydocno = g_mmaydocno_t
#                     NEXT FIELD mmaydocno
#                  END IF
                  CALL s_aooi200_chk_slip(g_site,g_ooef004,g_mmay_m.mmaydocno,g_prog) RETURNING l_success
                  IF NOT l_success THEN
                     LET g_mmay_m.mmaydocno = g_mmaydocno_t
                     NEXT FIELD mmaydocno
                  END IF
               END IF
            END IF
#            NEXT FIELD mmaydocdt


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaydocno
            #add-point:ON CHANGE mmaydocno name="input.g.mmaydocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmayunit
            #add-point:BEFORE FIELD mmayunit name="input.b.mmayunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmayunit
            
            #add-point:AFTER FIELD mmayunit name="input.a.mmayunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmayunit
            #add-point:ON CHANGE mmayunit name="input.g.mmayunit"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmay001
            
            #add-point:AFTER FIELD mmay001 name="input.a.mmay001"
            LET g_mmay_m.mmay001_desc = null
            DISPLAY BY NAME g_mmay_m.mmay001_desc
            IF NOT cl_null(g_mmay_m.mmay001)  THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmay_m.mmay001 != g_mmay_m_t.mmay001 or g_mmay_m_t.mmay001 is null))) THEN #160824-00007#121 by sakura mark
               IF g_mmay_m.mmay001 != g_mmay_m_o.mmay001 OR cl_null(g_mmay_m_o.mmay001) THEN #160824-00007#121 by sakura add 
#                  CALL ammt402_mmay001(g_mmay_m.mmay001)
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_mmay_m.mmay001
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_mmay_m.mmay001 = g_mmay_m_t.mmay001
#                     CALL ammt402_display_mmay001()
#                     NEXT FIELD mmay001
#                  END IF
                  IF s_aooi500_setpoint(g_prog,'mmay001') THEN
                     CALL s_aooi500_chk(g_prog,'mmay001',g_mmay_m.mmay001,g_mmay_m.mmaysite) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_mmay_m.mmay001
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                     
                        #LET g_mmay_m.mmay001 = g_mmay_m_t.mmay001 #160824-00007#121 by sakura mark
                        LET g_mmay_m.mmay001 = g_mmay_m_o.mmay001  #160824-00007#121 by sakura add
                        CALL ammt402_display_mmay001()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     CALL ammt402_mmay001(g_mmay_m.mmay001)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_mmay_m.mmay001
                        #160318-00005#24  --add--str
                        LET g_errparam.replace[1] ='aooi100'
                        LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                        LET g_errparam.exeprog    ='aooi100'
                        #160318-00005#24 --add--end
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        #LET g_mmay_m.mmay001 = g_mmay_m_t.mmay001 #160824-00007#121 by sakura mark
                        LET g_mmay_m.mmay001 = g_mmay_m_o.mmay001  #160824-00007#121 by sakura add
                        CALL ammt402_display_mmay001()
                        NEXT FIELD mmay001
                     END IF
                  END IF
#                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
#
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_mmay_m.mmay001
#                  LET g_chkparam.arg2 = '8'
#
#
#                  #呼叫檢查存在並帶值的library
#                  IF cl_chk_exist("v_ooed004_1") THEN
#
#                  ELSE
#                     #檢查失敗時後續處理
#                     LET g_mmay_m.mmay001 = g_mmay_m_t.mmay001
#                     CALL ammt402_display_mmay001()
#                     NEXT FIELD mmay001
#                  END IF
               END IF
            END IF
            
            #160604-00009#50 -e by 08172
            CALL ammt402_display_mmay001()
            LET g_mmay_m_o.* = g_mmay_m.*   #160824-00007#121 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmay001
            #add-point:BEFORE FIELD mmay001 name="input.b.mmay001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmay001
            #add-point:ON CHANGE mmay001 name="input.g.mmay001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmay002
            
            #add-point:AFTER FIELD mmay002 name="input.a.mmay002"
            LET g_mmay_m.mmay002_desc = null
            DISPLAY BY NAME g_mmay_m.mmay002_desc
            
            IF NOT cl_null(g_mmay_m.mmay002)  THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmay_m.mmay002 ! = g_mmay_m_t.mmay002 or g_mmay_m_t.mmay002 is null ))) THEN #160824-00007#121 by sakura mark
               IF g_mmay_m.mmay002 != g_mmay_m_o.mmay002 OR cl_null(g_mmay_m_o.mmay002) THEN #160824-00007#121 by sakura add
#                  CALL ammt402_mmay001(g_mmay_m.mmay002)
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_mmay_m.mmay002
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_mmay_m.mmay002 = g_mmay_m_t.mmay002
#                     CALL ammt402_display_mmay002()
#                     NEXT FIELD mmay002
#                  END IF
                  IF s_aooi500_setpoint(g_prog,'mmay002') THEN
                     CALL s_aooi500_chk(g_prog,'mmay002',g_mmay_m.mmay002,g_mmay_m.mmaysite) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_mmay_m.mmay002
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                     
                        #LET g_mmay_m.mmay002 = g_mmay_m_t.mmay002 #160824-00007#121 by sakura mark
                        #160824-00007#121 by sakura add(S)
                        LET g_mmay_m.mmay002 = g_mmay_m_o.mmay002
                        LET g_mmay_m.mmay003 = g_mmay_m_o.mmay003
                        #160824-00007#121 by sakura add(E)
                        CALL ammt402_display_mmay002()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     CALL ammt402_mmay001(g_mmay_m.mmay002)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_mmay_m.mmay002
                        #160318-00005#24  --add--str
                        LET g_errparam.replace[1] ='aooi100'
                        LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                        LET g_errparam.exeprog    ='aooi100'
                        #160318-00005#24 --add--end
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        #LET g_mmay_m.mmay002 = g_mmay_m_t.mmay002 #160824-00007#121 by sakura mark
                        #160824-00007#121 by sakura add(S)
                        LET g_mmay_m.mmay002 = g_mmay_m_o.mmay002
                        LET g_mmay_m.mmay003 = g_mmay_m_o.mmay003
                        #160824-00007#121 by sakura add(E)
                        CALL ammt402_display_mmay002()
                        NEXT FIELD mmay002
                     END IF
                  END IF
#                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
#
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_mmay_m.mmay002
#                  LET g_chkparam.arg2 = '8'
#
#
#                  #呼叫檢查存在並帶值的library
#                  IF cl_chk_exist("v_ooed004_1") THEN
#
#                  ELSE
#                     #檢查失敗時後續處理
#                     LET g_mmay_m.mmay002 = g_mmay_m_t.mmay002
#                     CALL ammt402_display_mmay002()
#                     NEXT FIELD mmay002
#                  END IF
               END IF
            END IF
            #160604-00009#50 -s by 08172
            CALL s_artt220_default(g_mmay_m.mmay002,'6') RETURNING l_success,g_mmay_m.mmay003
            CALL ammt402_display_mmay003()
            #160604-00009#50 -e by 08172
            CALL ammt402_mmay003_after()
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_mmay_m.mmay002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               #LET g_mmay_m.mmay002 = g_mmay_m_t.mmay002 #160824-00007#121 by sakura mark
               #160824-00007#121 by sakura add(S)
               LET g_mmay_m.mmay002 = g_mmay_m_o.mmay002
               LET g_mmay_m.mmay003 = g_mmay_m_o.mmay003
               #160824-00007#121 by sakura add(E)
               CALL ammt402_display_mmay002()
               NEXT FIELD mmay002
            END IF
            call ammt402_set_entry(p_cmd)
            call ammt402_set_no_entry(p_cmd)
            CALL ammt402_display_mmay002()
            LET g_mmay_m_o.* = g_mmay_m.*   #160824-00007#121 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmay002
            #add-point:BEFORE FIELD mmay002 name="input.b.mmay002"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmay002
            #add-point:ON CHANGE mmay002 name="input.g.mmay002"
            call ammt402_set_entry(p_cmd)
            call ammt402_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmay003
            
            #add-point:AFTER FIELD mmay003 name="input.a.mmay003"
            LET g_mmay_m.mmay003_desc = null
            display by name g_mmay_m.mmay003_desc
            
            IF NOT cl_null(g_mmay_m.mmay003)  THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmay_m.mmay003 ! = g_mmay_m_t.mmay003 or g_mmay_m_t.mmay003 is null))) THEN #160824-00007#121 by sakura mark
               IF g_mmay_m.mmay003 != g_mmay_m_o.mmay003 OR cl_null(g_mmay_m_o.mmay003) THEN #160824-00007#121 by sakura add
                 #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mmay_m.mmay002
                  LET g_chkparam.arg2 = g_mmay_m.mmay003

                  #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#20  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inaa001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     #LET g_mmay_m.mmay003 = g_mmay_m_t.mmay003 #160824-00007#121 by sakura mark
                     LET g_mmay_m.mmay003 = g_mmay_m_o.mmay003  #160824-00007#121 by sakura add
                     call ammt402_display_mmay003()
                     NEXT FIELD mmay003
                  END IF
#                  CALL ammt402_mmay003(g_mmay_m.mmay003,g_mmay_m.mmay002)
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = g_errno
#               LET g_errparam.extend = g_mmay_m.mmay003
#               LET g_errparam.popup = TRUE
#               CALL cl_err()

#                     LET g_mmay_m.mmay003 = g_mmay_m_t.mmay003
#                     call ammt402_display_mmay003()
#                     NEXT FIELD mmay003
#                  END IF
               END IF
            END IF
            CALL ammt402_mmay003_after()
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_mmay_m.mmay003
               LET g_errparam.popup = TRUE
               CALL cl_err()

               #LET g_mmay_m.mmay003 = g_mmay_m_t.mmay003 #160824-00007#121 by sakura mark
               LET g_mmay_m.mmay003 = g_mmay_m_o.mmay003  #160824-00007#121 by sakura add
               call ammt402_display_mmay003()
               NEXT FIELD mmay002
            END IF
            call ammt402_display_mmay003()
            LET g_mmay_m_o.* = g_mmay_m.*   #160824-00007#121 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmay003
            #add-point:BEFORE FIELD mmay003 name="input.b.mmay003"
            CALL ammt402_set_entry(p_cmd)
            CALL ammt402_set_no_entry(p_cmd)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmay003
            #add-point:ON CHANGE mmay003 name="input.g.mmay003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmay000
            #add-point:BEFORE FIELD mmay000 name="input.b.mmay000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmay000
            
            #add-point:AFTER FIELD mmay000 name="input.a.mmay000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmay000
            #add-point:ON CHANGE mmay000 name="input.g.mmay000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaystus
            #add-point:BEFORE FIELD mmaystus name="input.b.mmaystus"
     
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaystus
            
            #add-point:AFTER FIELD mmaystus name="input.a.mmaystus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaystus
            #add-point:ON CHANGE mmaystus name="input.g.mmaystus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mmaysite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaysite
            #add-point:ON ACTION controlp INFIELD mmaysite name="input.c.mmaysite"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay_m.mmaysite             #給予default值
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = '8'
#            #給予arg
#
#            CALL q_ooed004_3()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaysite',g_mmay_m.mmaysite,'i') #150308-00001#3 150309 pomelo add 'i'
            CALL q_ooef001_24()

            LET g_mmay_m.mmaysite = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.arg1 = null
            LET g_qryparam.arg2 = null
            DISPLAY g_mmay_m.mmaysite TO mmaysite              #顯示到畫面上
            CALL ammt402_display_mmaysite()
            NEXT FIELD mmaysite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmaydocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaydocdt
            #add-point:ON ACTION controlp INFIELD mmaydocdt name="input.c.mmaydocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaydocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaydocno
            #add-point:ON ACTION controlp INFIELD mmaydocno name="input.c.mmaydocno"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay_m.mmaydocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #參照表編號
            LET g_qryparam.arg2 = g_prog #對應程式代號

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_mmay_m.mmaydocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmay_m.mmaydocno TO mmaydocno              #顯示到畫面上

            NEXT FIELD mmaydocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmayunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmayunit
            #add-point:ON ACTION controlp INFIELD mmayunit name="input.c.mmayunit"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay_m.mmayunit             #給予default值

            #給予arg

            CALL q_ooef001()                                #呼叫開窗

            LET g_mmay_m.mmayunit = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmay_m.mmayunit TO mmayunit              #顯示到畫面上

            NEXT FIELD mmayunit                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmay001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmay001
            #add-point:ON ACTION controlp INFIELD mmay001 name="input.c.mmay001"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay_m.mmay001             #給予default值
#            LET g_qryparam.where = " ooef201 = 'Y' "
#            #給予arg
#
#            CALL q_ooef001()                                #呼叫開窗
            
            IF s_aooi500_setpoint(g_prog,'mmay001') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmay001',g_mmay_m.mmaysite,'i') #150308-00001#3 150309 pomelo add 'i'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001() 
            END IF

            LET g_mmay_m.mmay001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.arg1 = null
            DISPLAY g_mmay_m.mmay001 TO mmay001              #顯示到畫面上
            CALL ammt402_display_mmay001()
            NEXT FIELD mmay001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmay002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmay002
            #add-point:ON ACTION controlp INFIELD mmay002 name="input.c.mmay002"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay_m.mmay002             #給予default值
#            LET g_qryparam.where = " ooef201 = 'Y' "
#            #給予arg
#
#            CALL q_ooef001()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmay002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmay002',g_mmay_m.mmaysite,'i') #150308-00001#3 150309 pomelo add 'i'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001() 
            END IF

            LET g_mmay_m.mmay002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.arg1 = null
            DISPLAY g_mmay_m.mmay002 TO mmay002              #顯示到畫面上
            CALL ammt402_display_mmay002()
            NEXT FIELD mmay002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmay003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmay003
            #add-point:ON ACTION controlp INFIELD mmay003 name="input.c.mmay003"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmay_m.mmay003             #給予default值
            
            LET g_qryparam.arg1 = g_mmay_m.mmay002
  
            #給予arg

            CALL q_inaa001_6()                                #呼叫開窗

            LET g_mmay_m.mmay003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.arg1 = NULL  
            DISPLAY g_mmay_m.mmay003 TO mmay003              #顯示到畫面上
            CALL ammt402_display_mmay003()
            NEXT FIELD mmay003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmay000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmay000
            #add-point:ON ACTION controlp INFIELD mmay000 name="input.c.mmay000"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmaystus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaystus
            #add-point:ON ACTION controlp INFIELD mmaystus name="input.c.mmaystus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mmay_m.mmaydocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                  IF NOT cl_null(g_mmay_m.mmaydocno) THEN
                     CALL s_aooi200_gen_docno(g_site,g_mmay_m.mmaydocno,g_mmay_m.mmaydocdt,g_prog) 
                     RETURNING  g_success,g_mmay_m.mmaydocno
                     IF g_success<>'1' THEN
                        INITIALIZE g_errparam TO NULL
LET g_errparam.code = "amm-00001"
LET g_errparam.extend = g_mmay_m.mmaydocno
LET g_errparam.popup = TRUE
CALL cl_err()

                        NEXT FIELD mmaydocno
                     ELSE
                        IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmay_t WHERE "||"mmayent = '" ||g_enterprise|| "'  AND "||"mmaydocno = '"||g_mmay_m.mmaydocno ||"'",'std-00004',0) THEN 
                           LET g_mmay_m.mmaydocno = g_mmaydocno_t
                           NEXT FIELD CURRENT
                        END IF    
                                      
                     END IF
                  END IF 
                  CALL cl_set_comp_entry("mmaydocno",false)
               #end add-point
               
               INSERT INTO mmay_t (mmayent,mmaysite,mmaydocdt,mmaydocno,mmayunit,mmay001,mmay002,mmay003, 
                   mmay000,mmaystus,mmayownid,mmayowndp,mmaycrtid,mmaycrtdp,mmaycrtdt,mmaymodid,mmaymoddt, 
                   mmaycnfid,mmaycnfdt)
               VALUES (g_enterprise,g_mmay_m.mmaysite,g_mmay_m.mmaydocdt,g_mmay_m.mmaydocno,g_mmay_m.mmayunit, 
                   g_mmay_m.mmay001,g_mmay_m.mmay002,g_mmay_m.mmay003,g_mmay_m.mmay000,g_mmay_m.mmaystus, 
                   g_mmay_m.mmayownid,g_mmay_m.mmayowndp,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtdp,g_mmay_m.mmaycrtdt, 
                   g_mmay_m.mmaymodid,g_mmay_m.mmaymoddt,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mmay_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL ammt402_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL ammt402_b_fill()
                  CALL ammt402_b_fill2('0')
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
               CALL ammt402_mmay_t_mask_restore('restore_mask_o')
               
               UPDATE mmay_t SET (mmaysite,mmaydocdt,mmaydocno,mmayunit,mmay001,mmay002,mmay003,mmay000, 
                   mmaystus,mmayownid,mmayowndp,mmaycrtid,mmaycrtdp,mmaycrtdt,mmaymodid,mmaymoddt,mmaycnfid, 
                   mmaycnfdt) = (g_mmay_m.mmaysite,g_mmay_m.mmaydocdt,g_mmay_m.mmaydocno,g_mmay_m.mmayunit, 
                   g_mmay_m.mmay001,g_mmay_m.mmay002,g_mmay_m.mmay003,g_mmay_m.mmay000,g_mmay_m.mmaystus, 
                   g_mmay_m.mmayownid,g_mmay_m.mmayowndp,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtdp,g_mmay_m.mmaycrtdt, 
                   g_mmay_m.mmaymodid,g_mmay_m.mmaymoddt,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfdt)
                WHERE mmayent = g_enterprise AND mmaydocno = g_mmaydocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mmay_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL ammt402_mmay_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mmay_m_t)
               LET g_log2 = util.JSON.stringify(g_mmay_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mmaydocno_t = g_mmay_m.mmaydocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="ammt402.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mmaz_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmaz_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt402_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mmaz_d.getLength()
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
            OPEN ammt402_cl USING g_enterprise,g_mmay_m.mmaydocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt402_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE ammt402_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmaz_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmaz_d[l_ac].mmazseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmaz_d_t.* = g_mmaz_d[l_ac].*  #BACKUP
               LET g_mmaz_d_o.* = g_mmaz_d[l_ac].*  #BACKUP
               CALL ammt402_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL ammt402_set_no_entry_b(l_cmd)
               IF NOT ammt402_lock_b("mmaz_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt402_bcl INTO g_mmaz_d[l_ac].mmazseq,g_mmaz_d[l_ac].mmazsite,g_mmaz_d[l_ac].mmaz000, 
                      g_mmaz_d[l_ac].mmaz002,g_mmaz_d[l_ac].mmaz003,g_mmaz_d[l_ac].mmaz004,g_mmaz_d[l_ac].mmaz005, 
                      g_mmaz_d[l_ac].mmaz001,g_mmaz_d[l_ac].mmaz006,g_mmaz_d[l_ac].mmaz007,g_mmaz_d[l_ac].mmaz008, 
                      g_mmaz_d[l_ac].mmaz009,g_mmaz_d[l_ac].mmazunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mmaz_d_t.mmazseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmaz_d_mask_o[l_ac].* =  g_mmaz_d[l_ac].*
                  CALL ammt402_mmaz_t_mask()
                  LET g_mmaz_d_mask_n[l_ac].* =  g_mmaz_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt402_show()
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
            INITIALIZE g_mmaz_d[l_ac].* TO NULL 
            INITIALIZE g_mmaz_d_t.* TO NULL 
            INITIALIZE g_mmaz_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #160604-00009#50 -s by 08172
            CALL s_artt220_default(g_mmay_m.mmaysite,'6')  RETURNING  l_success,g_mmaz_d[l_ac].mmaz005
            CALL ammt402_display_mmaz005()
            #160604-00009#50 -e by 08172
            #end add-point
            LET g_mmaz_d_t.* = g_mmaz_d[l_ac].*     #新輸入資料
            LET g_mmaz_d_o.* = g_mmaz_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt402_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL ammt402_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmaz_d[li_reproduce_target].* = g_mmaz_d[li_reproduce].*
 
               LET g_mmaz_d[li_reproduce_target].mmazseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_mmaz_d[l_ac].mmazsite = g_mmay_m.mmaysite
            LET g_mmaz_d[l_ac].mmazunit = g_mmay_m.mmayunit
            LET g_mmaz_d[l_ac].mmaz000 = g_mmay_m.mmay000
            LET g_mmaz_d[l_ac].mmaz002 = g_mmay_m.mmay002
            IF NOT cl_null(g_mmay_m.mmay003) THEN
               LET g_mmaz_d[l_ac].mmaz003 = g_mmay_m.mmay003
            END IF
            LET g_mmaz_d[l_ac].mmaz004 = g_mmay_m.mmaysite
            CALL ammt402_display_mmaz004()
            CALL ammt402_display_mmaz003()
            CALL ammt402_mmazseq()
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
            SELECT COUNT(1) INTO l_count FROM mmaz_t 
             WHERE mmazent = g_enterprise AND mmazdocno = g_mmay_m.mmaydocno
 
               AND mmazseq = g_mmaz_d[l_ac].mmazseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_m.mmaydocno
               LET gs_keys[2] = g_mmaz_d[g_detail_idx].mmazseq
               CALL ammt402_insert_b('mmaz_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mmaz_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt402_b_fill()
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
               LET gs_keys[01] = g_mmay_m.mmaydocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mmaz_d_t.mmazseq
 
            
               #刪除同層單身
               IF NOT ammt402_delete_b('mmaz_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt402_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT ammt402_key_delete_b(gs_keys,'mmaz_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE ammt402_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt402_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mmaz_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmaz_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmazseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmaz_d[l_ac].mmazseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mmazseq
            END IF 
 
 
 
            #add-point:AFTER FIELD mmazseq name="input.a.page1.mmazseq"
            IF g_mmaz_d[l_ac].mmazseq<=0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "aim-00003"
               LET g_errparam.extend = g_mmaz_d[l_ac].mmazseq
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_mmaz_d[l_ac].mmazseq = g_mmaz_d_t.mmazseq
               NEXT FIELD mmazseq               
            END IF

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmay_m.mmaydocno)  AND NOT cl_null(g_mmaz_d[l_ac].mmazseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmay_m.mmaydocno != g_mmaydocno_t  OR g_mmaz_d[l_ac].mmazseq != g_mmaz_d_t.mmazseq))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmaz_t WHERE "||"mmazent = '" ||g_enterprise|| "' AND "||"mmazdocno = '"||g_mmay_m.mmaydocno ||"'  AND "|| "mmazseq = '"||g_mmaz_d[l_ac].mmazseq ||"'",'std-00004',0) THEN 
                     LET g_mmaz_d[l_ac].mmazseq = g_mmaz_d_t.mmazseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mmaz_d[l_ac].mmaz002 = g_mmay_m.mmay002

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmazseq
            #add-point:BEFORE FIELD mmazseq name="input.b.page1.mmazseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmazseq
            #add-point:ON CHANGE mmazseq name="input.g.page1.mmazseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmazsite
            
            #add-point:AFTER FIELD mmazsite name="input.a.page1.mmazsite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaz_d[l_ac].mmazsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmaz_d[l_ac].mmazsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmaz_d[l_ac].mmazsite_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmazsite
            #add-point:BEFORE FIELD mmazsite name="input.b.page1.mmazsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmazsite
            #add-point:ON CHANGE mmazsite name="input.g.page1.mmazsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz000
            #add-point:BEFORE FIELD mmaz000 name="input.b.page1.mmaz000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz000
            
            #add-point:AFTER FIELD mmaz000 name="input.a.page1.mmaz000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz000
            #add-point:ON CHANGE mmaz000 name="input.g.page1.mmaz000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz002
            #add-point:BEFORE FIELD mmaz002 name="input.b.page1.mmaz002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz002
            
            #add-point:AFTER FIELD mmaz002 name="input.a.page1.mmaz002"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz002
            #add-point:ON CHANGE mmaz002 name="input.g.page1.mmaz002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz003
            
            #add-point:AFTER FIELD mmaz003 name="input.a.page1.mmaz003"
            LET g_mmaz_d[l_ac].mmaz003_desc = NULL
            DISPLAY g_mmaz_d[l_ac].mmaz003_desc TO s_detail1[l_ac].mmaz003_desc
            IF NOT cl_null(g_mmaz_d[l_ac].mmaz003) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmaz_d[l_ac].mmaz003 != g_mmaz_d_t.mmaz003 or g_mmaz_d_t.mmaz003 is null))) THEN #160824-00007#121 by sakura mark
               IF g_mmaz_d[l_ac].mmaz003 != g_mmaz_d_o.mmaz003 OR cl_null(g_mmaz_d_o.mmaz003) THEN #160824-00007#121 by sakura add
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mmay_m.mmay002
                  LET g_chkparam.arg2 = g_mmaz_d[l_ac].mmaz003

                  #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#20  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inaa001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     #LET g_mmaz_d[l_ac].mmaz003 = g_mmaz_d_t.mmaz003 #160824-00007#121 by sakura mark
                     LET g_mmaz_d[l_ac].mmaz003 = g_mmaz_d_o.mmaz003  #160824-00007#121 by sakura add
                     CALL ammt402_display_mmaz003()
                     NEXT FIELD mmaz003
                  END IF
#                  CALL ammt402_mmay003(g_mmaz_d[l_ac].mmaz003,g_mmay_m.mmay002)
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_mmaz_d[l_ac].mmaz003,g_errno,1)
#                     LET g_mmaz_d[l_ac].mmaz003 = g_mmaz_d_t.mmaz003
#                     CALL ammt402_display_mmaz003()
#                     NEXT FIELD mmaz003
#                  END IF
                  
               END IF
            END IF
            CALL ammt402_display_mmaz003()
            LET g_mmaz_d_o.* = g_mmaz_d[l_ac].*  #160824-00007#121 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz003
            #add-point:BEFORE FIELD mmaz003 name="input.b.page1.mmaz003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz003
            #add-point:ON CHANGE mmaz003 name="input.g.page1.mmaz003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz004
            
            #add-point:AFTER FIELD mmaz004 name="input.a.page1.mmaz004"
            LET g_mmaz_d[l_ac].mmaz004_desc = null
            DISPLAY  g_mmaz_d[l_ac].mmaz004_desc TO s_detail1[l_ac].mmaz004_desc
            IF NOT cl_null(g_mmaz_d[l_ac].mmaz004) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmaz_d[l_ac].mmaz004 != g_mmaz_d_t.mmaz004 or g_mmaz_d_t.mmaz004 is null))) THEN #160824-00007#121 by sakura mark
               IF g_mmaz_d[l_ac].mmaz004 != g_mmaz_d_o.mmaz004 OR cl_null(g_mmaz_d_o.mmaz004) THEN #160824-00007#121 by sakura add
#                  CALL ammt402_mmaz004(g_mmaz_d[l_ac].mmaz004)
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = g_errno
#                        LET g_errparam.extend = g_mmaz_d[l_ac].mmaz004
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()

#                     LET g_mmaz_d[l_ac].mmaz004 = g_mmaz_d_t.mmaz004
#                     CALL ammt402_display_mmaz004()
#                     NEXT FIELD mmaz004
#                  END IF
#                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
# 
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_mmaz_d[l_ac].mmaz004
#                  LET g_chkparam.arg2 = '8'
#                  LET g_chkparam.arg3 = g_site
#
#
#                  #呼叫檢查存在並帶值的library
#                  IF cl_chk_exist("v_ooed004") THEN
#
#                  ELSE
#                     #檢查失敗時後續處理
#                     LET g_mmaz_d[l_ac].mmaz004 = g_mmaz_d_t.mmaz004
#                     CALL ammt402_display_mmaz004()
#                     NEXT FIELD mmaz004
#                  END IF
                  IF s_aooi500_setpoint(g_prog,'mmaz004') THEN
                     CALL s_aooi500_chk(g_prog,'mmaz004',g_mmaz_d[l_ac].mmaz004,g_mmay_m.mmaysite) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_mmaz_d[l_ac].mmaz004
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                     
                        #LET g_mmaz_d[l_ac].mmaz004 = g_mmaz_d_t.mmaz004 #160824-00007#121 by sakura mark
                        LET g_mmaz_d[l_ac].mmaz004 = g_mmaz_d_o.mmaz004  #160824-00007#121 by sakura add
                        CALL ammt402_display_mmaz004()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                     
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_mmaz_d[l_ac].mmaz004
                     LET g_chkparam.arg2 = '8'
                     LET g_chkparam.arg3 = g_site
                     
                     
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_ooed004") THEN
                     
                     ELSE
                        #檢查失敗時後續處理
                        #LET g_mmaz_d[l_ac].mmaz004 = g_mmaz_d_t.mmaz004 #160824-00007#121 by sakura mark
                        LET g_mmaz_d[l_ac].mmaz004 = g_mmaz_d_o.mmaz004  #160824-00007#121 by sakura add
                        CALL ammt402_display_mmaz004()
                        NEXT FIELD mmaz004
                     END IF
                  END IF
                  IF  NOT cl_null(g_mmaz_d[l_ac].mmaz005) THEN
                     CALL ammt402_mmay003(g_mmaz_d[l_ac].mmaz005,g_mmaz_d[l_ac].mmaz004)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_mmaz_d[l_ac].mmaz004
                        #160318-00005#24  --add--str
                        LET g_errparam.replace[1] ='aini001'
                        LET g_errparam.replace[2] = cl_get_progname('aini001',g_lang,"2")
                        LET g_errparam.exeprog    ='aini001'
                        #160318-00005#24 --add--end
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_mmaz_d[l_ac].mmaz004 = g_mmaz_d_t.mmaz004 #160824-00007#121 by sakura mark
                        LET g_mmaz_d[l_ac].mmaz004 = g_mmaz_d_o.mmaz004  #160824-00007#121 by sakura add
                        CALL ammt402_display_mmaz004()
                        NEXT FIELD mmaz004
                     END IF
                  END IF
                  IF  NOT cl_null(g_mmaz_d[l_ac].mmaz001) THEN
                     CALL ammt402_chk_mmaz001(g_mmaz_d[l_ac].mmaz002,g_mmaz_d[l_ac].mmaz004)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_mmaz_d[l_ac].mmaz004
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_mmaz_d[l_ac].mmaz004 = g_mmaz_d_t.mmaz004 #160824-00007#121 by sakura mark
                        LET g_mmaz_d[l_ac].mmaz004 = g_mmaz_d_o.mmaz004  #160824-00007#121 by sakura add
                        CALL ammt402_display_mmaz004()
                        NEXT FIELD mmaz004
                     END IF
                  END IF   
               END IF
            END IF
            CALL ammt402_display_mmaz004()
            LET g_mmaz_d_o.* = g_mmaz_d[l_ac].*  #160824-00007#121 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz004
            #add-point:BEFORE FIELD mmaz004 name="input.b.page1.mmaz004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz004
            #add-point:ON CHANGE mmaz004 name="input.g.page1.mmaz004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz005
            
            #add-point:AFTER FIELD mmaz005 name="input.a.page1.mmaz005"
            LET g_mmaz_d[l_ac].mmaz005_desc = NULL
            DISPLAY g_mmaz_d[l_ac].mmaz005_desc TO s_detail1[l_ac].mmaz005_desc
            IF NOT cl_null(g_mmaz_d[l_ac].mmaz005) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmaz_d[l_ac].mmaz005 != g_mmaz_d_t.mmaz005 or g_mmaz_d_t.mmaz005 is null))) THEN #160824-00007#121 by sakura mark
               IF g_mmaz_d[l_ac].mmaz005 != g_mmaz_d_o.mmaz005 OR cl_null(g_mmaz_d_o.mmaz005) THEN #160824-00007#121 by sakura add
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_mmaz_d[l_ac].mmaz004
                  LET g_chkparam.arg2 = g_mmaz_d[l_ac].mmaz005

                  #160318-00025#20  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#20  by 07900 --add-end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_inaa001") THEN

                  ELSE
                     #檢查失敗時後續處理
                     #LET g_mmaz_d[l_ac].mmaz005 = g_mmaz_d_t.mmaz005 #160824-00007#121 by sakura mark
                     LET g_mmaz_d[l_ac].mmaz005 = g_mmaz_d_o.mmaz005  #160824-00007#121 by sakura add
                     CALL ammt402_display_mmaz005()
                     NEXT FIELD mmaz005
                  END IF
#                  CALL ammt402_mmay003(g_mmaz_d[l_ac].mmaz005,g_mmaz_d[l_ac].mmaz004)
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_mmaz_d[l_ac].mmaz005,g_errno,1)
#                     LET g_mmaz_d[l_ac].mmaz005 = g_mmaz_d_t.mmaz005
#                     CALL ammt402_display_mmaz005()
#                     NEXT FIELD mmaz005
#                  END IF
               END IF
            END IF
            CALL ammt402_display_mmaz005()
            LET g_mmaz_d_o.* = g_mmaz_d[l_ac].*  #160824-00007#121 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz005
            #add-point:BEFORE FIELD mmaz005 name="input.b.page1.mmaz005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz005
            #add-point:ON CHANGE mmaz005 name="input.g.page1.mmaz005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz001
            
            #add-point:AFTER FIELD mmaz001 name="input.a.page1.mmaz001"
            LET g_mmaz_d[l_ac].mmaz001_desc = null
            DISPLAY  g_mmaz_d[l_ac].mmaz001_desc TO s_detail1[l_ac].mmaz001_desc
            IF NOT cl_null(g_mmaz_d[l_ac].mmaz001) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND ( g_mmaz_d[l_ac].mmaz001 != g_mmaz_d_t.mmaz001 or g_mmaz_d_t.mmaz001))) THEN #160824-00007#121 by sakura mark
               IF g_mmaz_d[l_ac].mmaz001 != g_mmaz_d_o.mmaz001 OR cl_null(g_mmaz_d_o.mmaz001) THEN #160824-00007#121 by sakura add
                  CALL ammt402_mmaz001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmaz_d[l_ac].mmaz001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmaz_d[l_ac].mmaz001 = g_mmaz_d_t.mmaz001 #160824-00007#121 by sakura mark
                     LET g_mmaz_d[l_ac].mmaz001 = g_mmaz_d_o.mmaz001  #160824-00007#121 by sakura add
                     CALL ammt402_display_mmaz001()
                     NEXT FIELD mmaz001
                  END IF
                  CALL ammt402_chk_mmaz001(g_mmaz_d[l_ac].mmaz002,g_mmaz_d[l_ac].mmaz004)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmaz_d[l_ac].mmaz001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmaz_d[l_ac].mmaz001 = g_mmaz_d_t.mmaz001 #160824-00007#121 by sakura mark
                     LET g_mmaz_d[l_ac].mmaz001 = g_mmaz_d_o.mmaz001  #160824-00007#121 by sakura add
                     CALL ammt402_display_mmaz001()
                     NEXT FIELD mmaz001
                  END IF
               END IF
            END IF
            CALL ammt402_display_mmaz001()
            LET g_mmaz_d_o.* = g_mmaz_d[l_ac].*  #160824-00007#121 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz001
            #add-point:BEFORE FIELD mmaz001 name="input.b.page1.mmaz001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz001
            #add-point:ON CHANGE mmaz001 name="input.g.page1.mmaz001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmaz_d[l_ac].mmaz006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmaz006
            END IF 
 
 
 
            #add-point:AFTER FIELD mmaz006 name="input.a.page1.mmaz006"
            IF NOT cl_null(g_mmaz_d[l_ac].mmaz006) THEN 
               LET g_mmaz_d[l_ac].mmaz007 = g_mmaz_d[l_ac].mmaz006   #150521-00017#1
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz006
            #add-point:BEFORE FIELD mmaz006 name="input.b.page1.mmaz006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz006
            #add-point:ON CHANGE mmaz006 name="input.g.page1.mmaz006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz007
            #add-point:BEFORE FIELD mmaz007 name="input.b.page1.mmaz007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz007
            
            #add-point:AFTER FIELD mmaz007 name="input.a.page1.mmaz007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz007
            #add-point:ON CHANGE mmaz007 name="input.g.page1.mmaz007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz008
            #add-point:BEFORE FIELD mmaz008 name="input.b.page1.mmaz008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz008
            
            #add-point:AFTER FIELD mmaz008 name="input.a.page1.mmaz008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz008
            #add-point:ON CHANGE mmaz008 name="input.g.page1.mmaz008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaz009
            #add-point:BEFORE FIELD mmaz009 name="input.b.page1.mmaz009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaz009
            
            #add-point:AFTER FIELD mmaz009 name="input.a.page1.mmaz009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaz009
            #add-point:ON CHANGE mmaz009 name="input.g.page1.mmaz009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmazseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmazseq
            #add-point:ON ACTION controlp INFIELD mmazseq name="input.c.page1.mmazseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmazsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmazsite
            #add-point:ON ACTION controlp INFIELD mmazsite name="input.c.page1.mmazsite"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmaz_d[l_ac].mmazsite             #給予default值

            #給予arg

            CALL q_ooef001()                                #呼叫開窗

            LET g_mmaz_d[l_ac].mmazsite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmaz_d[l_ac].mmazsite TO mmazsite              #顯示到畫面上

            NEXT FIELD mmazsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaz000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz000
            #add-point:ON ACTION controlp INFIELD mmaz000 name="input.c.page1.mmaz000"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaz002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz002
            #add-point:ON ACTION controlp INFIELD mmaz002 name="input.c.page1.mmaz002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmaz_d[l_ac].mmaz002             #給予default值

            #給予arg

            CALL q_ooef001()                                #呼叫開窗

            LET g_mmaz_d[l_ac].mmaz002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmaz_d[l_ac].mmaz002 TO mmaz002              #顯示到畫面上

            NEXT FIELD mmaz002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaz003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz003
            #add-point:ON ACTION controlp INFIELD mmaz003 name="input.c.page1.mmaz003"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmaz_d[l_ac].mmaz003             #給予default值
            LET g_qryparam.arg1 = g_mmay_m.mmay002
            #給予arg

            CALL q_inaa001_6()                                #呼叫開窗

            LET g_mmaz_d[l_ac].mmaz003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.arg1 = NULL 
            DISPLAY g_mmaz_d[l_ac].mmaz003 TO mmaz003              #顯示到畫面上
            call ammt402_display_mmaz003()
            NEXT FIELD mmaz003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaz004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz004
            #add-point:ON ACTION controlp INFIELD mmaz004 name="input.c.page1.mmaz004"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmaz_d[l_ac].mmaz004             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_mmay_m.mmaysite
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004_3()                                #呼叫開窗
            
            IF s_aooi500_setpoint(g_prog,'mmaz004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaz004',g_mmay_m.mmaysite,'i') #150308-00001#3 150309 pomelo add 'i'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.arg1 = g_mmay_m.mmaysite
               LET g_qryparam.arg2 = '8'
               CALL q_ooed004_3() 
            END IF

            LET g_mmaz_d[l_ac].mmaz004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.arg1 = null
            LET g_qryparam.arg2 = null 
            DISPLAY g_mmaz_d[l_ac].mmaz004 TO mmaz004              #顯示到畫面上
            call ammt402_display_mmaz004()
            NEXT FIELD mmaz004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaz005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz005
            #add-point:ON ACTION controlp INFIELD mmaz005 name="input.c.page1.mmaz005"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmaz_d[l_ac].mmaz005             #給予default值
            IF NOT cl_null(g_mmaz_d[l_ac].mmaz004) THEN
               LET g_qryparam.where = "inaasite = '",g_mmaz_d[l_ac].mmaz004,"'"
            END IF
            #給予arg

            CALL q_inaa001_5()                                #呼叫開窗

            LET g_mmaz_d[l_ac].mmaz005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = null
            DISPLAY g_mmaz_d[l_ac].mmaz005 TO mmaz005              #顯示到畫面上
            call ammt402_display_mmaz005()
            NEXT FIELD mmaz005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaz001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz001
            #add-point:ON ACTION controlp INFIELD mmaz001 name="input.c.page1.mmaz001"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmaz_d[l_ac].mmaz001             #給予default值

            #給予arg
            IF g_type='1' THEN

               CALL q_mman001()                                #呼叫開窗
            END IF
            IF g_type='2' THEN
               CALL q_gcaf001()
            END IF            

            LET g_mmaz_d[l_ac].mmaz001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmaz_d[l_ac].mmaz001 TO mmaz001              #顯示到畫面上
            call ammt402_display_mmaz001()
            NEXT FIELD mmaz001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaz006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz006
            #add-point:ON ACTION controlp INFIELD mmaz006 name="input.c.page1.mmaz006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaz007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz007
            #add-point:ON ACTION controlp INFIELD mmaz007 name="input.c.page1.mmaz007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaz008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz008
            #add-point:ON ACTION controlp INFIELD mmaz008 name="input.c.page1.mmaz008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaz009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaz009
            #add-point:ON ACTION controlp INFIELD mmaz009 name="input.c.page1.mmaz009"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmaz_d[l_ac].* = g_mmaz_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE ammt402_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mmaz_d[l_ac].mmazseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmaz_d[l_ac].* = g_mmaz_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL ammt402_mmaz_t_mask_restore('restore_mask_o')
      
               UPDATE mmaz_t SET (mmazdocno,mmazseq,mmazsite,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005, 
                   mmaz001,mmaz006,mmaz007,mmaz008,mmaz009,mmazunit) = (g_mmay_m.mmaydocno,g_mmaz_d[l_ac].mmazseq, 
                   g_mmaz_d[l_ac].mmazsite,g_mmaz_d[l_ac].mmaz000,g_mmaz_d[l_ac].mmaz002,g_mmaz_d[l_ac].mmaz003, 
                   g_mmaz_d[l_ac].mmaz004,g_mmaz_d[l_ac].mmaz005,g_mmaz_d[l_ac].mmaz001,g_mmaz_d[l_ac].mmaz006, 
                   g_mmaz_d[l_ac].mmaz007,g_mmaz_d[l_ac].mmaz008,g_mmaz_d[l_ac].mmaz009,g_mmaz_d[l_ac].mmazunit) 
 
                WHERE mmazent = g_enterprise AND mmazdocno = g_mmay_m.mmaydocno 
 
                  AND mmazseq = g_mmaz_d_t.mmazseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmaz_d[l_ac].* = g_mmaz_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmaz_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmaz_d[l_ac].* = g_mmaz_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmay_m.mmaydocno
               LET gs_keys_bak[1] = g_mmaydocno_t
               LET gs_keys[2] = g_mmaz_d[g_detail_idx].mmazseq
               LET gs_keys_bak[2] = g_mmaz_d_t.mmazseq
               CALL ammt402_update_b('mmaz_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL ammt402_mmaz_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mmaz_d[g_detail_idx].mmazseq = g_mmaz_d_t.mmazseq 
 
                  ) THEN
                  LET gs_keys[01] = g_mmay_m.mmaydocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mmaz_d_t.mmazseq
 
                  CALL ammt402_key_update_b(gs_keys,'mmaz_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmay_m),util.JSON.stringify(g_mmaz_d_t)
               LET g_log2 = util.JSON.stringify(g_mmay_m),util.JSON.stringify(g_mmaz_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL ammt402_unlock_b("mmaz_t","'1'")
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
               LET g_mmaz_d[li_reproduce_target].* = g_mmaz_d[li_reproduce].*
 
               LET g_mmaz_d[li_reproduce_target].mmazseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmaz_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmaz_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="ammt402.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD mmaysite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmazseq
 
               #add-point:input段modify_detail 

               #end add-point  
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD mmaydocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmazseq
 
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
 
{<section id="ammt402.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION ammt402_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL ammt402_b_fill() #單身填充
      CALL ammt402_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL ammt402_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_m.mmaysite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmay_m.mmaysite_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_mmay_m.mmaysite_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_m.mmay001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmay_m.mmay001_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmay_m.mmay001_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_m.mmay002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmay_m.mmay002_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_mmay_m.mmay002_desc
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmay_m.mmay003
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_mmay_m.mmay003_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_mmay_m.mmay003_desc
            CALL s_desc_get_stock_desc(g_mmay_m.mmaysite,g_mmay_m.mmay003) RETURNING g_mmay_m.mmay003_desc
            DISPLAY BY NAME g_mmay_m.mmay003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_m.mmayownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmay_m.mmayownid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmay_m.mmayownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_m.mmayowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmay_m.mmayowndp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmay_m.mmayowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_m.mmaycrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmay_m.mmaycrtid_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_mmay_m.mmaycrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_m.mmaycrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmay_m.mmaycrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmay_m.mmaycrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_m.mmaymodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmay_m.mmaymodid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmay_m.mmaymodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmay_m.mmaycnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmay_m.mmaycnfid_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmay_m.mmaycnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_mmay_m_mask_o.* =  g_mmay_m.*
   CALL ammt402_mmay_t_mask()
   LET g_mmay_m_mask_n.* =  g_mmay_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmay_m.mmaysite,g_mmay_m.mmaysite_desc,g_mmay_m.mmaydocdt,g_mmay_m.mmaydocno,g_mmay_m.mmayunit, 
       g_mmay_m.mmay001,g_mmay_m.mmay001_desc,g_mmay_m.mmay002,g_mmay_m.mmay002_desc,g_mmay_m.mmay003, 
       g_mmay_m.mmay003_desc,g_mmay_m.mmay000,g_mmay_m.mmaystus,g_mmay_m.mmayownid,g_mmay_m.mmayownid_desc, 
       g_mmay_m.mmayowndp,g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtid_desc,g_mmay_m.mmaycrtdp, 
       g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymodid_desc,g_mmay_m.mmaymoddt, 
       g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfid_desc,g_mmay_m.mmaycnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmay_m.mmaystus 
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
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mmaz_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaz_d[l_ac].mmaz004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmaz_d[l_ac].mmaz004_desc = '',g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmaz_d[l_ac].mmaz004_desc
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmaz_d[l_ac].mmaz003
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_mmaz_d[l_ac].mmaz003_desc = '',g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmaz_d[l_ac].mmaz003_desc
            CALL s_desc_get_stock_desc(g_mmaz_d[l_ac].mmaz002,g_mmaz_d[l_ac].mmaz003) RETURNING g_mmaz_d[l_ac].mmaz003_desc
            DISPLAY BY NAME g_mmaz_d[l_ac].mmaz003_desc
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmaz_d[l_ac].mmaz005
#            CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#            LET g_mmaz_d[l_ac].mmaz005_desc = '',g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmaz_d[l_ac].mmaz005_desc
            CALL s_desc_get_stock_desc(g_mmaz_d[l_ac].mmaz004,g_mmaz_d[l_ac].mmaz005) RETURNING g_mmaz_d[l_ac].mmaz005_desc
            DISPLAY BY NAME g_mmaz_d[l_ac].mmaz005_desc

            CALL ammt402_display_mmaz001()

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL ammt402_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION ammt402_detail_show()
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
 
{<section id="ammt402.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION ammt402_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mmay_t.mmaydocno 
   DEFINE l_oldno     LIKE mmay_t.mmaydocno 
 
   DEFINE l_master    RECORD LIKE mmay_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mmaz_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_insert    LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_mmay_m.mmaydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mmaydocno_t = g_mmay_m.mmaydocno
 
    
   LET g_mmay_m.mmaydocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmay_m.mmayownid = g_user
      LET g_mmay_m.mmayowndp = g_dept
      LET g_mmay_m.mmaycrtid = g_user
      LET g_mmay_m.mmaycrtdp = g_dept 
      LET g_mmay_m.mmaycrtdt = cl_get_current()
      LET g_mmay_m.mmaymodid = g_user
      LET g_mmay_m.mmaymoddt = cl_get_current()
      LET g_mmay_m.mmaystus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_mmay_m.mmaydocdt = g_today
   CALL s_aooi500_default(g_prog,'mmaysite',g_mmay_m.mmaysite)
      RETURNING l_insert,g_mmay_m.mmaysite
   IF NOT l_insert THEN
      RETURN
   END IF
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmay_m.mmaystus 
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
 
 
 
   
   #清空key欄位的desc
   
   
   CALL ammt402_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mmay_m.* TO NULL
      INITIALIZE g_mmaz_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL ammt402_show()
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
   CALL ammt402_set_act_visible()   
   CALL ammt402_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmaydocno_t = g_mmay_m.mmaydocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmayent = " ||g_enterprise|| " AND",
                      " mmaydocno = '", g_mmay_m.mmaydocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt402_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL ammt402_idx_chk()
   
   LET g_data_owner = g_mmay_m.mmayownid      
   LET g_data_dept  = g_mmay_m.mmayowndp
   
   #功能已完成,通報訊息中心
   CALL ammt402_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt402.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION ammt402_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mmaz_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE ammt402_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmaz_t
    WHERE mmazent = g_enterprise AND mmazdocno = g_mmaydocno_t
 
    INTO TEMP ammt402_detail
 
   #將key修正為調整後   
   UPDATE ammt402_detail 
      #更新key欄位
      SET mmazdocno = g_mmay_m.mmaydocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mmaz_t SELECT * FROM ammt402_detail
   
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
   DROP TABLE ammt402_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mmaydocno_t = g_mmay_m.mmaydocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ammt402_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   IF g_mmay_m.mmaystus <>'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "apm-00034"
      LET g_errparam.extend = g_mmay_m.mmaydocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_mmay_m.mmaydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN ammt402_cl USING g_enterprise,g_mmay_m.mmaydocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt402_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE ammt402_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE ammt402_master_referesh USING g_mmay_m.mmaydocno INTO g_mmay_m.mmaysite,g_mmay_m.mmaydocdt, 
       g_mmay_m.mmaydocno,g_mmay_m.mmayunit,g_mmay_m.mmay001,g_mmay_m.mmay002,g_mmay_m.mmay003,g_mmay_m.mmay000, 
       g_mmay_m.mmaystus,g_mmay_m.mmayownid,g_mmay_m.mmayowndp,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtdp, 
       g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymoddt,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfdt, 
       g_mmay_m.mmaysite_desc,g_mmay_m.mmay001_desc,g_mmay_m.mmay002_desc,g_mmay_m.mmay003_desc,g_mmay_m.mmayownid_desc, 
       g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid_desc,g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaymodid_desc, 
       g_mmay_m.mmaycnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT ammt402_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmay_m_mask_o.* =  g_mmay_m.*
   CALL ammt402_mmay_t_mask()
   LET g_mmay_m_mask_n.* =  g_mmay_m.*
   
   CALL ammt402_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL ammt402_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mmaydocno_t = g_mmay_m.mmaydocno
 
 
      DELETE FROM mmay_t
       WHERE mmayent = g_enterprise AND mmaydocno = g_mmay_m.mmaydocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mmay_m.mmaydocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM mmaz_t
       WHERE mmazent = g_enterprise AND mmazdocno = g_mmay_m.mmaydocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mmay_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE ammt402_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mmaz_d.clear() 
 
     
      CALL ammt402_ui_browser_refresh()  
      #CALL ammt402_ui_headershow()  
      #CALL ammt402_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL ammt402_browser_fill("")
         CALL ammt402_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE ammt402_cl
 
   #功能已完成,通報訊息中心
   CALL ammt402_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="ammt402.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammt402_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mmaz_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF ammt402_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmazseq,mmazsite,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001, 
             mmaz006,mmaz007,mmaz008,mmaz009,mmazunit ,t1.ooefl003 ,t2.inayl003 ,t3.ooefl003 ,t4.inayl003 , 
             t5.mmanl003 FROM mmaz_t",   
                     " INNER JOIN mmay_t ON mmayent = " ||g_enterprise|| " AND mmaydocno = mmazdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=mmazsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t2 ON t2.inaylent="||g_enterprise||" AND t2.inayl001=mmaz003 AND t2.inayl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=mmaz004 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t4 ON t4.inaylent="||g_enterprise||" AND t4.inayl001=mmaz005 AND t4.inayl002='"||g_dlang||"' ",
               " LEFT JOIN mmanl_t t5 ON t5.mmanlent="||g_enterprise||" AND t5.mmanl001=mmaz001 AND t5.mmanl002='"||g_dlang||"' ",
 
                     " WHERE mmazent=? AND mmazdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmaz_t.mmazseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt402_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR ammt402_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mmay_m.mmaydocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mmay_m.mmaydocno INTO g_mmaz_d[l_ac].mmazseq,g_mmaz_d[l_ac].mmazsite, 
          g_mmaz_d[l_ac].mmaz000,g_mmaz_d[l_ac].mmaz002,g_mmaz_d[l_ac].mmaz003,g_mmaz_d[l_ac].mmaz004, 
          g_mmaz_d[l_ac].mmaz005,g_mmaz_d[l_ac].mmaz001,g_mmaz_d[l_ac].mmaz006,g_mmaz_d[l_ac].mmaz007, 
          g_mmaz_d[l_ac].mmaz008,g_mmaz_d[l_ac].mmaz009,g_mmaz_d[l_ac].mmazunit,g_mmaz_d[l_ac].mmazsite_desc, 
          g_mmaz_d[l_ac].mmaz003_desc,g_mmaz_d[l_ac].mmaz004_desc,g_mmaz_d[l_ac].mmaz005_desc,g_mmaz_d[l_ac].mmaz001_desc  
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
   
   CALL g_mmaz_d.deleteElement(g_mmaz_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE ammt402_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mmaz_d.getLength()
      LET g_mmaz_d_mask_o[l_ac].* =  g_mmaz_d[l_ac].*
      CALL ammt402_mmaz_t_mask()
      LET g_mmaz_d_mask_n[l_ac].* =  g_mmaz_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="ammt402.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ammt402_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM mmaz_t
       WHERE mmazent = g_enterprise AND
         mmazdocno = ps_keys_bak[1] AND mmazseq = ps_keys_bak[2]
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
         CALL g_mmaz_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ammt402_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mmaz_t
                  (mmazent,
                   mmazdocno,
                   mmazseq
                   ,mmazsite,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007,mmaz008,mmaz009,mmazunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmaz_d[g_detail_idx].mmazsite,g_mmaz_d[g_detail_idx].mmaz000,g_mmaz_d[g_detail_idx].mmaz002, 
                       g_mmaz_d[g_detail_idx].mmaz003,g_mmaz_d[g_detail_idx].mmaz004,g_mmaz_d[g_detail_idx].mmaz005, 
                       g_mmaz_d[g_detail_idx].mmaz001,g_mmaz_d[g_detail_idx].mmaz006,g_mmaz_d[g_detail_idx].mmaz007, 
                       g_mmaz_d[g_detail_idx].mmaz008,g_mmaz_d[g_detail_idx].mmaz009,g_mmaz_d[g_detail_idx].mmazunit) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mmaz_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION ammt402_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmaz_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL ammt402_mmaz_t_mask_restore('restore_mask_o')
               
      UPDATE mmaz_t 
         SET (mmazdocno,
              mmazseq
              ,mmazsite,mmaz000,mmaz002,mmaz003,mmaz004,mmaz005,mmaz001,mmaz006,mmaz007,mmaz008,mmaz009,mmazunit) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmaz_d[g_detail_idx].mmazsite,g_mmaz_d[g_detail_idx].mmaz000,g_mmaz_d[g_detail_idx].mmaz002, 
                  g_mmaz_d[g_detail_idx].mmaz003,g_mmaz_d[g_detail_idx].mmaz004,g_mmaz_d[g_detail_idx].mmaz005, 
                  g_mmaz_d[g_detail_idx].mmaz001,g_mmaz_d[g_detail_idx].mmaz006,g_mmaz_d[g_detail_idx].mmaz007, 
                  g_mmaz_d[g_detail_idx].mmaz008,g_mmaz_d[g_detail_idx].mmaz009,g_mmaz_d[g_detail_idx].mmazunit)  
 
         WHERE mmazent = g_enterprise AND mmazdocno = ps_keys_bak[1] AND mmazseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmaz_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmaz_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL ammt402_mmaz_t_mask_restore('restore_mask_n')
               
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
 
{<section id="ammt402.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION ammt402_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="ammt402.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION ammt402_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="ammt402.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ammt402_lock_b(ps_table,ps_page)
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
   #CALL ammt402_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mmaz_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN ammt402_bcl USING g_enterprise,
                                       g_mmay_m.mmaydocno,g_mmaz_d[g_detail_idx].mmazseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ammt402_bcl:",SQLERRMESSAGE 
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
 
{<section id="ammt402.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ammt402_unlock_b(ps_table,ps_page)
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
      CLOSE ammt402_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="ammt402.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION ammt402_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   DEFINE l_count LIKE type_t.num5
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mmaydocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mmaydocno",TRUE)
      CALL cl_set_comp_entry("mmaydocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mmaydocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
  
   CALL cl_set_comp_entry("mmay002,mmay003,mmaysite",TRUE) 
     
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt402.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION ammt402_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_count LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mmaydocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("mmaysite",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mmaydocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mmaydocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF cl_null(g_mmay_m.mmay002)  THEN
      CALL cl_set_comp_entry("mmay003",FALSE)
   END IF
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mmay003",TRUE)
   END IF
   SELECT count(*) INTO l_count FROM mmaz_t WHERE mmazent = g_enterprise
      AND mmazdocno = g_mmay_m.mmaydocno
   IF l_count > 0 THEN
      CALL cl_set_comp_entry("mmay002,mmay003,mmaysite",false)     
   END IF
   IF l_count = 0 THEN
      CALL cl_set_comp_entry("mmaysite",true)     
   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'mmaysite') THEN
      CALL cl_set_comp_entry("mmaysite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt402.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ammt402_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("mmaz003",true)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="ammt402.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ammt402_set_no_entry_b(p_cmd)
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
   IF cl_null(g_mmay_m.mmay002) THEN
      CALL cl_set_comp_entry("mmaz003",FALSE)
   END IF
   IF NOT cl_null(g_mmay_m.mmay002) AND NOT cl_null(g_mmay_m.mmay003) THEN
      CALL cl_set_comp_entry("mmaz003",FALSE)
   END IF   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="ammt402.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION ammt402_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION ammt402_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_mmay_m.mmaystus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION ammt402_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION ammt402_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammt402_default_search()
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

   LET g_pagestart = 1
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF cl_null(ls_wc) THEN
      LET ls_wc = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
#   IF NOT cl_null(g_argv[1]) THEN
#      LET ls_wc = ls_wc, " AND mmay000 = '", g_argv[1], "' "
#      LET g_wc=g_wc," AND mmay000 = '", g_argv[1], "' "
#   END IF 
#   RETURN
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " mmaydocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " mmaydocno = '", g_argv[02], "' AND "
   END IF
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
               WHEN la_wc[li_idx].tableid = "mmay_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmaz_t" 
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
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc," AND mmay000 = '", g_argv[01], "' "
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt402.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION ammt402_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"

   IF g_mmay_m.mmaystus = 'X' THEN
      RETURN
   END IF
   IF g_mmay_m.mmaystus = 'C' THEN  #結案狀態
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mmay_m.mmaydocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN ammt402_cl USING g_enterprise,g_mmay_m.mmaydocno
   IF STATUS THEN
      CLOSE ammt402_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN ammt402_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE ammt402_master_referesh USING g_mmay_m.mmaydocno INTO g_mmay_m.mmaysite,g_mmay_m.mmaydocdt, 
       g_mmay_m.mmaydocno,g_mmay_m.mmayunit,g_mmay_m.mmay001,g_mmay_m.mmay002,g_mmay_m.mmay003,g_mmay_m.mmay000, 
       g_mmay_m.mmaystus,g_mmay_m.mmayownid,g_mmay_m.mmayowndp,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtdp, 
       g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymoddt,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfdt, 
       g_mmay_m.mmaysite_desc,g_mmay_m.mmay001_desc,g_mmay_m.mmay002_desc,g_mmay_m.mmay003_desc,g_mmay_m.mmayownid_desc, 
       g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid_desc,g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaymodid_desc, 
       g_mmay_m.mmaycnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT ammt402_action_chk() THEN
      CLOSE ammt402_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmay_m.mmaysite,g_mmay_m.mmaysite_desc,g_mmay_m.mmaydocdt,g_mmay_m.mmaydocno,g_mmay_m.mmayunit, 
       g_mmay_m.mmay001,g_mmay_m.mmay001_desc,g_mmay_m.mmay002,g_mmay_m.mmay002_desc,g_mmay_m.mmay003, 
       g_mmay_m.mmay003_desc,g_mmay_m.mmay000,g_mmay_m.mmaystus,g_mmay_m.mmayownid,g_mmay_m.mmayownid_desc, 
       g_mmay_m.mmayowndp,g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtid_desc,g_mmay_m.mmaycrtdp, 
       g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymodid_desc,g_mmay_m.mmaymoddt, 
       g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfid_desc,g_mmay_m.mmaycnfdt
 
   CASE g_mmay_m.mmaystus
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
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mmay_m.mmaystus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
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
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_mmay_m.mmaystus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)

      END CASE
      
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT ammt402_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt402_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT ammt402_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE ammt402_cl
            RETURN
         END IF
 
 
 
	  
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
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
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
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_mmay_m.mmaystus = lc_state OR cl_null(lc_state) THEN
      CLOSE ammt402_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y' 
         SELECT mmaystus INTO g_mmay_m.mmaystus FROM mmay_t WHERE mmaydocno = g_mmay_m.mmaydocno
            AND mmayent = g_enterprise         
         CALL s_ammt402_conf_chk(g_mmay_m.mmaydocno,g_mmay_m.mmaystus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-014') THEN
               CALL s_transaction_begin()
               CALL s_ammt402_conf_upd(g_mmay_m.mmaydocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')   
               END IF
            ELSE
               RETURN
            END IF            
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmay_m.mmaydocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN            
         END IF
                
      WHEN 'X'
         SELECT mmaystus INTO g_mmay_m.mmaystus FROM mmay_t WHERE mmaydocno = g_mmay_m.mmaydocno
            AND mmayent = g_enterprise  
         CALL s_ammt402_void_chk(g_mmay_m.mmaydocno,g_mmay_m.mmaystus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_ammt402_void_upd(g_mmay_m.mmaydocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmay_m.mmaydocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN    
         END IF
      WHEN 'N'
         SELECT mmaystus INTO g_mmay_m.mmaystus FROM mmay_t WHERE mmaydocno = g_mmay_m.mmaydocno
            AND mmayent = g_enterprise 
         CALL s_ammt402_unconf_chk(g_mmay_m.mmaydocno,g_mmay_m.mmaystus) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-015') THEN
               CALL s_transaction_begin()
               CALL s_ammt402_unconf_upd(g_mmay_m.mmaydocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_mmay_m.mmaydocno
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN    
         END IF   
   END CASE
   #end add-point
   
   LET g_mmay_m.mmaymodid = g_user
   LET g_mmay_m.mmaymoddt = cl_get_current()
   LET g_mmay_m.mmaystus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mmay_t 
      SET (mmaystus,mmaymodid,mmaymoddt) 
        = (g_mmay_m.mmaystus,g_mmay_m.mmaymodid,g_mmay_m.mmaymoddt)     
    WHERE mmayent = g_enterprise AND mmaydocno = g_mmay_m.mmaydocno
 
    
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
    
      #撈取異動後的資料
      EXECUTE ammt402_master_referesh USING g_mmay_m.mmaydocno INTO g_mmay_m.mmaysite,g_mmay_m.mmaydocdt, 
          g_mmay_m.mmaydocno,g_mmay_m.mmayunit,g_mmay_m.mmay001,g_mmay_m.mmay002,g_mmay_m.mmay003,g_mmay_m.mmay000, 
          g_mmay_m.mmaystus,g_mmay_m.mmayownid,g_mmay_m.mmayowndp,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtdp, 
          g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymoddt,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfdt, 
          g_mmay_m.mmaysite_desc,g_mmay_m.mmay001_desc,g_mmay_m.mmay002_desc,g_mmay_m.mmay003_desc,g_mmay_m.mmayownid_desc, 
          g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid_desc,g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaymodid_desc, 
          g_mmay_m.mmaycnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mmay_m.mmaysite,g_mmay_m.mmaysite_desc,g_mmay_m.mmaydocdt,g_mmay_m.mmaydocno, 
          g_mmay_m.mmayunit,g_mmay_m.mmay001,g_mmay_m.mmay001_desc,g_mmay_m.mmay002,g_mmay_m.mmay002_desc, 
          g_mmay_m.mmay003,g_mmay_m.mmay003_desc,g_mmay_m.mmay000,g_mmay_m.mmaystus,g_mmay_m.mmayownid, 
          g_mmay_m.mmayownid_desc,g_mmay_m.mmayowndp,g_mmay_m.mmayowndp_desc,g_mmay_m.mmaycrtid,g_mmay_m.mmaycrtid_desc, 
          g_mmay_m.mmaycrtdp,g_mmay_m.mmaycrtdp_desc,g_mmay_m.mmaycrtdt,g_mmay_m.mmaymodid,g_mmay_m.mmaymodid_desc, 
          g_mmay_m.mmaymoddt,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfid_desc,g_mmay_m.mmaycnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   SELECT mmaystus,mmaycnfid,mmaycnfdt INTO g_mmay_m.mmaystus,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfdt
     FROM mmay_t
    WHERE mmayent = g_enterprise AND mmaydocno = g_mmay_m.mmaydocno
   DISPLAY BY NAME g_mmay_m.mmaystus,g_mmay_m.mmaycnfid,g_mmay_m.mmaycnfdt
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmay_m.mmaycnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_mmay_m.mmaycnfid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_mmay_m.mmaycnfid_desc   
   IF g_mmay_m.mmaystus NOT MATCHES "[NDR]" THEN
      CALL cl_set_act_visible("delete,modify", FALSE)
   ELSE
      CALL cl_set_act_visible("delete,modify", true)    
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE ammt402_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL ammt402_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt402.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION ammt402_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mmaz_d.getLength() THEN
         LET g_detail_idx = g_mmaz_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmaz_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmaz_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ammt402_b_fill2(pi_idx)
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
   
   CALL ammt402_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION ammt402_fill_chk(ps_idx)
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
 
{<section id="ammt402.status_show" >}
PRIVATE FUNCTION ammt402_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ammt402.mask_functions" >}
&include "erp/amm/ammt402_mask.4gl"
 
{</section>}
 
{<section id="ammt402.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION ammt402_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE  l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL ammt402_show()
   CALL ammt402_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_ammt402_conf_chk(g_mmay_m.mmaydocno,g_mmay_m.mmaystus) RETURNING l_success,g_errno
   IF l_success THEN
            
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_mmay_m.mmaydocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE ammt402_cl
      CALL s_transaction_end('N','0')
      RETURN  FALSE          
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mmay_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mmaz_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL ammt402_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL ammt402_ui_headershow()
   CALL ammt402_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION ammt402_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL ammt402_ui_headershow()  
   CALL ammt402_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="ammt402.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION ammt402_set_pk_array()
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
   LET g_pk_array[1].values = g_mmay_m.mmaydocno
   LET g_pk_array[1].column = 'mmaydocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt402.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="ammt402.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION ammt402_msgcentre_notify(lc_state)
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
   CALL ammt402_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mmay_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="ammt402.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION ammt402_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
    #160818-00017#22 add-S
   SELECT mmaystus  INTO g_mmay_m.mmaystus
     FROM mmay_t
    WHERE mmayent = g_enterprise
      AND mmaydocno = g_mmay_m.mmaydocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_mmay_m.mmaystus
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
        LET g_errparam.extend = g_mmay_m.mmaydocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL ammt402_set_act_visible()
        CALL ammt402_set_act_no_visible()
        CALL ammt402_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#22 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="ammt402.other_function" readonly="Y" >}
#+display mmay001
PRIVATE FUNCTION ammt402_display_mmay001()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmay_m.mmay001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmay_m.mmay001_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_mmay_m.mmay001_desc
END FUNCTION
#+ display mmay002
PRIVATE FUNCTION ammt402_display_mmay002()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmay_m.mmay002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmay_m.mmay002_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_mmay_m.mmay002_desc
END FUNCTION
#+ chk mmay001
PRIVATE FUNCTION ammt402_mmay001(p_mmay001)
   DEFINE   l_cnt       LIKE type_t.num5
   DEFINE   l_cnt1      LIKE type_t.num5 
   DEFINE   p_mmay001   LIKE mmay_t.mmay001
   DEFINE   l_ooef201   LIKE ooef_t.ooef201
    
   LET g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT COUNT(*) INTO l_cnt  FROM ooef_t WHERE ooef001 = p_mmay001 AND ooefent = g_enterprise
   IF l_cnt <= 0 THEN
      LET g_errno = "aoo-00090"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  FROM ooef_t WHERE  ooef001 = p_mmay001 AND ooefent = g_enterprise
       AND ooefstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno =  'sub-01302'  #160318-00005#24 mod"amm-00007"
      ELSE
         SELECT ooef201 INTO l_ooef201 FROM ooef_t WHERE  ooef001 = p_mmay001 AND ooefent = g_enterprise
         IF cl_null(l_ooef201) OR l_ooef201 <> 'Y' THEN
            LET g_errno = "art-00218"
         END IF
      END IF         
   END IF
END FUNCTION
#+ update mmay002,mmay003
PRIVATE FUNCTION ammt402_mmay002_update()
   DEFINE l_cnt   LIKE type_t.num5
   LET l_cnt = 0
   SELECT count(*) INTO l_cnt FROM mmaz_t WHERE mmazdocno = g_mmay_m.mmaydocno
      AND mmazent = g_enterprise 
   IF l_cnt>0 THEN
      IF NOT cl_null(g_mmay_m.mmay002) OR NOT cl_null(g_mmay_m.mmay003) THEN
         UPDATE mmaz_t SET mmaz002 = g_mmay_m.mmay002,
                           mmaz003 = g_mmay_m.mmay003
          WHERE mmazdocno = g_mmay_m.mmaydocno
           AND mmazent = g_enterprise
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "g_mmaz_d"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         END IF        
      END IF
   END IF   
END FUNCTION
#+chk mmaz001
PRIVATE FUNCTION ammt402_display_mmaz001()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmaz_d[l_ac].mmaz001
   IF g_type='1' THEN
      CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmaz_d[l_ac].mmaz001_desc = '', g_rtn_fields[1] , ''
   END IF
   IF g_type='2' THEN
      SELECT gcafl003 INTO g_mmaz_d[l_ac].mmaz001_desc FROM gcafl_t 
       WHERE gcafl001 =g_mmaz_d[l_ac].mmaz001 AND gcaflent = g_enterprise AND gcafl002 = g_dlang
   END IF   
   
   DISPLAY  g_mmaz_d[l_ac].mmaz001_desc TO s_detail1[l_ac].mmaz001_desc
END FUNCTION
#+ display mmaz004
PRIVATE FUNCTION ammt402_display_mmaz004()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmaz_d[l_ac].mmaz004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmaz_d[l_ac].mmaz004_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_mmaz_d[l_ac].mmaz004_desc TO s_detail[l_ac].mmaz004_desc
END FUNCTION
#+chk mmay003
PRIVATE FUNCTION ammt402_mmay003(p_mmay003,p_mmaysite)
   DEFINE  l_cnt       LIKE type_t.num5
   DEFINE  l_cnt1      LIKE type_t.num5 
   DEFINE  p_mmay003   LIKE mmay_t.mmay003
   DEFINE  p_mmaysite  like mmay_t.mmaysite
   LET  g_errno = null
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT COUNT(*) INTO l_cnt FROM inaa_t 
    WHERE inaa001 = p_mmay003 AND inaasite = p_mmaysite
      AND inaaent = g_enterprise
   IF l_cnt <=0 THEN
      LET g_errno = "aim-00064"
   ELSE
      SELECT COUNT(*) INTO l_cnt1 FROM inaa_t 
       WHERE inaa001 = p_mmay003 AND inaasite = p_mmaysite
         AND inaaent = g_enterprise AND inaastus = 'Y'
      IF l_cnt1 <=0 THEN
         LET g_errno = 'sub-01302'  #160318-00005#24 mod"amm-00018"
      END IF 
   END IF   
      
END FUNCTION
#+ chk mmaz001
PRIVATE FUNCTION ammt402_mmaz001()
   DEFINE  l_cnt    LIKE type_t.num5
   DEFINE  l_cnt1   LIKE type_t.num5
   LET  g_errno = NULL
   LET l_cnt = 0
   LET l_cnt1 = 0
   if g_type='1' then
      SELECT COUNT(*) INTO l_cnt FROM mman_t WHERE mman001=g_mmaz_d[l_ac].mmaz001 AND mmanent = g_enterprise
      IF l_cnt<=0 THEN
         LET g_errno = "amm-00003"
      ELSE
         SELECT COUNT(*) INTO l_cnt1 FROM mman_t WHERE mman001=g_mmaz_d[l_ac].mmaz001 AND mmanent = g_enterprise AND mmanstus="Y"
         IF l_cnt1<=0 THEN   
            LET g_errno = "amm-00004"
         END IF         
      END IF
      
   END IF 
   if g_type='2' then
      SELECT COUNT(*) INTO l_cnt FROM gcaf_t WHERE gcaf001=g_mmaz_d[l_ac].mmaz001 AND gcafent = g_enterprise
      IF l_cnt<=0 THEN
         LET g_errno = "amm-00124"
      ELSE
         SELECT COUNT(*) INTO l_cnt1 FROM gcaf_t WHERE gcaf001=g_mmaz_d[l_ac].mmaz001 AND gcafent = g_enterprise AND gcafstus="Y"
         IF l_cnt1<=0 THEN   
            LET g_errno = "amm-00125"
         END IF         
      END IF
      
   END IF   
      
END FUNCTION
#+create mmazseq
PRIVATE FUNCTION ammt402_mmazseq()
   IF (cl_null(g_mmaz_d[l_ac].mmazseq) OR g_mmaz_d[l_ac].mmazseq=0) THEN
      SELECT MAX(mmazseq)+1 INTO g_mmaz_d[l_ac].mmazseq FROM mmaz_t
       WHERE mmazdocno = g_mmay_m.mmaydocno AND mmazent = g_enterprise
   END IF
   IF (cl_null(g_mmaz_d[l_ac].mmazseq) OR g_mmaz_d[l_ac].mmazseq=0) THEN
      LET g_mmaz_d[l_ac].mmazseq = 1
   END IF
END FUNCTION
#+chk null
PRIVATE FUNCTION ammt402_mmay003_after()
   LET g_errno = null
   IF (cl_null(g_mmay_m.mmay002) AND NOT cl_null(g_mmay_m.mmay003)) THEN
      LET g_errno = "amm-00022"
   END IF
END FUNCTION
#+ chk mmaydocno
PRIVATE FUNCTION ammt402_mmaydocno(p_mmaydocno)
   DEFINE   l_cnt   LIKE type_t.num5
   DEFINE   l_cnt1  LIKE type_t.num5
   define   p_mmaydocno   like mmay_t.mmaydocno   
   LET g_errno = null
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent = g_enterprise
   LET l_cnt = 0
   LET l_cnt1 = 0
   SELECT COUNT(*) INTO l_cnt  FROM oobl_t WHERE oobl001 = g_ooef004 AND oobl002=p_mmaydocno
      AND oobl003 = g_prog
      AND ooblent = g_enterprise #160905-00007#6 add
   IF l_cnt <= 0 THEN
      LET g_errno = "aim-00056"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  FROM ooba_t lEFT JOIN oobl_t ON ooba001=oobl001 AND ooba002=oobl002
       WHERE ooba001 = g_ooef004 AND ooba002=p_mmaydocno
         AND oobl003 = g_prog AND oobastus='Y'
         AND ooblent = g_enterprise #160905-00007#6 add
         AND oobaent = g_enterprise #160905-00007#6 add
      IF l_cnt1 <= 0 THEN
         LET g_errno = "aoo-00102"
      END IF         
   END IF 
END FUNCTION
#+display mmaz005
PRIVATE FUNCTION ammt402_display_mmaz005()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_mmaz_d[l_ac].mmaz005
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#   LET g_mmaz_d[l_ac].mmaz005_desc = '',g_rtn_fields[1] , ''
#   DISPLAY  g_mmaz_d[l_ac].mmaz005_desc to s_detail1[l_ac].mmaz005_desc
   CALL s_desc_get_stock_desc(g_mmaz_d[l_ac].mmaz004,g_mmaz_d[l_ac].mmaz005) RETURNING g_mmaz_d[l_ac].mmaz005_desc
   DISPLAY  g_mmaz_d[l_ac].mmaz005_desc to s_detail1[l_ac].mmaz005_desc
END FUNCTION
#+display mmay003
PRIVATE FUNCTION ammt402_display_mmay003()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_mmay_m.mmay003
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#   LET g_mmay_m.mmay003_desc =  g_rtn_fields[1]
#   DISPLAY BY NAME g_mmay_m.mmay003_desc
   CALL s_desc_get_stock_desc(g_mmay_m.mmaysite,g_mmay_m.mmay003) RETURNING g_mmay_m.mmay003_desc
   DISPLAY BY NAME g_mmay_m.mmay003_desc
END FUNCTION
#+display mmaz003
PRIVATE FUNCTION ammt402_display_mmaz003()
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_mmaz_d[l_ac].mmaz003
#   CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? ","") RETURNING g_rtn_fields
#   LET g_mmaz_d[l_ac].mmaz003_desc = '',g_rtn_fields[1] , ''
#   DISPLAY  g_mmaz_d[l_ac].mmaz003_desc to s_detail1[l_ac].mmaz003_desc
   CALL s_desc_get_stock_desc(g_mmaz_d[l_ac].mmaz002,g_mmaz_d[l_ac].mmaz003) RETURNING g_mmaz_d[l_ac].mmaz003_desc
   DISPLAY  g_mmaz_d[l_ac].mmaz003_desc to s_detail1[l_ac].mmaz003_desc
END FUNCTION
#chk mmaz001
PRIVATE FUNCTION ammt402_chk_mmaz001(p_mmaz002,p_mmaz004)
   DEFINE p_mmaz002 LIKE mmaz_t.mmaz002
   define p_mmaz004 like mmaz_t.mmaz004
   DEFINE l_mmap003 LIKE mmap_t.mmap003
   DEFINE l_mmap005 LIKE mmap_t.mmap005
   DEFINE l_count   LIKE type_t.num5
   DEFINE l_sql     STRING

   DELETE from ammt402_tmp
   IF SQLCA.sqlcode THEN
      LET g_errno = SQLCA.sqlcode
      RETURN
   END IF
   LET l_count = 0
   LET g_errno = NULL
   SELECT count(*) INTO l_count
     FROM mmap_t WHERE mmap002=g_mmaz_d[l_ac].mmaz001 AND mmapent=g_enterprise
   IF l_count <= 0 THEN
      LET g_errno = "amm-00023"
      RETURN
   END IF
   LET l_count = 0
   ##############################150518-00022#1   mod by huangtao begin
   #LET l_sql=" INSERT INTO ammt402_tmp  select ooed004 from (SELECT ooed004 FROM (SELECT ooed004 FROM ooed_t ",
   #                "  START WITH ooed005 = ?  CONNECT BY  nocycle PRIOR ooed004 = ooed005 ) ",
   #                "   UNION ",
   #                "  SELECT ooea001 from ooea_t where ooea001 = ? AND ooeaent=",g_enterprise," )"   
   LET l_sql=" INSERT INTO ammt402_tmp  select ooed004 from (SELECT ooed004 FROM (SELECT ooed004 FROM ooed_t ",
                    "  START WITH ooed005 = ? AND ooed001 = '8' AND ooed006<='",g_today,"' AND (ooed007 >='",g_today,"' OR ooed007 IS NULL)",
                    "  CONNECT BY  nocycle PRIOR ooed004 = ooed005 AND ooed001 = '8' AND ooed006<='",g_today,"' AND (ooed007 >='",g_today,"' OR ooed007 IS NULL) ) ",
                    " UNION ",
                    "  SELECT ooed004 FROM ooed_t WHERE ooed004 = ? AND ooedent=",g_enterprise," )"      
   ##############################150518-00022#1   mod by huangtao end                   
   PREPARE l_sql_imaa_pre1 FROM l_sql
         
   LET l_sql = "SELECT DISTINCT mmap003,mmap005 FROM mmap_t WHERE mmap002='",g_mmaz_d[l_ac].mmaz001,"' ",
               "  AND mmapstus='Y' AND mmapent=",g_enterprise
   PREPARE l_sql_mmap003 FROM l_sql
   DECLARE l_sql_mmap003_cs CURSOR FOR l_sql_mmap003
   FOREACH l_sql_mmap003_cs INTO l_mmap003,l_mmap005
      INSERT INTO ammt402_tmp VALUES (l_mmap003)
      IF SQLCA.sqlcode THEN
         LET g_errno = SQLCA.sqlcode
         RETURN
      END IF
      IF l_mmap005='Y' THEN
         EXECUTE l_sql_imaa_pre1 USING l_mmap003,l_mmap003
         IF SQLCA.sqlcode THEN
            LET g_errno = SQLCA.sqlcode
            RETURN
         END IF
      END IF

   END FOREACH
   let l_count = 0
   IF NOT cl_null(p_mmaz002) THEN
      SELECT count(*) INTO l_count FROM ammt402_tmp
      WHERE mmap003 = p_mmaz002
      IF l_count <= 0 THEN
         LET g_errno = "amm-00112"
      END IF
   END IF
   IF NOT cl_null(p_mmaz004) AND cl_null(g_errno) THEN   
      LET l_count=0
      SELECT count(*) INTO l_count FROM ammt402_tmp
       WHERE mmap003 = p_mmaz004
      IF l_count <= 0 THEN
         LET g_errno = "amm-00111"
      END IF
   END IF      
END FUNCTION
#display mmaysite
PRIVATE FUNCTION ammt402_display_mmaysite()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmay_m.mmaysite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmay_m.mmaysite_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_mmay_m.mmaysite_desc
END FUNCTION
#chk mmaz004
PRIVATE FUNCTION ammt402_mmaz004(p_mmaz004)
   DEFINE l_cnt    LIKE type_t.num5
   DEFINE l_cnt1    LIKE type_t.num5 
   DEFINE p_mmaz004 LIKE mmaz_t.mmaz004
   DEFINE l_sql     STRING
   LET l_cnt = 0
   LET l_cnt1 = 0
   LET g_errno = NULL
   LET l_sql="SELECT COUNT(*)  FROM ooed_t WHERE ooed004 ='",p_mmaz004,"' AND ooed001='8' ",
             "   AND ooedent = ",g_enterprise, #160905-00007#6 add
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null)",
             "   AND ooed004 IN ((select DISTINCT ooed004 FROM ooed_t START WITH ooed005='",g_mmay_m.mmaysite,"' CONNECT BY NOCYCLE PRIOR ooed004=ooed005 AND ooed001='8' ",
             "                       AND ooedent = ",g_enterprise, #160905-00007#6 add
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null))",
             "          UNION ",
#             "         (SELECT ooed004 FROM ooed_t WHERE ooed004='",g_mmay_m.mmaysite,"'))" #160905-00007#6 mark
             "         (SELECT ooed004 FROM ooed_t WHERE ooedent=",g_enterprise," AND ooed004='",g_mmay_m.mmaysite,"'))" #160905-00007#6 add
   PREPARE l_sql_ooea_pre1 FROM l_sql
   EXECUTE l_sql_ooea_pre1 INTO l_cnt   
   IF l_cnt <= 0 THEN
      LET g_errno = "aoo-00163"
   ELSE
      LET l_sql="SELECT COUNT(*)  FROM ooed_t,ooea_t WHERE ooea001=ooed004 AND ooed004 ='",p_mmaz004,"' AND ooed001='8' ",
             "   AND ooedent=ooeaent AND ooedent = ",g_enterprise, #160905-00007#6 add
             "   AND ooeastus='Y' AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null)",
             "   AND ooea001 IN ((select DISTINCT ooed004 FROM ooed_t START WITH ooed005='",g_mmay_m.mmaysite,"' CONNECT BY NOCYCLE PRIOR ooed004=ooed005 AND ooed001='8' ",
             "   AND TO_CHAR(ooed006,'YYYY/MM/DD')<='",g_today,"' AND (TO_CHAR(ooed007,'YYYY/MM/DD')>='",g_today,"' or ooed007 is null))",
             "          UNION ",
#             "         (SELECT ooea001 FROM ooea_t WHERE ooea001='",g_mmay_m.mmaysite,"'))" #160905-00007#6 mark
             "         (SELECT ooea001 FROM ooea_t WHERE ooeaent=",g_enterprise," AND ooea001='",g_mmay_m.mmaysite,"'))" #160905-00007#6 add
      PREPARE l_sql_ooea_pre2 FROM l_sql
      EXECUTE l_sql_ooea_pre2 INTO l_cnt1       
      IF l_cnt1 <= 0 THEN
         LET g_errno =  'sub-01302'  #160318-00005#24 mod"amm-00007"
      END IF         
   END IF
END FUNCTION

 
{</section>}
 
