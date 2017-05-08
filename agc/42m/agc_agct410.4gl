#該程式未解開Section, 採用最新樣板產出!
{<section id="agct410.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2016-09-01 16:44:12), PR版次:0016(2016-10-24 14:26:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000274
#+ Filename...: agct410
#+ Description: 券狀態異動申請作業
#+ Creator....: 01533(2013-12-30 14:17:52)
#+ Modifier...: 08172 -SD/PR- 06814
 
{</section>}
 
{<section id="agct410.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...: No.160519-00032#1   2015/05/23  by 07959    1.(修改bug)新增单据,agct412/agct413/agct414单据编号栏位开窗带出agct410异动单别,开窗打不出显示,手动输入OK
#+ Modifier...:                                             2.(修改bug)作业未使用签核流程,状态切换图标会有提交、抽单显示
#+ Modifier...:                                                根据是否走签核流程显示隐藏对应的按钮和状态
#+ Modifier...: No.160705-00042#11  2016/07/15 By sakura    查詢程式段q_ooba002_1開窗，呼叫開窗前的g_qryparam.arg若是要傳入程式代號，要改傳入g_prog
#+ Modifier...: No.160809-00027#1   2016/08/09 by 08172     已审核的不能修改，只能查询
#  Modifier...: NO.160816-00068#13  2016/08/22 By 08209     調整transaction
#  Modifier...: NO.160818-00017#14  2016/08/25  by 08172    修改删除时重新检查状态
#  Modifier...: NO.160905-00007#3   2016/09/02 By zhujing   调整系统中无ENT的SQL条件增加ent
#  Modifier...: NO.160929-00031#1   2016/10/08 By 08742     调整开窗，使之过滤掉已经停用的单号
#  Modifier...: NO.160824-00007#101 2016/10/24 By 06814     新舊值相關調整

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
PRIVATE type type_g_gcam_m        RECORD
       gcam000 LIKE gcam_t.gcam000, 
   gcamsite LIKE gcam_t.gcamsite, 
   gcamsite_desc LIKE type_t.chr80, 
   gcamunit LIKE gcam_t.gcamunit, 
   gcamdocdt LIKE gcam_t.gcamdocdt, 
   gcamdocno LIKE gcam_t.gcamdocno, 
   gcam002 LIKE gcam_t.gcam002, 
   gcam002_desc LIKE type_t.chr80, 
   gcam001 LIKE gcam_t.gcam001, 
   gcam001_desc LIKE type_t.chr80, 
   gcamstus LIKE gcam_t.gcamstus, 
   gcamownid LIKE gcam_t.gcamownid, 
   gcamownid_desc LIKE type_t.chr80, 
   gcamowndp LIKE gcam_t.gcamowndp, 
   gcamowndp_desc LIKE type_t.chr80, 
   gcamcrtid LIKE gcam_t.gcamcrtid, 
   gcamcrtid_desc LIKE type_t.chr80, 
   gcamcrtdp LIKE gcam_t.gcamcrtdp, 
   gcamcrtdp_desc LIKE type_t.chr80, 
   gcamcrtdt LIKE gcam_t.gcamcrtdt, 
   gcammodid LIKE gcam_t.gcammodid, 
   gcammodid_desc LIKE type_t.chr80, 
   gcammoddt LIKE gcam_t.gcammoddt, 
   gcamcnfid LIKE gcam_t.gcamcnfid, 
   gcamcnfid_desc LIKE type_t.chr80, 
   gcamcnfdt LIKE gcam_t.gcamcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gcan_d        RECORD
       gcanunit LIKE gcan_t.gcanunit, 
   gcanseq LIKE gcan_t.gcanseq, 
   gcansite LIKE gcan_t.gcansite, 
   gcansite_desc LIKE type_t.chr500, 
   gcan001 LIKE gcan_t.gcan001, 
   gcan002 LIKE gcan_t.gcan002, 
   gcan002_desc LIKE type_t.chr500, 
   gcan001_desc LIKE type_t.num20_6, 
   gcan003 LIKE gcan_t.gcan003, 
   gcan004 LIKE gcan_t.gcan004
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_gcam000 LIKE gcam_t.gcam000,
      b_gcamsite LIKE gcam_t.gcamsite,
      b_gcamdocno LIKE gcam_t.gcamdocno,
      b_gcamdocdt LIKE gcam_t.gcamdocdt,
      b_gcam002 LIKE gcam_t.gcam002,
      b_gcam001 LIKE gcam_t.gcam001,
      b_gcamunit LIKE gcam_t.gcamunit
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_gcam000              LIKE gcam_t.gcam000
DEFINE g_ooef004              LIKE ooef_t.ooef004
DEFINE g_ooef005              LIKE ooef_t.ooef005
DEFINE g_assign_no            LIKE type_t.chr1
DEFINE g_site_flag            LIKE type_t.num5
DEFINE g_gcbi001              LIKE gcbi_t.gcbi001
DEFINE g_gcbi002              LIKE gcbi_t.gcbi002
#end add-point
       
#模組變數(Module Variables)
DEFINE g_gcam_m          type_g_gcam_m
DEFINE g_gcam_m_t        type_g_gcam_m
DEFINE g_gcam_m_o        type_g_gcam_m
DEFINE g_gcam_m_mask_o   type_g_gcam_m #轉換遮罩前資料
DEFINE g_gcam_m_mask_n   type_g_gcam_m #轉換遮罩後資料
 
   DEFINE g_gcamdocno_t LIKE gcam_t.gcamdocno
 
 
DEFINE g_gcan_d          DYNAMIC ARRAY OF type_g_gcan_d
DEFINE g_gcan_d_t        type_g_gcan_d
DEFINE g_gcan_d_o        type_g_gcan_d
DEFINE g_gcan_d_mask_o   DYNAMIC ARRAY OF type_g_gcan_d #轉換遮罩前資料
DEFINE g_gcan_d_mask_n   DYNAMIC ARRAY OF type_g_gcan_d #轉換遮罩後資料
 
 
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
 
{<section id="agct410.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("agc","")
 
   #add-point:作業初始化 name="main.init"
   LET g_gcam000 = g_argv[1]
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT gcam000,gcamsite,'',gcamunit,gcamdocdt,gcamdocno,gcam002,'',gcam001,'', 
       gcamstus,gcamownid,'',gcamowndp,'',gcamcrtid,'',gcamcrtdp,'',gcamcrtdt,gcammodid,'',gcammoddt, 
       gcamcnfid,'',gcamcnfdt", 
                      " FROM gcam_t",
                      " WHERE gcament= ? AND gcamdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agct410_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gcam000,t0.gcamsite,t0.gcamunit,t0.gcamdocdt,t0.gcamdocno,t0.gcam002, 
       t0.gcam001,t0.gcamstus,t0.gcamownid,t0.gcamowndp,t0.gcamcrtid,t0.gcamcrtdp,t0.gcamcrtdt,t0.gcammodid, 
       t0.gcammoddt,t0.gcamcnfid,t0.gcamcnfdt,t1.ooefl003 ,t2.oocql004 ,t3.oocql004 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM gcam_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.gcamsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2055' AND t2.oocql002=t0.gcam002 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='2056' AND t3.oocql002=t0.gcam001 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.gcamownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.gcamowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.gcamcrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.gcamcrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.gcammodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.gcamcnfid  ",
 
               " WHERE t0.gcament = " ||g_enterprise|| " AND t0.gcamdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE agct410_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agct410 WITH FORM cl_ap_formpath("agc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agct410_init()   
 
      #進入選單 Menu (="N")
      CALL agct410_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agct410
      
   END IF 
   
   CLOSE agct410_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agct410.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION agct410_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
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
      CALL cl_set_combo_scc_part('gcamstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('gcam000','6543') 
   CALL cl_set_combo_scc('gcan004','6551') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_gcam000','6543') 
   
   LET g_gcam_m.gcam000 = g_gcam000
   DISPLAY BY NAME g_gcam_m.gcam000
   
   CASE g_gcam000
      WHEN '1'
         CALL cl_set_comp_visible('gcan003,gcan004',FALSE)
        
      WHEN '2'
         CALL cl_set_comp_visible('gcan001_desc',FALSE)
         
      WHEN '3'  
         CALL cl_set_comp_visible('gcan001_desc,gcan004',FALSE) 
               
   END CASE
   #add by yangxf ---start---
   IF NOT cl_null(g_gcam000) THEN 
      CALL cl_set_toolbaritem_visible("agct410_01",TRUE) 
   ELSE
      CALL cl_set_toolbaritem_visible("agct410_01",FALSE) 
   END IF 
   #add by yangxf ---end------
   LET g_ooef004 = ''
   LET g_ooef005 = ''
   SELECT ooef004,ooef005 INTO g_ooef004,g_ooef005 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   IF cl_null(g_ooef005) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00008'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309   
   #end add-point
   
   #初始化搜尋條件
   CALL agct410_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="agct410.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION agct410_ui_dialog()
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
            CALL agct410_insert()
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
         INITIALIZE g_gcam_m.* TO NULL
         CALL g_gcan_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL agct410_init()
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
               
               CALL agct410_fetch('') # reload data
               LET l_ac = 1
               CALL agct410_ui_detailshow() #Setting the current row 
         
               CALL agct410_idx_chk()
               #NEXT FIELD gcanseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_gcan_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agct410_idx_chk()
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
               CALL agct410_idx_chk()
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
            CALL agct410_browser_fill("")
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
               CALL agct410_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL agct410_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL agct410_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
          
            IF cl_null(g_gcam000) THEN 
               CALL DIALOG.setActionActive("insert", FALSE) 
            END IF 
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL agct410_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL agct410_set_act_visible()   
            CALL agct410_set_act_no_visible()
            IF NOT (g_gcam_m.gcamdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " gcament = " ||g_enterprise|| " AND",
                                  " gcamdocno = '", g_gcam_m.gcamdocno, "' "
 
               #填到對應位置
               CALL agct410_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "gcam_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gcan_t" 
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
               CALL agct410_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "gcam_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gcan_t" 
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
                  CALL agct410_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL agct410_fetch("F")
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
               CALL agct410_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL agct410_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct410_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL agct410_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct410_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL agct410_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct410_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL agct410_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct410_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL agct410_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct410_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_gcan_d)
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
               NEXT FIELD gcanseq
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
               CALL agct410_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#14 -s by 08172
               CALL agct410_set_act_visible()   
               CALL agct410_set_act_no_visible()
               #160818-00017#14 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL agct410_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#14 -s by 08172
               CALL agct410_set_act_visible()   
               CALL agct410_set_act_no_visible()
               #160818-00017#14 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL agct410_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#14 -s by 08172
               CALL agct410_set_act_visible()   
               CALL agct410_set_act_no_visible()
               #160818-00017#14 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agct410_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION agct410_01
            LET g_action_choice="agct410_01"
            IF cl_auth_chk_act("agct410_01") THEN
               
               #add-point:ON ACTION agct410_01 name="menu.agct410_01"
               IF NOT cl_null(g_gcam000) THEN 
                  CALL agct410_01()
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/agc/agct410_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/agc/agct410_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL agct410_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL agct410_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agct410_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agct410_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_gcam_m.gcamdocdt)
 
 
 
         
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
 
{<section id="agct410.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION agct410_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'gcamsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim() 
   IF NOT cl_null(g_argv[1]) THEN
      LET l_wc = l_wc CLIPPED," AND gcam000 = '",g_argv[1],"'"
      LET g_wc = g_wc CLIPPED," AND gcam000 = '",g_argv[1],"'"
   END IF
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT gcamdocno ",
                      " FROM gcam_t ",
                      " ",
                      " LEFT JOIN gcan_t ON gcanent = gcament AND gcamdocno = gcandocno ", "  ",
                      #add-point:browser_fill段sql(gcan_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE gcament = " ||g_enterprise|| " AND gcanent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gcam_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gcamdocno ",
                      " FROM gcam_t ", 
                      "  ",
                      "  ",
                      " WHERE gcament = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("gcam_t")
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
      INITIALIZE g_gcam_m.* TO NULL
      CALL g_gcan_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gcam000,t0.gcamsite,t0.gcamdocno,t0.gcamdocdt,t0.gcam002,t0.gcam001,t0.gcamunit Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gcamstus,t0.gcam000,t0.gcamsite,t0.gcamdocno,t0.gcamdocdt,t0.gcam002, 
          t0.gcam001,t0.gcamunit ",
                  " FROM gcam_t t0",
                  "  ",
                  "  LEFT JOIN gcan_t ON gcanent = gcament AND gcamdocno = gcandocno ", "  ", 
                  #add-point:browser_fill段sql(gcan_t1) name="browser_fill.join.gcan_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.gcament = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("gcam_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gcamstus,t0.gcam000,t0.gcamsite,t0.gcamdocno,t0.gcamdocdt,t0.gcam002, 
          t0.gcam001,t0.gcamunit ",
                  " FROM gcam_t t0",
                  "  ",
                  
                  " WHERE t0.gcament = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("gcam_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY gcamdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"gcam_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gcam000,g_browser[g_cnt].b_gcamsite, 
          g_browser[g_cnt].b_gcamdocno,g_browser[g_cnt].b_gcamdocdt,g_browser[g_cnt].b_gcam002,g_browser[g_cnt].b_gcam001, 
          g_browser[g_cnt].b_gcamunit
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
         CALL agct410_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_gcamdocno) THEN
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
 
{<section id="agct410.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION agct410_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gcam_m.gcamdocno = g_browser[g_current_idx].b_gcamdocno   
 
   EXECUTE agct410_master_referesh USING g_gcam_m.gcamdocno INTO g_gcam_m.gcam000,g_gcam_m.gcamsite, 
       g_gcam_m.gcamunit,g_gcam_m.gcamdocdt,g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam001,g_gcam_m.gcamstus, 
       g_gcam_m.gcamownid,g_gcam_m.gcamowndp,g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdt, 
       g_gcam_m.gcammodid,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfdt,g_gcam_m.gcamsite_desc, 
       g_gcam_m.gcam002_desc,g_gcam_m.gcam001_desc,g_gcam_m.gcamownid_desc,g_gcam_m.gcamowndp_desc,g_gcam_m.gcamcrtid_desc, 
       g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcammodid_desc,g_gcam_m.gcamcnfid_desc
   
   CALL agct410_gcam_t_mask()
   CALL agct410_show()
      
END FUNCTION
 
{</section>}
 
{<section id="agct410.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION agct410_ui_detailshow()
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
 
{<section id="agct410.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION agct410_ui_browser_refresh()
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
      IF g_browser[l_i].b_gcamdocno = g_gcam_m.gcamdocno 
 
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
 
{<section id="agct410.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION agct410_construct()
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
   INITIALIZE g_gcam_m.* TO NULL
   CALL g_gcan_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON gcamsite,gcamunit,gcamdocdt,gcamdocno,gcam002,gcam001,gcamstus,gcamownid, 
          gcamowndp,gcamcrtid,gcamcrtdp,gcamcrtdt,gcammodid,gcammoddt,gcamcnfid,gcamcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
           
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gcamcrtdt>>----
         AFTER FIELD gcamcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gcammoddt>>----
         AFTER FIELD gcammoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gcamcnfdt>>----
         AFTER FIELD gcamcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gcampstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.gcamsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamsite
            #add-point:ON ACTION controlp INFIELD gcamsite name="construct.c.gcamsite"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = '2'
#			   LET g_qryparam.where = "ooef201 = 'Y'"
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcamsite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO gcamsite  #顯示到畫面上

            NEXT FIELD gcamsite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamsite
            #add-point:BEFORE FIELD gcamsite name="construct.b.gcamsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamsite
            
            #add-point:AFTER FIELD gcamsite name="construct.a.gcamsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamunit
            #add-point:BEFORE FIELD gcamunit name="construct.b.gcamunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamunit
            
            #add-point:AFTER FIELD gcamunit name="construct.a.gcamunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcamunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamunit
            #add-point:ON ACTION controlp INFIELD gcamunit name="construct.c.gcamunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamdocdt
            #add-point:BEFORE FIELD gcamdocdt name="construct.b.gcamdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamdocdt
            
            #add-point:AFTER FIELD gcamdocdt name="construct.a.gcamdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcamdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamdocdt
            #add-point:ON ACTION controlp INFIELD gcamdocdt name="construct.c.gcamdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gcamdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamdocno
            #add-point:ON ACTION controlp INFIELD gcamdocno name="construct.c.gcamdocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_gcam_m.gcam000
            CALL q_gcamdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcamdocno  #顯示到畫面上

            NEXT FIELD gcamdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamdocno
            #add-point:BEFORE FIELD gcamdocno name="construct.b.gcamdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamdocno
            
            #add-point:AFTER FIELD gcamdocno name="construct.a.gcamdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcam002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcam002
            #add-point:ON ACTION controlp INFIELD gcam002 name="construct.c.gcam002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '2055'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcam002  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oocq010 #參考欄位七 

            NEXT FIELD gcam002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcam002
            #add-point:BEFORE FIELD gcam002 name="construct.b.gcam002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcam002
            
            #add-point:AFTER FIELD gcam002 name="construct.a.gcam002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcam001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcam001
            #add-point:ON ACTION controlp INFIELD gcam001 name="construct.c.gcam001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '2056'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcam001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oocq010 #參考欄位七 

            NEXT FIELD gcam001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcam001
            #add-point:BEFORE FIELD gcam001 name="construct.b.gcam001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcam001
            
            #add-point:AFTER FIELD gcam001 name="construct.a.gcam001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamstus
            #add-point:BEFORE FIELD gcamstus name="construct.b.gcamstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamstus
            
            #add-point:AFTER FIELD gcamstus name="construct.a.gcamstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcamstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamstus
            #add-point:ON ACTION controlp INFIELD gcamstus name="construct.c.gcamstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gcamownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamownid
            #add-point:ON ACTION controlp INFIELD gcamownid name="construct.c.gcamownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcamownid  #顯示到畫面上

            NEXT FIELD gcamownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamownid
            #add-point:BEFORE FIELD gcamownid name="construct.b.gcamownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamownid
            
            #add-point:AFTER FIELD gcamownid name="construct.a.gcamownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcamowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamowndp
            #add-point:ON ACTION controlp INFIELD gcamowndp name="construct.c.gcamowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcamowndp  #顯示到畫面上

            NEXT FIELD gcamowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamowndp
            #add-point:BEFORE FIELD gcamowndp name="construct.b.gcamowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamowndp
            
            #add-point:AFTER FIELD gcamowndp name="construct.a.gcamowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcamcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamcrtid
            #add-point:ON ACTION controlp INFIELD gcamcrtid name="construct.c.gcamcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcamcrtid  #顯示到畫面上

            NEXT FIELD gcamcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamcrtid
            #add-point:BEFORE FIELD gcamcrtid name="construct.b.gcamcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamcrtid
            
            #add-point:AFTER FIELD gcamcrtid name="construct.a.gcamcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gcamcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamcrtdp
            #add-point:ON ACTION controlp INFIELD gcamcrtdp name="construct.c.gcamcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcamcrtdp  #顯示到畫面上

            NEXT FIELD gcamcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamcrtdp
            #add-point:BEFORE FIELD gcamcrtdp name="construct.b.gcamcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamcrtdp
            
            #add-point:AFTER FIELD gcamcrtdp name="construct.a.gcamcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamcrtdt
            #add-point:BEFORE FIELD gcamcrtdt name="construct.b.gcamcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gcammodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcammodid
            #add-point:ON ACTION controlp INFIELD gcammodid name="construct.c.gcammodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcammodid  #顯示到畫面上

            NEXT FIELD gcammodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcammodid
            #add-point:BEFORE FIELD gcammodid name="construct.b.gcammodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcammodid
            
            #add-point:AFTER FIELD gcammodid name="construct.a.gcammodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcammoddt
            #add-point:BEFORE FIELD gcammoddt name="construct.b.gcammoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gcamcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamcnfid
            #add-point:ON ACTION controlp INFIELD gcamcnfid name="construct.c.gcamcnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcamcnfid  #顯示到畫面上

            NEXT FIELD gcamcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamcnfid
            #add-point:BEFORE FIELD gcamcnfid name="construct.b.gcamcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamcnfid
            
            #add-point:AFTER FIELD gcamcnfid name="construct.a.gcamcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamcnfdt
            #add-point:BEFORE FIELD gcamcnfdt name="construct.b.gcamcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON gcanunit,gcanseq,gcansite,gcan001,gcan002,gcan003,gcan004
           FROM s_detail1[1].gcanunit,s_detail1[1].gcanseq,s_detail1[1].gcansite,s_detail1[1].gcan001, 
               s_detail1[1].gcan002,s_detail1[1].gcan003,s_detail1[1].gcan004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcanunit
            #add-point:BEFORE FIELD gcanunit name="construct.b.page1.gcanunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcanunit
            
            #add-point:AFTER FIELD gcanunit name="construct.a.page1.gcanunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcanunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcanunit
            #add-point:ON ACTION controlp INFIELD gcanunit name="construct.c.page1.gcanunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcanseq
            #add-point:BEFORE FIELD gcanseq name="construct.b.page1.gcanseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcanseq
            
            #add-point:AFTER FIELD gcanseq name="construct.a.page1.gcanseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcanseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcanseq
            #add-point:ON ACTION controlp INFIELD gcanseq name="construct.c.page1.gcanseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gcansite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcansite
            #add-point:ON ACTION controlp INFIELD gcansite name="construct.c.page1.gcansite"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = '2'
#			   LET g_qryparam.where = "ooef201 ='Y'"
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcansite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO gcansite  #顯示到畫面上

            NEXT FIELD gcansite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcansite
            #add-point:BEFORE FIELD gcansite name="construct.b.page1.gcansite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcansite
            
            #add-point:AFTER FIELD gcansite name="construct.a.page1.gcansite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcan001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcan001
            #add-point:ON ACTION controlp INFIELD gcan001 name="construct.c.page1.gcan001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			CASE g_gcam000 
			   WHEN '1'
			      LET g_qryparam.arg1 = '1'
			   WHEN '2'
			      LET g_qryparam.arg1 = '1'
               WHEN '3'  
                  LET g_qryparam.arg1 = '3' 
			END CASE
			
            CALL q_gcao001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcan001  #顯示到畫面上

            NEXT FIELD gcan001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcan001
            #add-point:BEFORE FIELD gcan001 name="construct.b.page1.gcan001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcan001
            
            #add-point:AFTER FIELD gcan001 name="construct.a.page1.gcan001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcan002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcan002
            #add-point:ON ACTION controlp INFIELD gcan002 name="construct.c.page1.gcan002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_gcaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gcan002  #顯示到畫面上

            NEXT FIELD gcan002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcan002
            #add-point:BEFORE FIELD gcan002 name="construct.b.page1.gcan002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcan002
            
            #add-point:AFTER FIELD gcan002 name="construct.a.page1.gcan002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcan003
            #add-point:BEFORE FIELD gcan003 name="construct.b.page1.gcan003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcan003
            
            #add-point:AFTER FIELD gcan003 name="construct.a.page1.gcan003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcan003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcan003
            #add-point:ON ACTION controlp INFIELD gcan003 name="construct.c.page1.gcan003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcan004
            #add-point:BEFORE FIELD gcan004 name="construct.b.page1.gcan004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcan004
            
            #add-point:AFTER FIELD gcan004 name="construct.a.page1.gcan004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gcan004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcan004
            #add-point:ON ACTION controlp INFIELD gcan004 name="construct.c.page1.gcan004"
            
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
                  WHEN la_wc[li_idx].tableid = "gcam_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gcan_t" 
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
 
{<section id="agct410.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION agct410_filter()
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
      CONSTRUCT g_wc_filter ON gcam000,gcamsite,gcamdocno,gcamdocdt,gcam002,gcam001,gcamunit
                          FROM s_browse[1].b_gcam000,s_browse[1].b_gcamsite,s_browse[1].b_gcamdocno, 
                              s_browse[1].b_gcamdocdt,s_browse[1].b_gcam002,s_browse[1].b_gcam001,s_browse[1].b_gcamunit 
 
 
         BEFORE CONSTRUCT
               DISPLAY agct410_filter_parser('gcam000') TO s_browse[1].b_gcam000
            DISPLAY agct410_filter_parser('gcamsite') TO s_browse[1].b_gcamsite
            DISPLAY agct410_filter_parser('gcamdocno') TO s_browse[1].b_gcamdocno
            DISPLAY agct410_filter_parser('gcamdocdt') TO s_browse[1].b_gcamdocdt
            DISPLAY agct410_filter_parser('gcam002') TO s_browse[1].b_gcam002
            DISPLAY agct410_filter_parser('gcam001') TO s_browse[1].b_gcam001
            DISPLAY agct410_filter_parser('gcamunit') TO s_browse[1].b_gcamunit
      
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
 
      CALL agct410_filter_show('gcam000')
   CALL agct410_filter_show('gcamsite')
   CALL agct410_filter_show('gcamdocno')
   CALL agct410_filter_show('gcamdocdt')
   CALL agct410_filter_show('gcam002')
   CALL agct410_filter_show('gcam001')
   CALL agct410_filter_show('gcamunit')
 
END FUNCTION
 
{</section>}
 
{<section id="agct410.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION agct410_filter_parser(ps_field)
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
 
{<section id="agct410.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION agct410_filter_show(ps_field)
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
   LET ls_condition = agct410_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="agct410.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION agct410_query()
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
   CALL g_gcan_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL agct410_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL agct410_browser_fill("")
      CALL agct410_fetch("")
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
      CALL agct410_filter_show('gcam000')
   CALL agct410_filter_show('gcamsite')
   CALL agct410_filter_show('gcamdocno')
   CALL agct410_filter_show('gcamdocdt')
   CALL agct410_filter_show('gcam002')
   CALL agct410_filter_show('gcam001')
   CALL agct410_filter_show('gcamunit')
   CALL agct410_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL agct410_fetch("F") 
      #顯示單身筆數
      CALL agct410_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agct410.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION agct410_fetch(p_flag)
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
   
   LET g_gcam_m.gcamdocno = g_browser[g_current_idx].b_gcamdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE agct410_master_referesh USING g_gcam_m.gcamdocno INTO g_gcam_m.gcam000,g_gcam_m.gcamsite, 
       g_gcam_m.gcamunit,g_gcam_m.gcamdocdt,g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam001,g_gcam_m.gcamstus, 
       g_gcam_m.gcamownid,g_gcam_m.gcamowndp,g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdt, 
       g_gcam_m.gcammodid,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfdt,g_gcam_m.gcamsite_desc, 
       g_gcam_m.gcam002_desc,g_gcam_m.gcam001_desc,g_gcam_m.gcamownid_desc,g_gcam_m.gcamowndp_desc,g_gcam_m.gcamcrtid_desc, 
       g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcammodid_desc,g_gcam_m.gcamcnfid_desc
   
   #遮罩相關處理
   LET g_gcam_m_mask_o.* =  g_gcam_m.*
   CALL agct410_gcam_t_mask()
   LET g_gcam_m_mask_n.* =  g_gcam_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agct410_set_act_visible()   
   CALL agct410_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#160809-00027#1 -s by 08172
#   IF g_gcam_m.gcamstus = 'Y' OR g_gcam_m.gcamstus = 'X' THEN
#      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", FALSE)
#   ELSE
#      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
#   END IF
#160809-00027#1 -e by 08172
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_gcam_m_t.* = g_gcam_m.*
   LET g_gcam_m_o.* = g_gcam_m.*
   
   LET g_data_owner = g_gcam_m.gcamownid      
   LET g_data_dept  = g_gcam_m.gcamowndp
   
   #重新顯示   
   CALL agct410_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="agct410.insert" >}
#+ 資料新增
PRIVATE FUNCTION agct410_insert()
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
   CALL g_gcan_d.clear()   
 
 
   INITIALIZE g_gcam_m.* TO NULL             #DEFAULT 設定
   
   LET g_gcamdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gcam_m.gcamownid = g_user
      LET g_gcam_m.gcamowndp = g_dept
      LET g_gcam_m.gcamcrtid = g_user
      LET g_gcam_m.gcamcrtdp = g_dept 
      LET g_gcam_m.gcamcrtdt = cl_get_current()
      LET g_gcam_m.gcammodid = g_user
      LET g_gcam_m.gcammoddt = cl_get_current()
      LET g_gcam_m.gcamstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_gcam_m.gcamstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      CASE g_gcam000
         WHEN '1' 
            LET g_gcam_m.gcam000 = '1'
         WHEN '2' 
            LET g_gcam_m.gcam000 = '2'
         WHEN '3'       
            LET g_gcam_m.gcam000 = '3'
      END CASE
      LET g_gcam_m.gcamdocdt = g_today
      LET g_gcam_m.gcamunit = g_site
#      LET g_gcam_m.gcamsite = g_site
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'gcamsite',g_gcam_m.gcamsite)
         RETURNING l_insert,g_gcam_m.gcamsite
      IF NOT l_insert THEN
         RETURN
      END IF
      CALL agct410_gcamsite_ref() 
      LET  g_gcam_m_t.* =  g_gcam_m.*
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_gcam_m.gcamsite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_gcam_m.gcamdocno = l_doctype
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_gcam_m_t.* = g_gcam_m.*
      LET g_gcam_m_o.* = g_gcam_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gcam_m.gcamstus 
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
 
 
 
    
      CALL agct410_input("a")
      
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
         INITIALIZE g_gcam_m.* TO NULL
         INITIALIZE g_gcan_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL agct410_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_gcan_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agct410_set_act_visible()   
   CALL agct410_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gcamdocno_t = g_gcam_m.gcamdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " gcament = " ||g_enterprise|| " AND",
                      " gcamdocno = '", g_gcam_m.gcamdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agct410_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE agct410_cl
   
   CALL agct410_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE agct410_master_referesh USING g_gcam_m.gcamdocno INTO g_gcam_m.gcam000,g_gcam_m.gcamsite, 
       g_gcam_m.gcamunit,g_gcam_m.gcamdocdt,g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam001,g_gcam_m.gcamstus, 
       g_gcam_m.gcamownid,g_gcam_m.gcamowndp,g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdt, 
       g_gcam_m.gcammodid,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfdt,g_gcam_m.gcamsite_desc, 
       g_gcam_m.gcam002_desc,g_gcam_m.gcam001_desc,g_gcam_m.gcamownid_desc,g_gcam_m.gcamowndp_desc,g_gcam_m.gcamcrtid_desc, 
       g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcammodid_desc,g_gcam_m.gcamcnfid_desc
   
   
   #遮罩相關處理
   LET g_gcam_m_mask_o.* =  g_gcam_m.*
   CALL agct410_gcam_t_mask()
   LET g_gcam_m_mask_n.* =  g_gcam_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gcam_m.gcam000,g_gcam_m.gcamsite,g_gcam_m.gcamsite_desc,g_gcam_m.gcamunit,g_gcam_m.gcamdocdt, 
       g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam002_desc,g_gcam_m.gcam001,g_gcam_m.gcam001_desc, 
       g_gcam_m.gcamstus,g_gcam_m.gcamownid,g_gcam_m.gcamownid_desc,g_gcam_m.gcamowndp,g_gcam_m.gcamowndp_desc, 
       g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtid_desc,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcamcrtdt, 
       g_gcam_m.gcammodid,g_gcam_m.gcammodid_desc,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfid_desc, 
       g_gcam_m.gcamcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_gcam_m.gcamownid      
   LET g_data_dept  = g_gcam_m.gcamowndp
   
   #功能已完成,通報訊息中心
   CALL agct410_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="agct410.modify" >}
#+ 資料修改
PRIVATE FUNCTION agct410_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_gcam_m_t.* = g_gcam_m.*
   LET g_gcam_m_o.* = g_gcam_m.*
   
   IF g_gcam_m.gcamdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_gcamdocno_t = g_gcam_m.gcamdocno
 
   CALL s_transaction_begin()
   
   OPEN agct410_cl USING g_enterprise,g_gcam_m.gcamdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agct410_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agct410_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agct410_master_referesh USING g_gcam_m.gcamdocno INTO g_gcam_m.gcam000,g_gcam_m.gcamsite, 
       g_gcam_m.gcamunit,g_gcam_m.gcamdocdt,g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam001,g_gcam_m.gcamstus, 
       g_gcam_m.gcamownid,g_gcam_m.gcamowndp,g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdt, 
       g_gcam_m.gcammodid,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfdt,g_gcam_m.gcamsite_desc, 
       g_gcam_m.gcam002_desc,g_gcam_m.gcam001_desc,g_gcam_m.gcamownid_desc,g_gcam_m.gcamowndp_desc,g_gcam_m.gcamcrtid_desc, 
       g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcammodid_desc,g_gcam_m.gcamcnfid_desc
   
   #檢查是否允許此動作
   IF NOT agct410_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gcam_m_mask_o.* =  g_gcam_m.*
   CALL agct410_gcam_t_mask()
   LET g_gcam_m_mask_n.* =  g_gcam_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL agct410_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_gcamdocno_t = g_gcam_m.gcamdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_gcam_m.gcammodid = g_user 
LET g_gcam_m.gcammoddt = cl_get_current()
LET g_gcam_m.gcammodid_desc = cl_get_username(g_gcam_m.gcammodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL agct410_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE gcam_t SET (gcammodid,gcammoddt) = (g_gcam_m.gcammodid,g_gcam_m.gcammoddt)
          WHERE gcament = g_enterprise AND gcamdocno = g_gcamdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_gcam_m.* = g_gcam_m_t.*
            CALL agct410_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_gcam_m.gcamdocno != g_gcam_m_t.gcamdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE gcan_t SET gcandocno = g_gcam_m.gcamdocno
 
          WHERE gcanent = g_enterprise AND gcandocno = g_gcam_m_t.gcamdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gcan_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gcan_t:",SQLERRMESSAGE 
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
   CALL agct410_set_act_visible()   
   CALL agct410_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " gcament = " ||g_enterprise|| " AND",
                      " gcamdocno = '", g_gcam_m.gcamdocno, "' "
 
   #填到對應位置
   CALL agct410_browser_fill("")
 
   CLOSE agct410_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agct410_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="agct410.input" >}
#+ 資料輸入
PRIVATE FUNCTION agct410_input(p_cmd)
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
   DEFINE l_flag           LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_success             LIKE type_t.num5
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
   DISPLAY BY NAME g_gcam_m.gcam000,g_gcam_m.gcamsite,g_gcam_m.gcamsite_desc,g_gcam_m.gcamunit,g_gcam_m.gcamdocdt, 
       g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam002_desc,g_gcam_m.gcam001,g_gcam_m.gcam001_desc, 
       g_gcam_m.gcamstus,g_gcam_m.gcamownid,g_gcam_m.gcamownid_desc,g_gcam_m.gcamowndp,g_gcam_m.gcamowndp_desc, 
       g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtid_desc,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcamcrtdt, 
       g_gcam_m.gcammodid,g_gcam_m.gcammodid_desc,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfid_desc, 
       g_gcam_m.gcamcnfdt
   
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
   LET g_forupd_sql = "SELECT gcanunit,gcanseq,gcansite,gcan001,gcan002,gcan003,gcan004 FROM gcan_t  
       WHERE gcanent=? AND gcandocno=? AND gcanseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agct410_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL agct410_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL agct410_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_gcam_m.gcamsite,g_gcam_m.gcamunit,g_gcam_m.gcamdocdt,g_gcam_m.gcamdocno,g_gcam_m.gcam002, 
       g_gcam_m.gcam001,g_gcam_m.gcamstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   DISPLAY BY NAME g_gcam_m.gcam000
   LET g_ooef004 = ''
   LET g_ooef005 = ''
   SELECT ooef004,ooef005 INTO g_ooef004,g_ooef005 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   IF cl_null(g_ooef005) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00008'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="agct410.input.head" >}
      #單頭段
      INPUT BY NAME g_gcam_m.gcamsite,g_gcam_m.gcamunit,g_gcam_m.gcamdocdt,g_gcam_m.gcamdocno,g_gcam_m.gcam002, 
          g_gcam_m.gcam001,g_gcam_m.gcamstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN agct410_cl USING g_enterprise,g_gcam_m.gcamdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agct410_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agct410_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL agct410_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL agct410_set_entry(p_cmd)
            CALL agct410_set_no_entry(p_cmd)
            CALL cl_showmsg_init()
            #end add-point
            CALL agct410_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamsite
            
            #add-point:AFTER FIELD gcamsite name="input.a.gcamsite"
            LET g_gcam_m.gcamsite_desc = ' '
            DISPLAY BY NAME g_gcam_m.gcamsite_desc
            IF NOT cl_null(g_gcam_m.gcamsite) THEN
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_errshow = '1'
#                  LET g_chkparam.arg1 = g_gcam_m.gcamsite
#                  LET g_chkparam.arg2 = '2'
#                  LET g_chkparam.arg3 = g_site
#                  IF NOT cl_chk_exist("v_ooed004") THEN
#                     LET g_gcam_m.gcamsite = g_gcam_m_t.gcamsite
#                     CALL agct410_gcamsite_ref()
#                     NEXT FIELD CURRENT
#                  END IF
               CALL s_aooi500_chk(g_prog,'gcamsite',g_gcam_m.gcamsite,g_gcam_m.gcamsite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_gcam_m.gcamsite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_gcam_m.gcamsite = g_gcam_m_t.gcamsite
                  CALL s_desc_get_department_desc(g_gcam_m.gcamsite) RETURNING g_gcam_m.gcamsite_desc
                  DISPLAY BY NAME g_gcam_m.gcamsite,g_gcam_m.gcamsite_desc
                  NEXT FIELD CURRENT
               END IF

               LET g_site_flag = TRUE
               CALL agct410_set_entry(p_cmd)
               CALL agct410_set_no_entry(p_cmd)
            END IF
            CALL agct410_gcamsite_ref()
            LET g_gcam_m.gcamunit = g_gcam_m.gcamsite
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamsite
            #add-point:BEFORE FIELD gcamsite name="input.b.gcamsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcamsite
            #add-point:ON CHANGE gcamsite name="input.g.gcamsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamunit
            #add-point:BEFORE FIELD gcamunit name="input.b.gcamunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamunit
            
            #add-point:AFTER FIELD gcamunit name="input.a.gcamunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcamunit
            #add-point:ON CHANGE gcamunit name="input.g.gcamunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamdocdt
            #add-point:BEFORE FIELD gcamdocdt name="input.b.gcamdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamdocdt
            
            #add-point:AFTER FIELD gcamdocdt name="input.a.gcamdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcamdocdt
            #add-point:ON CHANGE gcamdocdt name="input.g.gcamdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamdocno
            #add-point:BEFORE FIELD gcamdocno name="input.b.gcamdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamdocno
            
            #add-point:AFTER FIELD gcamdocno name="input.a.gcamdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_gcam_m.gcamdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gcam_m.gcamdocno != g_gcamdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gcam_t WHERE "||"gcament = '" ||g_enterprise|| "' AND "||"gcamdocno = '"||g_gcam_m.gcamdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF p_cmd = 'a' THEN
                  IF NOT s_aooi200_chk_slip(g_site,'',g_gcam_m.gcamdocno,g_prog) THEN
                     LET g_gcam_m.gcamdocno = g_gcam_m_t.gcamdocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcamdocno
            #add-point:ON CHANGE gcamdocno name="input.g.gcamdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcam002
            
            #add-point:AFTER FIELD gcam002 name="input.a.gcam002"
            LET g_gcam_m.gcam002_desc = ''
            DISPLAY BY NAME  g_gcam_m.gcam002_desc 
           IF NOT cl_null(g_gcam_m.gcam002) THEN
               IF NOT s_azzi650_chk_exist('2055',g_gcam_m.gcam002) THEN
                  LET g_gcam_m.gcam002 = g_gcam_m_t.gcam002
                  CALL agct410_gcam002_ref()
                  NEXT FIELD gcam002
               END IF          
            END IF 
            CALL agct410_gcam002_ref()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcam002
            #add-point:BEFORE FIELD gcam002 name="input.b.gcam002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcam002
            #add-point:ON CHANGE gcam002 name="input.g.gcam002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcam001
            
            #add-point:AFTER FIELD gcam001 name="input.a.gcam001"
            LET g_gcam_m.gcam001_desc = ''
            DISPLAY BY NAME  g_gcam_m.gcam001_desc 
           IF NOT cl_null(g_gcam_m.gcam001) THEN
               IF NOT s_azzi650_chk_exist('2056',g_gcam_m.gcam001) THEN
                  LET g_gcam_m.gcam001 = g_gcam_m_t.gcam001
                  CALL agct410_gcam001_ref()
                  NEXT FIELD gcam001
               END IF          
            END IF 
            CALL agct410_gcam001_ref() 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcam001
            #add-point:BEFORE FIELD gcam001 name="input.b.gcam001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcam001
            #add-point:ON CHANGE gcam001 name="input.g.gcam001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcamstus
            #add-point:BEFORE FIELD gcamstus name="input.b.gcamstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcamstus
            
            #add-point:AFTER FIELD gcamstus name="input.a.gcamstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcamstus
            #add-point:ON CHANGE gcamstus name="input.g.gcamstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gcamsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamsite
            #add-point:ON ACTION controlp INFIELD gcamsite name="input.c.gcamsite"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcam_m.gcamsite             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_site #
#            LET g_qryparam.arg2 = "2" #
#
#            CALL q_ooed004()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcamsite',g_gcam_m.gcamsite,'i') #150308-00001#2  By sakura add 'i'
            CALL q_ooef001_24()

            LET g_gcam_m.gcamsite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcam_m.gcamsite TO gcamsite              #顯示到畫面上

            NEXT FIELD gcamsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gcamunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamunit
            #add-point:ON ACTION controlp INFIELD gcamunit name="input.c.gcamunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcamdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamdocdt
            #add-point:ON ACTION controlp INFIELD gcamdocdt name="input.c.gcamdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.gcamdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamdocno
            #add-point:ON ACTION controlp INFIELD gcamdocno name="input.c.gcamdocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcam_m.gcamdocno             #給予default值

            #給予arg            
            LET g_qryparam.arg1 = g_ooef004 #
            #LET g_qryparam.arg2 = 'agct410' #        160519-00030#1 mark
            #160705-00042#11 160715 by sakura mark(S)            
            ##160519-00030#1 add(S)
            #CASE g_gcam000 
			   #WHEN '1'
			   #   LET g_qryparam.arg2 = 'agct412'
			   #WHEN '2'
			   #   LET g_qryparam.arg2 = 'agct413'
            #WHEN '3'  
            #   LET g_qryparam.arg2 = 'agct414' 
			   #END CASE
            ##160519-00030#1 add(S)
            #160705-00042#11 160715 by sakura mark(E)
            LET g_qryparam.arg2 = g_prog   #160705-00042#11 160715 by sakura add
           
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_gcam_m.gcamdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcam_m.gcamdocno TO gcamdocno              #顯示到畫面上

            NEXT FIELD gcamdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gcam002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcam002
            #add-point:ON ACTION controlp INFIELD gcam002 name="input.c.gcam002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcam_m.gcam002             #給予default值
            LET g_qryparam.default2 = "" #g_gcam_m.oocq010 #參考欄位七

            #給予arg
            LET g_qryparam.arg1 = '2055' #

            CALL q_oocq002()                                #呼叫開窗

            LET g_gcam_m.gcam002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_gcam_m.oocq010 = g_qryparam.return2 #參考欄位七

            DISPLAY g_gcam_m.gcam002 TO gcam002              #顯示到畫面上
            #DISPLAY g_gcam_m.oocq010 TO oocq010 #參考欄位七

            NEXT FIELD gcam002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gcam001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcam001
            #add-point:ON ACTION controlp INFIELD gcam001 name="input.c.gcam001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcam_m.gcam001             #給予default值
            LET g_qryparam.default2 = "" #g_gcam_m.oocq010 #參考欄位七

            #給予arg
            LET g_qryparam.arg1 = '2056' #

            CALL q_oocq002()                                #呼叫開窗

            LET g_gcam_m.gcam001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_gcam_m.oocq010 = g_qryparam.return2 #參考欄位七

            DISPLAY g_gcam_m.gcam001 TO gcam001              #顯示到畫面上
            #DISPLAY g_gcam_m.oocq010 TO oocq010 #參考欄位七

            NEXT FIELD gcam001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gcamstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcamstus
            #add-point:ON ACTION controlp INFIELD gcamstus name="input.c.gcamstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_gcam_m.gcamdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                  CALL s_aooi200_gen_docno(g_site,g_gcam_m.gcamdocno,g_gcam_m.gcamdocdt,g_prog) RETURNING l_flag,g_gcam_m.gcamdocno
                  IF NOT l_flag THEN
                     NEXT FIELD gcamdocno
                  END IF
               #end add-point
               
               INSERT INTO gcam_t (gcament,gcam000,gcamsite,gcamunit,gcamdocdt,gcamdocno,gcam002,gcam001, 
                   gcamstus,gcamownid,gcamowndp,gcamcrtid,gcamcrtdp,gcamcrtdt,gcammodid,gcammoddt,gcamcnfid, 
                   gcamcnfdt)
               VALUES (g_enterprise,g_gcam_m.gcam000,g_gcam_m.gcamsite,g_gcam_m.gcamunit,g_gcam_m.gcamdocdt, 
                   g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam001,g_gcam_m.gcamstus,g_gcam_m.gcamownid, 
                   g_gcam_m.gcamowndp,g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdt,g_gcam_m.gcammodid, 
                   g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_gcam_m:",SQLERRMESSAGE 
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
                  CALL agct410_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL agct410_b_fill()
                  CALL agct410_b_fill2('0')
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
               CALL agct410_gcam_t_mask_restore('restore_mask_o')
               
               UPDATE gcam_t SET (gcam000,gcamsite,gcamunit,gcamdocdt,gcamdocno,gcam002,gcam001,gcamstus, 
                   gcamownid,gcamowndp,gcamcrtid,gcamcrtdp,gcamcrtdt,gcammodid,gcammoddt,gcamcnfid,gcamcnfdt) = (g_gcam_m.gcam000, 
                   g_gcam_m.gcamsite,g_gcam_m.gcamunit,g_gcam_m.gcamdocdt,g_gcam_m.gcamdocno,g_gcam_m.gcam002, 
                   g_gcam_m.gcam001,g_gcam_m.gcamstus,g_gcam_m.gcamownid,g_gcam_m.gcamowndp,g_gcam_m.gcamcrtid, 
                   g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdt,g_gcam_m.gcammodid,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid, 
                   g_gcam_m.gcamcnfdt)
                WHERE gcament = g_enterprise AND gcamdocno = g_gcamdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gcam_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL agct410_gcam_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_gcam_m_t)
               LET g_log2 = util.JSON.stringify(g_gcam_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_gcamdocno_t = g_gcam_m.gcamdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="agct410.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_gcan_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #如果单身没资料提示
            LET l_n = 0
            SELECT COUNT(1) INTO l_n
              FROM gcan_t
             WHERE gcanent = g_enterprise
               AND gcandocno = g_gcam_m.gcamdocno
            IF l_n = 0 THEN 
               IF cl_ask_confirm('agc-00112') THEN  
                  CALL agct410_01()
               END IF 
            END IF 
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gcan_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agct410_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_gcan_d.getLength()
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
            OPEN agct410_cl USING g_enterprise,g_gcam_m.gcamdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agct410_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agct410_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gcan_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gcan_d[l_ac].gcanseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gcan_d_t.* = g_gcan_d[l_ac].*  #BACKUP
               LET g_gcan_d_o.* = g_gcan_d[l_ac].*  #BACKUP
               CALL agct410_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL agct410_set_no_entry_b(l_cmd)
               IF NOT agct410_lock_b("gcan_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agct410_bcl INTO g_gcan_d[l_ac].gcanunit,g_gcan_d[l_ac].gcanseq,g_gcan_d[l_ac].gcansite, 
                      g_gcan_d[l_ac].gcan001,g_gcan_d[l_ac].gcan002,g_gcan_d[l_ac].gcan003,g_gcan_d[l_ac].gcan004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gcan_d_t.gcanseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gcan_d_mask_o[l_ac].* =  g_gcan_d[l_ac].*
                  CALL agct410_gcan_t_mask()
                  LET g_gcan_d_mask_n[l_ac].* =  g_gcan_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agct410_show()
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
            INITIALIZE g_gcan_d[l_ac].* TO NULL 
            INITIALIZE g_gcan_d_t.* TO NULL 
            INITIALIZE g_gcan_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_gcan_d_t.* = g_gcan_d[l_ac].*     #新輸入資料
            LET g_gcan_d_o.* = g_gcan_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agct410_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL agct410_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gcan_d[li_reproduce_target].* = g_gcan_d[li_reproduce].*
 
               LET g_gcan_d[li_reproduce_target].gcanseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(gcanseq)+1 INTO g_gcan_d[l_ac].gcanseq FROM gcan_t
             WHERE gcanent = g_enterprise AND gcandocno = g_gcam_m.gcamdocno
            IF cl_null(g_gcan_d[l_ac].gcanseq) THEN
               LET g_gcan_d[l_ac].gcanseq = 1
            END IF
            LET g_gcan_d[l_ac].gcanunit = g_gcam_m.gcamunit
            LET g_gcan_d[l_ac].gcansite = g_gcam_m.gcamsite
            CALL agct410_gcansite_ref()   #150525-00013#1
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
            SELECT COUNT(1) INTO l_count FROM gcan_t 
             WHERE gcanent = g_enterprise AND gcandocno = g_gcam_m.gcamdocno
 
               AND gcanseq = g_gcan_d[l_ac].gcanseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcam_m.gcamdocno
               LET gs_keys[2] = g_gcan_d[g_detail_idx].gcanseq
               CALL agct410_insert_b('gcan_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_gcan_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gcan_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agct410_b_fill()
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
               LET gs_keys[01] = g_gcam_m.gcamdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_gcan_d_t.gcanseq
 
            
               #刪除同層單身
               IF NOT agct410_delete_b('gcan_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct410_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agct410_key_delete_b(gs_keys,'gcan_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct410_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE agct410_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_gcan_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gcan_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcanunit
            #add-point:BEFORE FIELD gcanunit name="input.b.page1.gcanunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcanunit
            
            #add-point:AFTER FIELD gcanunit name="input.a.page1.gcanunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcanunit
            #add-point:ON CHANGE gcanunit name="input.g.page1.gcanunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcanseq
            #add-point:BEFORE FIELD gcanseq name="input.b.page1.gcanseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcanseq
            
            #add-point:AFTER FIELD gcanseq name="input.a.page1.gcanseq"
            #此段落由子樣板a05產生
            IF  g_gcam_m.gcamdocno IS NOT NULL AND g_gcan_d[g_detail_idx].gcanseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gcam_m.gcamdocno != g_gcamdocno_t OR g_gcan_d[g_detail_idx].gcanseq != g_gcan_d_t.gcanseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gcan_t WHERE "||"gcanent = '" ||g_enterprise|| "' AND "||"gcandocno = '"||g_gcam_m.gcamdocno ||"' AND "|| "gcanseq = '"||g_gcan_d[g_detail_idx].gcanseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcanseq
            #add-point:ON CHANGE gcanseq name="input.g.page1.gcanseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcansite
            
            #add-point:AFTER FIELD gcansite name="input.a.page1.gcansite"
            LET g_gcan_d[l_ac].gcansite_desc = ' '
            DISPLAY BY NAME g_gcan_d[l_ac].gcansite_desc
            IF NOT cl_null(g_gcan_d[l_ac].gcansite) THEN
#               IF NOT agct410_gcansite_chk() THEN
#                  LET g_gcan_d[l_ac].gcansite = g_gcan_d_t.gcansite
#                  CALL agct410_gcansite_ref()
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_aooi500_chk(g_prog,'gcansite',g_gcan_d[l_ac].gcansite,g_gcam_m.gcamsite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_gcan_d[l_ac].gcansite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_gcan_d[l_ac].gcansite = g_gcan_d_t.gcansite
                  CALL s_desc_get_department_desc(g_gcan_d[l_ac].gcansite) RETURNING g_gcan_d[l_ac].gcansite_desc
                  DISPLAY BY NAME g_gcan_d[l_ac].gcansite,g_gcan_d[l_ac].gcansite_desc
                  NEXT FIELD CURRENT
               END IF 
            END IF
            CALL agct410_gcansite_ref()
            
          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcansite
            #add-point:BEFORE FIELD gcansite name="input.b.page1.gcansite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcansite
            #add-point:ON CHANGE gcansite name="input.g.page1.gcansite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcan001
            
            #add-point:AFTER FIELD gcan001 name="input.a.page1.gcan001"
            LET g_gcan_d[l_ac].gcan001_desc = ' '
            DISPLAY BY NAME g_gcan_d[l_ac].gcan001_desc
            IF NOT cl_null(g_gcan_d[l_ac].gcan001) THEN
               IF NOT agct410_gcan001_chk() THEN
                  #LET g_gcan_d[l_ac].gcan001 = g_gcan_d_t.gcan001   #160824-00007#102 20161024 mark by beckxie
                  #160824-00007#102 20161024 add by beckxie---S
                  LET g_gcan_d[l_ac].gcan001      = g_gcan_d_o.gcan001
                  LET g_gcan_d[l_ac].gcan001_desc = g_gcan_d_o.gcan001_desc
                  LET g_gcan_d[l_ac].gcan002      = g_gcan_d_o.gcan002     
                  LET g_gcan_d[l_ac].gcan002_desc = g_gcan_d_o.gcan002_desc
                  IF g_gcam_m.gcam000 = '2' THEN 
                     LET g_gcan_d[l_ac].gcan004 = g_gcan_d_o.gcan004
                     DISPLAY BY NAME g_gcan_d[l_ac].gcan004
                  END IF
                  IF g_gcam_m.gcam000 = '2' OR g_gcam_m.gcam000 = '3' THEN
                     LET g_gcan_d[l_ac].gcan003 = g_gcan_d_o.gcan003
                     DISPLAY BY NAME g_gcan_d[l_ac].gcan003
                  END IF
                  DISPLAY BY NAME g_gcan_d[l_ac].gcan001,g_gcan_d[l_ac].gcan001_desc,g_gcan_d[l_ac].gcan002,g_gcan_d[l_ac].gcan002_desc
                  #160824-00007#102 20161024 add by beckxie---E
                  #CALL agct410_gcan001_ref()   #160824-00007#102 20161024 mark by beckxie
                  NEXT FIELD CURRENT
               END IF
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_gcan_d[l_ac].gcan001 != g_gcan_d_t.gcan001) THEN 
                  SELECT COUNT(1) INTO l_n FROM gcan_t 
                   WHERE gcanent = g_enterprise AND gcandocno = g_gcam_m.gcamdocno AND gcan001 = g_gcan_d[l_ac].gcan001
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agc-00076'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_gcan_d[l_ac].gcan001 = g_gcan_d_t.gcan001   #160824-00007#102 20161024 mark by beckxie
                     #160824-00007#102 20161024 add by beckxie---S
                     LET g_gcan_d[l_ac].gcan001      = g_gcan_d_o.gcan001
                     LET g_gcan_d[l_ac].gcan001_desc = g_gcan_d_o.gcan001_desc
                     LET g_gcan_d[l_ac].gcan002      = g_gcan_d_o.gcan002     
                     LET g_gcan_d[l_ac].gcan002_desc = g_gcan_d_o.gcan002_desc
                     IF g_gcam_m.gcam000 = '2' THEN 
                        LET g_gcan_d[l_ac].gcan004 = g_gcan_d_o.gcan004
                        DISPLAY BY NAME g_gcan_d[l_ac].gcan004
                     END IF
                     IF g_gcam_m.gcam000 = '2' OR g_gcam_m.gcam000 = '3' THEN
                        LET g_gcan_d[l_ac].gcan003 = g_gcan_d_o.gcan003
                        DISPLAY BY NAME g_gcan_d[l_ac].gcan003
                     END IF
                     DISPLAY BY NAME g_gcan_d[l_ac].gcan001,g_gcan_d[l_ac].gcan001_desc,g_gcan_d[l_ac].gcan002,g_gcan_d[l_ac].gcan002_desc
                     #160824-00007#102 20161024 add by beckxie---E
                     #CALL agct410_gcan001_ref()   #160824-00007#102 20161024 mark by beckxie
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL agct410_gcan001_ref()
            
            LET g_gcan_d_o.* = g_gcan_d[l_ac].*   #160824-00007#102 20161024 add by beckxie
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcan001
            #add-point:BEFORE FIELD gcan001 name="input.b.page1.gcan001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcan001
            #add-point:ON CHANGE gcan001 name="input.g.page1.gcan001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcan002
            
            #add-point:AFTER FIELD gcan002 name="input.a.page1.gcan002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gcan_d[l_ac].gcan002
            CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gcan_d[l_ac].gcan002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gcan_d[l_ac].gcan002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcan002
            #add-point:BEFORE FIELD gcan002 name="input.b.page1.gcan002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcan002
            #add-point:ON CHANGE gcan002 name="input.g.page1.gcan002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcan003
            #add-point:BEFORE FIELD gcan003 name="input.b.page1.gcan003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcan003
            
            #add-point:AFTER FIELD gcan003 name="input.a.page1.gcan003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcan003
            #add-point:ON CHANGE gcan003 name="input.g.page1.gcan003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gcan004
            #add-point:BEFORE FIELD gcan004 name="input.b.page1.gcan004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gcan004
            
            #add-point:AFTER FIELD gcan004 name="input.a.page1.gcan004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gcan004
            #add-point:ON CHANGE gcan004 name="input.g.page1.gcan004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gcanunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcanunit
            #add-point:ON ACTION controlp INFIELD gcanunit name="input.c.page1.gcanunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcanseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcanseq
            #add-point:ON ACTION controlp INFIELD gcanseq name="input.c.page1.gcanseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcansite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcansite
            #add-point:ON ACTION controlp INFIELD gcansite name="input.c.page1.gcansite"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcan_d[l_ac].gcansite             #給予default值

            IF g_gcam_m.gcam000 = '1' OR g_gcam_m.gcam000 = '2' THEN
               #給予arg
#               LET g_qryparam.arg1 = g_gcam_m.gcamsite #
#               LET g_qryparam.arg2 = "2" #
#               CALL q_ooed004()                                #呼叫開窗
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcansite',g_gcam_m.gcamsite,'i') #150308-00001#2  By sakura add 'i'
               CALL q_ooef001_24()

            END IF
            IF g_gcam_m.gcam000 = '3' THEN
               LET g_qryparam.arg1 = g_gcam_m.gcamsite 
               CALL q_gcao026()
            END IF

            LET g_gcan_d[l_ac].gcansite = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agct410_gcansite_ref()
            DISPLAY g_gcan_d[l_ac].gcansite TO gcansite              #顯示到畫面上

            NEXT FIELD gcansite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcan001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcan001
            #add-point:ON ACTION controlp INFIELD gcan001 name="input.c.page1.gcan001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gcan_d[l_ac].gcan001             #給予default值
            

            #給予arg
            LET g_qryparam.arg1 =  g_gcan_d[l_ac].gcansite 
            
            CASE g_gcam_m.gcam000 
               WHEN '1'
                  CALL q_gcao001_1()   
               WHEN '2'
                  CALL q_gcao001_8()
               WHEN '3'
                  CALL q_gcao001_3()   
            END CASE
                                        #呼叫開窗

            LET g_gcan_d[l_ac].gcan001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_gcan_d[l_ac].gcan001 TO gcan001              #顯示到畫面上
            CALL agct410_gcan001_ref()   #160824-00007#102 20161024 add by beckxie
            NEXT FIELD gcan001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.gcan002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcan002
            #add-point:ON ACTION controlp INFIELD gcan002 name="input.c.page1.gcan002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcan003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcan003
            #add-point:ON ACTION controlp INFIELD gcan003 name="input.c.page1.gcan003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gcan004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gcan004
            #add-point:ON ACTION controlp INFIELD gcan004 name="input.c.page1.gcan004"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gcan_d[l_ac].* = g_gcan_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agct410_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gcan_d[l_ac].gcanseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_gcan_d[l_ac].* = g_gcan_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL agct410_gcan_t_mask_restore('restore_mask_o')
      
               UPDATE gcan_t SET (gcandocno,gcanunit,gcanseq,gcansite,gcan001,gcan002,gcan003,gcan004) = (g_gcam_m.gcamdocno, 
                   g_gcan_d[l_ac].gcanunit,g_gcan_d[l_ac].gcanseq,g_gcan_d[l_ac].gcansite,g_gcan_d[l_ac].gcan001, 
                   g_gcan_d[l_ac].gcan002,g_gcan_d[l_ac].gcan003,g_gcan_d[l_ac].gcan004)
                WHERE gcanent = g_enterprise AND gcandocno = g_gcam_m.gcamdocno 
 
                  AND gcanseq = g_gcan_d_t.gcanseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gcan_d[l_ac].* = g_gcan_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcan_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gcan_d[l_ac].* = g_gcan_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gcan_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gcam_m.gcamdocno
               LET gs_keys_bak[1] = g_gcamdocno_t
               LET gs_keys[2] = g_gcan_d[g_detail_idx].gcanseq
               LET gs_keys_bak[2] = g_gcan_d_t.gcanseq
               CALL agct410_update_b('gcan_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL agct410_gcan_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_gcan_d[g_detail_idx].gcanseq = g_gcan_d_t.gcanseq 
 
                  ) THEN
                  LET gs_keys[01] = g_gcam_m.gcamdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gcan_d_t.gcanseq
 
                  CALL agct410_key_update_b(gs_keys,'gcan_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gcam_m),util.JSON.stringify(g_gcan_d_t)
               LET g_log2 = util.JSON.stringify(g_gcam_m),util.JSON.stringify(g_gcan_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL agct410_unlock_b("gcan_t","'1'")
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
               LET g_gcan_d[li_reproduce_target].* = g_gcan_d[li_reproduce].*
 
               LET g_gcan_d[li_reproduce_target].gcanseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gcan_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gcan_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="agct410.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD gcamsite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gcanunit
 
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
            NEXT FIELD gcamdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gcanunit
 
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
 
{<section id="agct410.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION agct410_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL agct410_b_fill() #單身填充
      CALL agct410_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL agct410_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
    #  CALL agct410_gcamsite_ref() 
    #  CALL agct410_gcam001_ref() 
    #  CALL agct410_gcam002_ref()  
    #  
    #       INITIALIZE g_ref_fields TO NULL
    #        LET g_ref_fields[1] = g_gcam_m.gcamownid
    #        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
    #        LET g_gcam_m.gcamownid_desc = '', g_rtn_fields[1] , ''
    #        DISPLAY BY NAME g_gcam_m.gcamownid_desc
    #
    #        INITIALIZE g_ref_fields TO NULL
    #        LET g_ref_fields[1] = g_gcam_m.gcamowndp
    #        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    #        LET g_gcam_m.gcamowndp_desc = '', g_rtn_fields[1] , ''
    #        DISPLAY BY NAME g_gcam_m.gcamowndp_desc
    #
    #        INITIALIZE g_ref_fields TO NULL
    #        LET g_ref_fields[1] = g_gcam_m.gcamcrtid
    #        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
    #        LET g_gcam_m.gcamcrtid_desc = '', g_rtn_fields[1] , ''
    #        DISPLAY BY NAME g_gcam_m.gcamcrtid_desc
    #
    #        INITIALIZE g_ref_fields TO NULL
    #        LET g_ref_fields[1] = g_gcam_m.gcamcrtdp
    #        CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    #        LET g_gcam_m.gcamcrtdp_desc = '', g_rtn_fields[1] , ''
    #        DISPLAY BY NAME g_gcam_m.gcamcrtdp_desc
    #
    #        INITIALIZE g_ref_fields TO NULL
    #        LET g_ref_fields[1] = g_gcam_m.gcammodid
    #        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
    #        LET g_gcam_m.gcammodid_desc = '', g_rtn_fields[1] , ''
    #        DISPLAY BY NAME g_gcam_m.gcammodid_desc
    #
    #        INITIALIZE g_ref_fields TO NULL
    #        LET g_ref_fields[1] = g_gcam_m.gcamcnfid
    #        CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
    #        LET g_gcam_m.gcamcnfid_desc = '', g_rtn_fields[1] , ''
    #        DISPLAY BY NAME g_gcam_m.gcamcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_gcam_m_mask_o.* =  g_gcam_m.*
   CALL agct410_gcam_t_mask()
   LET g_gcam_m_mask_n.* =  g_gcam_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gcam_m.gcam000,g_gcam_m.gcamsite,g_gcam_m.gcamsite_desc,g_gcam_m.gcamunit,g_gcam_m.gcamdocdt, 
       g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam002_desc,g_gcam_m.gcam001,g_gcam_m.gcam001_desc, 
       g_gcam_m.gcamstus,g_gcam_m.gcamownid,g_gcam_m.gcamownid_desc,g_gcam_m.gcamowndp,g_gcam_m.gcamowndp_desc, 
       g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtid_desc,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcamcrtdt, 
       g_gcam_m.gcammodid,g_gcam_m.gcammodid_desc,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfid_desc, 
       g_gcam_m.gcamcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gcam_m.gcamstus 
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
   FOR l_ac = 1 TO g_gcan_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      #     CALL agct410_gcansite_ref()
      #    INITIALIZE g_ref_fields TO NULL
      #    LET g_ref_fields[1] = g_gcan_d[l_ac].gcan001
      #    CALL ap_ref_array2(g_ref_fields,"SELECT gcao002,gcao004 FROM gcao_t WHERE gcaoent='"||g_enterprise||"' AND gcao001=? ","") RETURNING g_rtn_fields
      #    LET g_gcan_d[l_ac].gcan002 = '', g_rtn_fields[1] , ''
      #    LET g_gcan_d[l_ac].gcan001_desc = '', g_rtn_fields[2] , ''
      # 
      #    
      #    INITIALIZE g_ref_fields TO NULL
      #    LET g_ref_fields[1] = g_gcan_d[l_ac].gcan002
      #    CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #    LET g_gcan_d[l_ac].gcan002_desc = '', g_rtn_fields[1] , ''
      #    DISPLAY BY NAME g_gcan_d[l_ac].gcan002,g_gcan_d[l_ac].gcan002_desc,g_gcan_d[l_ac].gcan001_desc
           
       
           IF g_gcam_m.gcam000 = '2' OR g_gcam_m.gcam000 = '3' THEN
             SELECT gcao009 INTO g_gcan_d[l_ac].gcan003 FROM gcao_t 
              WHERE gcaoent = g_enterprise AND gcao001 = g_gcan_d[l_ac].gcan001
             DISPLAY BY NAME g_gcan_d[l_ac].gcan003
           END IF

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL agct410_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="agct410.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION agct410_detail_show()
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
 
{<section id="agct410.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION agct410_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE gcam_t.gcamdocno 
   DEFINE l_oldno     LIKE gcam_t.gcamdocno 
 
   DEFINE l_master    RECORD LIKE gcam_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gcan_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
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
   
   IF g_gcam_m.gcamdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_gcamdocno_t = g_gcam_m.gcamdocno
 
    
   LET g_gcam_m.gcamdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gcam_m.gcamownid = g_user
      LET g_gcam_m.gcamowndp = g_dept
      LET g_gcam_m.gcamcrtid = g_user
      LET g_gcam_m.gcamcrtdp = g_dept 
      LET g_gcam_m.gcamcrtdt = cl_get_current()
      LET g_gcam_m.gcammodid = g_user
      LET g_gcam_m.gcammoddt = cl_get_current()
      LET g_gcam_m.gcamstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gcam_m.gcamstus 
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
   
   
   CALL agct410_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_gcam_m.* TO NULL
      INITIALIZE g_gcan_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL agct410_show()
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
   CALL agct410_set_act_visible()   
   CALL agct410_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gcamdocno_t = g_gcam_m.gcamdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " gcament = " ||g_enterprise|| " AND",
                      " gcamdocno = '", g_gcam_m.gcamdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agct410_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL agct410_idx_chk()
   
   LET g_data_owner = g_gcam_m.gcamownid      
   LET g_data_dept  = g_gcam_m.gcamowndp
   
   #功能已完成,通報訊息中心
   CALL agct410_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="agct410.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION agct410_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gcan_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE agct410_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gcan_t
    WHERE gcanent = g_enterprise AND gcandocno = g_gcamdocno_t
 
    INTO TEMP agct410_detail
 
   #將key修正為調整後   
   UPDATE agct410_detail 
      #更新key欄位
      SET gcandocno = g_gcam_m.gcamdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO gcan_t SELECT * FROM agct410_detail
   
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
   DROP TABLE agct410_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gcamdocno_t = g_gcam_m.gcamdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="agct410.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agct410_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_gcam_m.gcamdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN agct410_cl USING g_enterprise,g_gcam_m.gcamdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agct410_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agct410_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agct410_master_referesh USING g_gcam_m.gcamdocno INTO g_gcam_m.gcam000,g_gcam_m.gcamsite, 
       g_gcam_m.gcamunit,g_gcam_m.gcamdocdt,g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam001,g_gcam_m.gcamstus, 
       g_gcam_m.gcamownid,g_gcam_m.gcamowndp,g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdt, 
       g_gcam_m.gcammodid,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfdt,g_gcam_m.gcamsite_desc, 
       g_gcam_m.gcam002_desc,g_gcam_m.gcam001_desc,g_gcam_m.gcamownid_desc,g_gcam_m.gcamowndp_desc,g_gcam_m.gcamcrtid_desc, 
       g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcammodid_desc,g_gcam_m.gcamcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT agct410_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gcam_m_mask_o.* =  g_gcam_m.*
   CALL agct410_gcam_t_mask()
   LET g_gcam_m_mask_n.* =  g_gcam_m.*
   
   CALL agct410_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agct410_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_gcamdocno_t = g_gcam_m.gcamdocno
 
 
      DELETE FROM gcam_t
       WHERE gcament = g_enterprise AND gcamdocno = g_gcam_m.gcamdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_gcam_m.gcamdocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM gcan_t
       WHERE gcanent = g_enterprise AND gcandocno = g_gcam_m.gcamdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcan_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_gcam_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE agct410_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_gcan_d.clear() 
 
     
      CALL agct410_ui_browser_refresh()  
      #CALL agct410_ui_headershow()  
      #CALL agct410_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL agct410_browser_fill("")
         CALL agct410_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE agct410_cl
 
   #功能已完成,通報訊息中心
   CALL agct410_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="agct410.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agct410_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_gcan_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF agct410_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gcanunit,gcanseq,gcansite,gcan001,gcan002,gcan003,gcan004 ,t1.ooefl003 , 
             t2.gcao004 ,t3.gcafl003 FROM gcan_t",   
                     " INNER JOIN gcam_t ON gcament = " ||g_enterprise|| " AND gcamdocno = gcandocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=gcansite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN gcao_t t2 ON t2.gcaoent="||g_enterprise||" AND t2.gcao001=gcan001  ",
               " LEFT JOIN gcafl_t t3 ON t3.gcaflent="||g_enterprise||" AND t3.gcafl001=gcan002 AND t3.gcafl002='"||g_dlang||"' ",
 
                     " WHERE gcanent=? AND gcandocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gcan_t.gcanseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agct410_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR agct410_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_gcam_m.gcamdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_gcam_m.gcamdocno INTO g_gcan_d[l_ac].gcanunit,g_gcan_d[l_ac].gcanseq, 
          g_gcan_d[l_ac].gcansite,g_gcan_d[l_ac].gcan001,g_gcan_d[l_ac].gcan002,g_gcan_d[l_ac].gcan003, 
          g_gcan_d[l_ac].gcan004,g_gcan_d[l_ac].gcansite_desc,g_gcan_d[l_ac].gcan001_desc,g_gcan_d[l_ac].gcan002_desc  
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
     #  INITIALIZE g_ref_fields TO NULL
     #  LET g_ref_fields[1] = g_gcan_d[l_ac].gcan001
     #  CALL ap_ref_array2(g_ref_fields,"SELECT gcao002,gcao004 FROM gcao_t WHERE gcaoent='"||g_enterprise||"' AND gcao001=? ","") RETURNING g_rtn_fields
     #  LET g_gcan_d[l_ac].gcan002 = '', g_rtn_fields[1] , ''
     #  LET g_gcan_d[l_ac].gcan001_desc = '', g_rtn_fields[2] , ''
     #
     #  
     #  INITIALIZE g_ref_fields TO NULL
     #  LET g_ref_fields[1] = g_gcan_d[l_ac].gcan002
     #  CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     #  LET g_gcan_d[l_ac].gcan002_desc = '', g_rtn_fields[1] , ''
     #  DISPLAY BY NAME g_gcan_d[l_ac].gcan002,g_gcan_d[l_ac].gcan002_desc,g_gcan_d[l_ac].gcan001_desc
        
    
        IF g_gcam_m.gcam000 = '2' OR g_gcam_m.gcam000 = '3' THEN
          SELECT gcao009 INTO g_gcan_d[l_ac].gcan003 FROM gcao_t 
           WHERE gcaoent = g_enterprise AND gcao001 = g_gcan_d[l_ac].gcan001
          DISPLAY BY NAME g_gcan_d[l_ac].gcan003
        END IF
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
   
   CALL g_gcan_d.deleteElement(g_gcan_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE agct410_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_gcan_d.getLength()
      LET g_gcan_d_mask_o[l_ac].* =  g_gcan_d[l_ac].*
      CALL agct410_gcan_t_mask()
      LET g_gcan_d_mask_n[l_ac].* =  g_gcan_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="agct410.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agct410_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM gcan_t
       WHERE gcanent = g_enterprise AND
         gcandocno = ps_keys_bak[1] AND gcanseq = ps_keys_bak[2]
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
         CALL g_gcan_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agct410.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agct410_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO gcan_t
                  (gcanent,
                   gcandocno,
                   gcanseq
                   ,gcanunit,gcansite,gcan001,gcan002,gcan003,gcan004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_gcan_d[g_detail_idx].gcanunit,g_gcan_d[g_detail_idx].gcansite,g_gcan_d[g_detail_idx].gcan001, 
                       g_gcan_d[g_detail_idx].gcan002,g_gcan_d[g_detail_idx].gcan003,g_gcan_d[g_detail_idx].gcan004) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gcan_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_gcan_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="agct410.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agct410_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gcan_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL agct410_gcan_t_mask_restore('restore_mask_o')
               
      UPDATE gcan_t 
         SET (gcandocno,
              gcanseq
              ,gcanunit,gcansite,gcan001,gcan002,gcan003,gcan004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gcan_d[g_detail_idx].gcanunit,g_gcan_d[g_detail_idx].gcansite,g_gcan_d[g_detail_idx].gcan001, 
                  g_gcan_d[g_detail_idx].gcan002,g_gcan_d[g_detail_idx].gcan003,g_gcan_d[g_detail_idx].gcan004)  
 
         WHERE gcanent = g_enterprise AND gcandocno = ps_keys_bak[1] AND gcanseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcan_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcan_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agct410_gcan_t_mask_restore('restore_mask_n')
               
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
 
{<section id="agct410.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION agct410_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="agct410.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION agct410_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="agct410.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agct410_lock_b(ps_table,ps_page)
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
   #CALL agct410_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "gcan_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN agct410_bcl USING g_enterprise,
                                       g_gcam_m.gcamdocno,g_gcan_d[g_detail_idx].gcanseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agct410_bcl:",SQLERRMESSAGE 
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
 
{<section id="agct410.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agct410_unlock_b(ps_table,ps_page)
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
      CLOSE agct410_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="agct410.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION agct410_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("gcamdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gcamdocno",TRUE)
      CALL cl_set_comp_entry("gcamdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("gcamsite,gcamdocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agct410.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION agct410_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gcamdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("gcamsite,gcamdocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("gcamdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("gcamdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'gcamsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("gcamsite",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agct410.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agct410_set_entry_b(p_cmd)
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
 
{<section id="agct410.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agct410_set_no_entry_b(p_cmd)
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
 
{<section id="agct410.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION agct410_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct410.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION agct410_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
#160809-00027#1 -s by 08172
#   IF g_gcam_m.gcamstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
#      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
#   END IF
  
    CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", FALSE)
#160809-00027#1 -e by 08172


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct410.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION agct410_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct410.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION agct410_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct410.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agct410_default_search()
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
      LET ls_wc = ls_wc, " gcamdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "gcam_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gcan_t" 
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
   LET ls_wc = ''
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " gcam000 = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="agct410.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION agct410_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.chr5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gcam_m.gcamdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN agct410_cl USING g_enterprise,g_gcam_m.gcamdocno
   IF STATUS THEN
      CLOSE agct410_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agct410_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE agct410_master_referesh USING g_gcam_m.gcamdocno INTO g_gcam_m.gcam000,g_gcam_m.gcamsite, 
       g_gcam_m.gcamunit,g_gcam_m.gcamdocdt,g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam001,g_gcam_m.gcamstus, 
       g_gcam_m.gcamownid,g_gcam_m.gcamowndp,g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdt, 
       g_gcam_m.gcammodid,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfdt,g_gcam_m.gcamsite_desc, 
       g_gcam_m.gcam002_desc,g_gcam_m.gcam001_desc,g_gcam_m.gcamownid_desc,g_gcam_m.gcamowndp_desc,g_gcam_m.gcamcrtid_desc, 
       g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcammodid_desc,g_gcam_m.gcamcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT agct410_action_chk() THEN
      CLOSE agct410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gcam_m.gcam000,g_gcam_m.gcamsite,g_gcam_m.gcamsite_desc,g_gcam_m.gcamunit,g_gcam_m.gcamdocdt, 
       g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam002_desc,g_gcam_m.gcam001,g_gcam_m.gcam001_desc, 
       g_gcam_m.gcamstus,g_gcam_m.gcamownid,g_gcam_m.gcamownid_desc,g_gcam_m.gcamowndp,g_gcam_m.gcamowndp_desc, 
       g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtid_desc,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcamcrtdt, 
       g_gcam_m.gcammodid,g_gcam_m.gcammodid_desc,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfid_desc, 
       g_gcam_m.gcamcnfdt
 
   CASE g_gcam_m.gcamstus
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
         CASE g_gcam_m.gcamstus
            
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
       #160519-00032#1   add(S)
       CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
       CALL cl_set_act_visible("signing,withdraw",FALSE)
       #160519-00032#1   add(E)
       
       CASE g_gcam_m.gcamstus
         WHEN "Y"
            IF g_gcam_m.gcam000 = '2' OR g_gcam_m.gcam000 = '3' THEN
              HIDE OPTION "open"
              HIDE OPTION "invalid"
              HIDE OPTION "confirmed"    #160809-00027#1  by 08172
              CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
              RETURN 
            END IF
            IF g_gcam_m.gcam000 = '1' THEN
              HIDE OPTION "invalid"
              HIDE OPTION "confirmed"    #160809-00027#1  by 08172              
            END IF
          
         WHEN "X"
            HIDE OPTION "open"
            HIDE OPTION "confirmed"
            HIDE OPTION "invalid"        #160809-00027#1  by 08172   
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN 
         #160519-00032#1   add(S)
         WHEN "N"
            #HIDE OPTION "open"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",FALSE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         #160519-00032#1   add(E)
      END CASE
      #160809-00027#1 -s by 08172
       IF g_prog = 'agct410' THEN
          HIDE OPTION "unconfirmed"
          HIDE OPTION "invalid"
          HIDE OPTION "confirmed"
          CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
          RETURN
       END IF
       #160809-00027#1 -e by 08172
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT agct410_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE agct410_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT agct410_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE agct410_cl
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
      g_gcam_m.gcamstus = lc_state OR cl_null(lc_state) THEN
      CLOSE agct410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
 LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y'       
         CALL s_agct410_conf_chk(g_gcam_m.gcam000,g_gcam_m.gcamdocno) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_agct410_conf_upd(g_gcam_m.gcam000,g_gcam_m.gcamdocno) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcam_m.gcamdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                   CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
               RETURN            
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_gcam_m.gcamdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN            
         END IF         
      WHEN 'X'
         CALL s_agct410_void_chk(g_gcam_m.gcam000,g_gcam_m.gcamdocno) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN    #160809-00027#1  by 08172
               CALL s_transaction_begin()
               CALL s_agct410_void_upd(g_gcam_m.gcam000,g_gcam_m.gcamdocno) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcam_m.gcamdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_gcam_m.gcamdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN    
         END IF
         
       WHEN 'N'
          CALL s_agct410_unconf_chk(g_gcam_m.gcam000,g_gcam_m.gcamdocno) RETURNING l_success,g_errno
         IF l_success THEN
#            IF cl_ask_confirm('lib-016') THEN    #160809-00027#1  by 08172
            IF cl_ask_confirm('aim-00110') THEN   #160809-00027#1  by 08172
               CALL s_transaction_begin()
               CALL s_agct410_unconf_upd(g_gcam_m.gcam000,g_gcam_m.gcamdocno) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_gcam_m.gcamdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_gcam_m.gcamdocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#13 by 08209 add
            RETURN    
         END IF
         
   END CASE
   #end add-point
   
   LET g_gcam_m.gcammodid = g_user
   LET g_gcam_m.gcammoddt = cl_get_current()
   LET g_gcam_m.gcamstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE gcam_t 
      SET (gcamstus,gcammodid,gcammoddt) 
        = (g_gcam_m.gcamstus,g_gcam_m.gcammodid,g_gcam_m.gcammoddt)     
    WHERE gcament = g_enterprise AND gcamdocno = g_gcam_m.gcamdocno
 
    
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
      EXECUTE agct410_master_referesh USING g_gcam_m.gcamdocno INTO g_gcam_m.gcam000,g_gcam_m.gcamsite, 
          g_gcam_m.gcamunit,g_gcam_m.gcamdocdt,g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam001, 
          g_gcam_m.gcamstus,g_gcam_m.gcamownid,g_gcam_m.gcamowndp,g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtdp, 
          g_gcam_m.gcamcrtdt,g_gcam_m.gcammodid,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfdt, 
          g_gcam_m.gcamsite_desc,g_gcam_m.gcam002_desc,g_gcam_m.gcam001_desc,g_gcam_m.gcamownid_desc, 
          g_gcam_m.gcamowndp_desc,g_gcam_m.gcamcrtid_desc,g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcammodid_desc, 
          g_gcam_m.gcamcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_gcam_m.gcam000,g_gcam_m.gcamsite,g_gcam_m.gcamsite_desc,g_gcam_m.gcamunit,g_gcam_m.gcamdocdt, 
          g_gcam_m.gcamdocno,g_gcam_m.gcam002,g_gcam_m.gcam002_desc,g_gcam_m.gcam001,g_gcam_m.gcam001_desc, 
          g_gcam_m.gcamstus,g_gcam_m.gcamownid,g_gcam_m.gcamownid_desc,g_gcam_m.gcamowndp,g_gcam_m.gcamowndp_desc, 
          g_gcam_m.gcamcrtid,g_gcam_m.gcamcrtid_desc,g_gcam_m.gcamcrtdp,g_gcam_m.gcamcrtdp_desc,g_gcam_m.gcamcrtdt, 
          g_gcam_m.gcammodid,g_gcam_m.gcammodid_desc,g_gcam_m.gcammoddt,g_gcam_m.gcamcnfid,g_gcam_m.gcamcnfid_desc, 
          g_gcam_m.gcamcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE agct410_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agct410_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agct410.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION agct410_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_gcan_d.getLength() THEN
         LET g_detail_idx = g_gcan_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gcan_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gcan_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agct410.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION agct410_b_fill2(pi_idx)
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
   
   CALL agct410_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="agct410.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION agct410_fill_chk(ps_idx)
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
 
{<section id="agct410.status_show" >}
PRIVATE FUNCTION agct410_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agct410.mask_functions" >}
&include "erp/agc/agct410_mask.4gl"
 
{</section>}
 
{<section id="agct410.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION agct410_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL agct410_show()
   CALL agct410_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_gcam_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_gcan_d))
 
 
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
   #CALL agct410_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL agct410_ui_headershow()
   CALL agct410_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION agct410_draw_out()
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
   CALL agct410_ui_headershow()  
   CALL agct410_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="agct410.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agct410_set_pk_array()
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
   LET g_pk_array[1].values = g_gcam_m.gcamdocno
   LET g_pk_array[1].column = 'gcamdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agct410.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="agct410.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION agct410_msgcentre_notify(lc_state)
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
   CALL agct410_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gcam_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agct410.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION agct410_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#14 -s by 08172
   SELECT gcamstus  INTO g_gcam_m.gcamstus
     FROM gcam_t
    WHERE gcament = g_enterprise
      AND gcamdocno = g_gcam_m.gcamdocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_gcam_m.gcamstus
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
        LET g_errparam.extend = g_gcam_m.gcamdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL agct410_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#14 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agct410.other_function" readonly="Y" >}
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
PUBLIC FUNCTION agct410_gcamsite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcam_m.gcamsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcam_m.gcamsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcam_m.gcamsite_desc
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
PUBLIC FUNCTION agct410_gcam002_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcam_m.gcam002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2055' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcam_m.gcam002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcam_m.gcam002_desc
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
PUBLIC FUNCTION agct410_gcam001_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcam_m.gcam001
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2056' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcam_m.gcam001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcam_m.gcam001_desc
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
PUBLIC FUNCTION agct410_gcan001_ref()
DEFINE   l_str  STRING    

    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_gcan_d[l_ac].gcan001
    CALL ap_ref_array2(g_ref_fields,"SELECT gcao002,gcao004 FROM gcao_t WHERE gcaoent='"||g_enterprise||"' AND gcao001=? ","") RETURNING g_rtn_fields
    LET g_gcan_d[l_ac].gcan002 = '', g_rtn_fields[1] , ''
    LET l_str = '', g_rtn_fields[2] , ''
    LET g_gcan_d[l_ac].gcan001_desc = l_str

    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_gcan_d[l_ac].gcan002
    CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_gcan_d[l_ac].gcan002_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_gcan_d[l_ac].gcan002,g_gcan_d[l_ac].gcan002_desc,g_gcan_d[l_ac].gcan001_desc
    
    IF g_gcam_m.gcam000 = '2' THEN
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_gcan_d[l_ac].gcan001
       CALL ap_ref_array2(g_ref_fields,"SELECT gcao005 FROM gcao_t WHERE gcaoent='"||g_enterprise||"' AND gcao001=? ","") RETURNING g_rtn_fields
       LET g_gcan_d[l_ac].gcan004 = '', g_rtn_fields[1] , ''
       DISPLAY BY NAME g_gcan_d[l_ac].gcan004
    END IF
    IF g_gcam_m.gcam000 = '2' OR g_gcam_m.gcam000 = '3' THEN
      SELECT gcao009 INTO g_gcan_d[l_ac].gcan003 FROM gcao_t 
       WHERE gcaoent = g_enterprise AND gcao001 = g_gcan_d[l_ac].gcan001
      DISPLAY BY NAME g_gcan_d[l_ac].gcan003
    END IF
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
PUBLIC FUNCTION agct410_gcansite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_gcan_d[l_ac].gcansite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_gcan_d[l_ac].gcansite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_gcan_d[l_ac].gcansite_desc
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
PUBLIC FUNCTION agct410_gcansite_chk()
DEFINE l_n  LIKE type_t.num5
DEFINE l_gcao005 LIKE gcao_t.gcao005

    INITIALIZE g_chkparam.* TO NULL
    LET g_errshow = '1'
    LET g_chkparam.arg1 = g_gcan_d[l_ac].gcansite
    LET g_chkparam.arg2 = '2'
    LET g_chkparam.arg3 = g_gcam_m.gcamsite
    IF NOT cl_chk_exist("v_ooed004") THEN
      RETURN FALSE
    END IF
   
    IF g_gcam_m.gcam000 = '3' THEN
       SELECT COUNT(1) INTO l_n FROM gcao_t
        WHERE gcao026 = g_gcan_d[l_ac].gcansite
          AND gcaoent = g_enterprise      #160905-00007#3 add
       IF l_n = 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'agc-00071'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN FALSE
       END IF
    END IF
    
    IF NOT cl_null(g_gcan_d[l_ac].gcan001) THEN
     CASE g_gcam_m.gcam000
      WHEN '1'
 
          SELECT COUNT(1) INTO l_n FROM gcao_t
           WHERE gcao011 = g_gcan_d[l_ac].gcansite AND gcao001 = g_gcan_d[l_ac].gcan001 AND gcaoent = g_enterprise
          IF l_n = 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agc-00072'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          END IF
   {
      WHEN '2'
         SELECT gcao005 INTO l_gcao005 FROM gcao_t
          WHERE gcaoent = g_enterprise AND gcao001 = g_gcan_d[l_ac].gcan001 
         IF l_gcao005 = '1' THEN
           SELECT COUNT(1) INTO l_n FROM gcao_t
            WHERE gcao011 = g_gcan_d[l_ac].gcansite AND gcao001 = g_gcan_d[l_ac].gcan001 AND gcaoent = g_enterprise
           IF l_n = 0 THEN
              INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agc-00072'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

              RETURN FALSE
           END IF
         END IF
         IF l_gcao005 = '4' THEN
            SELECT COUNT(1) INTO l_n FROM gcao_t
            WHERE gcao014 = g_gcan_d[l_ac].gcansite AND gcao001 = g_gcan_d[l_ac].gcan001 AND gcaoent = g_enterprise
           IF l_n = 0 THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'agc-00074'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()

              RETURN FALSE
           END IF
         END IF
          IF l_gcao005 = '5' THEN
            SELECT COUNT(1) INTO l_n FROM gcao_t
            WHERE gcao017 = g_gcan_d[l_ac].gcansite AND gcao001 = g_gcan_d[l_ac].gcan001 AND gcaoent = g_enterprise
           IF l_n = 0 THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'agc-00075'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()

              RETURN FALSE
           END IF
         END IF
       }   
      WHEN '3' 

          SELECT COUNT(1) INTO l_n FROM gcao_t
           WHERE gcao026 = g_gcan_d[l_ac].gcansite AND gcao001 = g_gcan_d[l_ac].gcan001 AND gcaoent = g_enterprise
          IF l_n = 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agc-00073'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          END IF         
     END CASE
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
PUBLIC FUNCTION agct410_gcan001_chk()
DEFINE l_n LIKE type_t.num5
DEFINE l_gcao005 LIKE gcao_t.gcao005


    INITIALIZE g_chkparam.* TO NULL
    LET g_errshow = '1'
    LET g_chkparam.arg1 = g_gcan_d[l_ac].gcan001
    CASE g_gcam_m.gcam000
      WHEN '1'
        IF NOT cl_chk_exist("v_gcao001") THEN
           RETURN FALSE
        END IF
        IF NOT cl_null(g_gcan_d[l_ac].gcansite ) THEN
          SELECT COUNT(1) INTO l_n FROM gcao_t
           WHERE gcao011 = g_gcan_d[l_ac].gcansite AND gcao001 = g_gcan_d[l_ac].gcan001 AND gcaoent = g_enterprise
          IF l_n = 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agc-00072'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          END IF
        END IF
        
     WHEN '2'
         IF NOT cl_chk_exist("v_gcao001_1") THEN
           RETURN FALSE
         END IF
         {
         IF NOT cl_null(g_gcan_d[l_ac].gcansite ) THEN
            SELECT gcao005 INTO l_gcao005 FROM gcao_t
             WHERE gcaoent = g_enterprise AND gcao001 = g_gcan_d[l_ac].gcan001 
            IF l_gcao005 = '1' THEN
              SELECT COUNT(1) INTO l_n FROM gcao_t
               WHERE gcao011 = g_gcan_d[l_ac].gcansite AND gcao001 = g_gcan_d[l_ac].gcan001 AND gcaoent = g_enterprise
              IF l_n = 0 THEN
                 INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'agc-00072'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

                 RETURN FALSE
              END IF
            END IF
            IF l_gcao005 = '4' THEN
               SELECT COUNT(1) INTO l_n FROM gcao_t
               WHERE gcao014 = g_gcan_d[l_ac].gcansite AND gcao001 = g_gcan_d[l_ac].gcan001 AND gcaoent = g_enterprise
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agc-00074'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  RETURN FALSE
               END IF
            END IF 
             IF l_gcao005 = '5' THEN
                SELECT COUNT(1) INTO l_n FROM gcao_t
                WHERE gcao017 = g_gcan_d[l_ac].gcansite AND gcao001 = g_gcan_d[l_ac].gcan001 AND gcaoent = g_enterprise
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agc-00075'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  RETURN FALSE
               END IF
             END IF
         END IF
    }
          
      WHEN '3' 
         IF NOT cl_chk_exist("v_gcao001_2") THEN
            RETURN FALSE
         END IF
         IF NOT cl_null(g_gcan_d[l_ac].gcansite ) THEN
           SELECT COUNT(1) INTO l_n FROM gcao_t
            WHERE gcao026 = g_gcan_d[l_ac].gcansite AND gcao001 = g_gcan_d[l_ac].gcan001 AND gcaoent = g_enterprise
           IF l_n = 0 THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'agc-00073'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()

              RETURN FALSE
           END IF         
         END IF
    END CASE
    
    RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 批量產生單身
# Memo...........:
# Usage..........: CALL agct410_01()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/06/27 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION agct410_01()
DEFINE l_str         LIKE gcbi_t.gcbi001
DEFINE l_str1        STRING
DEFINE l_gcaf006     LIKE gcaf_t.gcaf006
DEFINE l_gcaf007     LIKE gcaf_t.gcaf007
DEFINE l_n           LIKE type_t.num5
DEFINE l_gcan002     LIKE gcan_t.gcan002
DEFINE l_gcan003     LIKE gcan_t.gcan003
DEFINE l_gcan004     LIKE gcan_t.gcan004
DEFINE l_gcanseq     LIKE gcan_t.gcanseq
DEFINE l_gcao002     LIKE gcao_t.gcao002

   #检查单头是否有资料
   IF cl_null(g_gcam_m.gcamdocno) THEN 
      RETURN 
   END IF 
   #只有未审核的单据才可以处理
   IF g_gcam_m.gcamstus <> 'N' THEN 
      RETURN 
   END IF 
   CALL agct410_01_input()
   IF cl_null(g_gcbi001) OR cl_null(g_gcbi002) THEN 
      RETURN 
   END IF 
   SELECT gcao002 INTO l_gcao002
     FROM gcao_t
    WHERE gcaoent = g_enterprise
      AND gcao001 = g_gcbi001
      
   #卡号总长度，固定码长度
   SELECT gcaf006,gcaf007
     INTO l_gcaf006,l_gcaf007
     FROM gcaf_t
    WHERE gcaf001 = l_gcao002
      AND gcafent = g_enterprise #160905-00007#3 add
   LET l_str = g_gcbi001
   CALL s_transaction_begin()
   WHILE TRUE
      LET l_n = 0
      SELECT COUNT(1) INTO l_n 
        FROM gcan_t 
       WHERE gcanent = g_enterprise
         AND gcandocno = g_gcam_m.gcamdocno
         AND gcan001 = l_str
      #不存在单身则新增，否则直接过
      IF l_n = 0 THEN 
      
         SELECT MAX(gcanseq)+1 INTO l_gcanseq
           FROM gcan_t
          WHERE gcanent = g_enterprise
            AND gcandocno = g_gcam_m.gcamdocno
         IF cl_null(l_gcanseq) THEN
            LET l_gcanseq = 1
         END IF
         LET l_gcan002 = l_gcao002
         IF g_gcam000 = '2' THEN
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_str
            CALL ap_ref_array2(g_ref_fields,"SELECT gcao005 FROM gcao_t WHERE gcaoent='"||g_enterprise||"' AND gcao001=? ","") RETURNING g_rtn_fields
            LET l_gcan004 = g_rtn_fields[1]
         END IF
         IF g_gcam000 = '2' OR g_gcam000 = '3' THEN
           SELECT gcao009 INTO l_gcan003
             FROM gcao_t 
            WHERE gcaoent = g_enterprise 
              AND gcao001 = l_str
         END IF
         INSERT INTO gcan_t
                     (gcanent,gcandocno,gcanseq,gcanunit,gcansite,gcan001,gcan002,gcan003,gcan004) 
               VALUES(g_enterprise,
                      g_gcam_m.gcamdocno,
                      l_gcanseq,g_gcam_m.gcamunit,g_gcam_m.gcamsite,l_str,
                      l_gcan002,l_gcan003,l_gcan004) 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gcan_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN 
         END IF
      END IF 
      IF l_str = g_gcbi002 THEN 
         EXIT WHILE 
      END IF 
      LET l_str1 = l_str[l_gcaf007+1,l_gcaf006] + 1
      LET l_str1 = l_str1.subString(1,l_str1.getIndexOf('.',1)-1)
      #流水码长度不够在前面补零
      WHILE TRUE 
         IF l_str1.getLength() <> l_gcaf006-l_gcaf007 THEN 
            LET l_str1 = "0",l_str1.trim()
         ELSE
            EXIT WHILE 
         END IF 
      END WHILE 
      LET l_str = l_str[1,l_gcaf007],l_str1
   END WHILE
   CALL s_transaction_end('Y','0')
   CALL agct410_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 輸入界面
# Memo...........:
# Usage..........: CALL agct410_01_input()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/06/27 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION agct410_01_input()
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE ls_path   STRING
   DEFINE l_n       LIKE type_t.num5
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_agct410_s01 WITH FORM cl_ap_formpath("agc","agct410_s01")
   #瀏覽頁簽資料初始化
#   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   CALL cl_set_act_visible("accept,cancel", FALSE)
   LET g_gcbi001 = ''
   LET g_gcbi002 = ''
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #輸入開始
      INPUT g_gcbi001,g_gcbi002 FROM gcbi001,gcbi002 ATTRIBUTE(WITHOUT DEFAULTS)
         
         AFTER FIELD gcbi001
            IF NOT cl_null(g_gcbi001) THEN 
               IF NOT agct410_gcbi001_chk(g_gcbi001) THEN 
                  LET g_gcbi001 = ''
                  DISPLAY BY NAME g_gcbi001
                  NEXT FIELD CURRENT 
               END IF 
               CALL agct410_gcbi001_gcbi002_chk(g_gcbi001,g_gcbi002)
               IF NOT cl_null(g_errno) THEN 
                  LET g_gcbi001 = ''
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT 
               END IF 
            END IF 
            
         AFTER FIELD gcbi002
            IF NOT cl_null(g_gcbi002) THEN 
               IF NOT agct410_gcbi001_chk(g_gcbi002) THEN 
                  LET g_gcbi002 = ''
                  DISPLAY BY NAME g_gcbi002
                  NEXT FIELD CURRENT 
               END IF 
               CALL agct410_gcbi001_gcbi002_chk(g_gcbi001,g_gcbi002)
               IF NOT cl_null(g_errno) THEN 
                  LET g_gcbi002 = ''
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT 
               END IF 
            END IF 
            
         ON ACTION controlp INFIELD gcbi001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 =  g_gcam_m.gcamsite 
            CASE g_gcam000 
               WHEN '1'
                  CALL q_gcao001_1()   
               WHEN '2'
                  CALL q_gcao001_8()
               WHEN '3'
                  CALL q_gcao001_3()   
            END CASE                 #呼叫開窗
            LET g_gcbi001 = g_qryparam.return1
            DISPLAY BY NAME g_gcbi001
            NEXT FIELD gcbi001                     #返回原欄位
            
         ON ACTION controlp INFIELD gcbi002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 =  g_site 
            CASE g_gcam000 
               WHEN '1'
                  CALL q_gcao001_1()   
               WHEN '2'
                  CALL q_gcao001_8()
               WHEN '3'
                  CALL q_gcao001_3()   
            END CASE                 #呼叫開窗
            LET g_gcbi002 = g_qryparam.return1
            DISPLAY BY NAME g_gcbi001
            NEXT FIELD gcbi002                     #返回原欄位
            
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
         
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   CALL cl_set_act_visible("accept,cancel", TRUE)
   #畫面關閉
   CLOSE WINDOW w_agct410_s01
END FUNCTION

################################################################################
# Descriptions...: 开始/结束券号检查
# Memo...........:
# Usage..........: 无
# Input parameter: p_card   券号
# Return code....: 无
# Date & Author..: 2015/06/27 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION agct410_gcbi001_chk(p_card)
DEFINE p_card      LIKE gcbi_t.gcbi001
DEFINE l_n LIKE type_t.num5
DEFINE l_gcao005 LIKE gcao_t.gcao005

    INITIALIZE g_chkparam.* TO NULL
    LET g_errshow = '1'
    LET g_chkparam.arg1 = p_card
    CASE g_gcam000
      WHEN '1'
         IF NOT cl_chk_exist("v_gcao001") THEN
            RETURN FALSE
         END IF
         SELECT COUNT(1) INTO l_n FROM gcao_t
          WHERE gcao011 = g_gcam_m.gcamsite AND gcao001 = p_card AND gcaoent = g_enterprise
         IF l_n = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agc-00072'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF
      WHEN '2'
         IF NOT cl_chk_exist("v_gcao001_1") THEN
           RETURN FALSE
         END IF
      WHEN '3' 
         IF NOT cl_chk_exist("v_gcao001_2") THEN
            RETURN FALSE
         END IF
         SELECT COUNT(1) INTO l_n FROM gcao_t
          WHERE gcao026 = g_gcam_m.gcamsite AND gcao001 = p_card AND gcaoent = g_enterprise
         IF l_n = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agc-00073'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF      
    END CASE
    RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 券號檢查
# Memo...........:
# Usage..........: 无
# Input parameter: p_card    开始券号
#                  p_card2   结束券号
# Return code....: 无
# Date & Author..: 2015/06/27 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION agct410_gcbi001_gcbi002_chk(p_card,p_card2)
   DEFINE p_card      LIKE gcbi_t.gcbi001
   DEFINE p_card2     LIKE gcbi_t.gcbi002
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_n1        LIKE type_t.num5
   DEFINE l_gcao002   LIKE gcao_t.gcao002
   DEFINE l_gcaf006   LIKE gcaf_t.gcaf006
   DEFINE l_gcaf007   LIKE gcaf_t.gcaf007

   LET g_errno = ''
   IF cl_null(p_card) OR cl_null(p_card2) THEN 
      RETURN 
   END IF 
   LET g_errno = ''
   SELECT gcao002 INTO l_gcao002
     FROM gcao_t
    WHERE gcaoent = g_enterprise
      AND gcao001 = p_card
      
   LET l_n = 0
   #检查券种是否一致
   SELECT COUNT(1) INTO l_n
     FROM gcao_t
    WHERE gcaoent = g_enterprise
      AND gcao001 = p_card
      AND gcao002 IN (SELECT gcao002 FROM gcao_t WHERE gcaoent = g_enterprise AND gcao001 = p_card2)
   IF l_n = 0 THEN 
      LET g_errno = 'agc-00097'
      RETURN
   END IF 
   #检查开始券号必须小于等于结束券号
   IF p_card > p_card2 THEN 
      LET g_errno = 'agc-00098'
      RETURN 
   END IF
   
   #券总位数，固定字符位数
   SELECT gcaf006,gcaf007 
     INTO l_gcaf006,l_gcaf007  
     FROM gcaf_t
    WHERE gcafent = g_enterprise
      AND gcaf001 = l_gcao002
   LET l_n1 = p_card2[l_gcaf007+1,l_gcaf006] - p_card[l_gcaf007+1,l_gcaf006] + 1
   LET l_n = 0   
   SELECT COUNT(1) INTO l_n
     FROM gcao_t
    WHERE gcaoent = g_enterprise
      AND gcao002 = l_gcao002
      AND gcao001 BETWEEN p_card AND p_card2
   IF l_n <> l_n1 THEN 
      LET g_errno = 'agc-00103'
      RETURN 
   END IF
   CASE g_gcam000
      WHEN '1'
         #检查开始和结束券号之间是否有状态不为1.发行的券号
         LET l_n = 0   
         SELECT COUNT(1) INTO l_n
           FROM gcao_t
          WHERE gcaoent = g_enterprise
            AND gcao002 = l_gcao002
            AND gcao001 BETWEEN p_card AND p_card2
            AND gcao005 = '1'
         IF l_n <> l_n1 THEN 
            LET g_errno = 'agc-00103'
            RETURN 
         END IF

      WHEN '2'
         #检查开始和结束券号之间是否有状态不为 1.发行 4.发售 5发售退回
         LET l_n = 0   
         SELECT COUNT(1) INTO l_n
           FROM gcao_t
          WHERE gcaoent = g_enterprise
            AND gcao002 = l_gcao002
            AND gcao001 BETWEEN p_card AND p_card2
            AND gcao005 IN('1','4','5')
         IF l_n <> l_n1 THEN 
            LET g_errno = 'agc-00110'
            RETURN 
         END IF
         
      WHEN '3'
         #检查开始和结束券号之间是否有状态不为 3.停用
         LET l_n = 0   
         SELECT COUNT(1) INTO l_n
           FROM gcao_t
          WHERE gcaoent = g_enterprise
            AND gcao002 = l_gcao002
            AND gcao001 BETWEEN p_card AND p_card2
            AND gcao005 = '3'
         IF l_n <> l_n1 THEN 
            LET g_errno = 'agc-00111'
            RETURN 
         END IF
   END CASE
END FUNCTION

 
{</section>}
 
