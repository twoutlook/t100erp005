#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt820.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0021(2016-10-21 14:09:55), PR版次:0021(2017-02-21 15:18:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000552
#+ Filename...: apmt820
#+ Description: 交易對象證照異動維護作業
#+ Creator....: 01996(2013-10-23 16:12:19)
#+ Modifier...: 02159 -SD/PR- 01996
 
{</section>}
 
{<section id="apmt820.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00005#37 2016/03/29 By 07900   重复错误讯息修改
#160812-00017#8  2016/08/16 By 06137   在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#28 2016/08/29 By 08742   删除修改未重新判断状态码
#160905-00007#11 2016/09/05 By 01727   调整系统中无ENT的SQL条件增加ent
#160908-00032#2  2016/09/14 By rainy   交易對象q_pmaa001()開窗改為q_pmaa001_4
#161006-00008#11 2016/10/21 By sakura  整批修改組織
#161104-00002#11 2016/11/10 By Rainy   將程式中 *寫法改掉
#170203-00024#4  2017/02/06 By Jessica 1.apmt820_send()沒有「確認前檢核段」，導致提交BPM成功而T100卻有報錯，兩方狀態不一致
#                                      2.「抽單、已拒絕」沒有修改、刪除
#                                      3.「作廢」傳入的狀態碼不為'N.未確認'
#160711-00040#24  2017/02/16 By xujing T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                      CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
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
PRIVATE type type_g_pmca_m        RECORD
       pmcadocno LIKE pmca_t.pmcadocno, 
   pmcadocdt LIKE pmca_t.pmcadocdt, 
   pmca001 LIKE pmca_t.pmca001, 
   pmca002 LIKE pmca_t.pmca002, 
   pmca002_desc LIKE type_t.chr80, 
   pmca003 LIKE pmca_t.pmca003, 
   pmca003_desc LIKE type_t.chr80, 
   pmcastus LIKE pmca_t.pmcastus, 
   pmcaownid LIKE pmca_t.pmcaownid, 
   pmcaownid_desc LIKE type_t.chr80, 
   pmcaowndp LIKE pmca_t.pmcaowndp, 
   pmcaowndp_desc LIKE type_t.chr80, 
   pmcacrtid LIKE pmca_t.pmcacrtid, 
   pmcacrtid_desc LIKE type_t.chr80, 
   pmcacrtdp LIKE pmca_t.pmcacrtdp, 
   pmcacrtdp_desc LIKE type_t.chr80, 
   pmcacrtdt LIKE pmca_t.pmcacrtdt, 
   pmcamodid LIKE pmca_t.pmcamodid, 
   pmcamodid_desc LIKE type_t.chr80, 
   pmcamoddt LIKE pmca_t.pmcamoddt, 
   pmcacnfid LIKE pmca_t.pmcacnfid, 
   pmcacnfid_desc LIKE type_t.chr80, 
   pmcacnfdt LIKE pmca_t.pmcacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pmcb_d        RECORD
       pmcbseq LIKE pmcb_t.pmcbseq, 
   pmcb001 LIKE pmcb_t.pmcb001, 
   pmcb001_desc LIKE type_t.chr500, 
   pmaastus LIKE type_t.chr500, 
   pmaa083 LIKE type_t.chr500, 
   pmcb002 LIKE pmcb_t.pmcb002, 
   pmcb002_desc LIKE type_t.chr500, 
   pmcb003 LIKE pmcb_t.pmcb003, 
   pmcb004 LIKE pmcb_t.pmcb004, 
   pmcb005 LIKE pmcb_t.pmcb005, 
   pmcb005_desc LIKE type_t.chr500, 
   pmcb006 LIKE pmcb_t.pmcb006, 
   pmcb006_desc LIKE type_t.chr500, 
   pmcb006_desc_desc LIKE type_t.chr500, 
   pmcb007 LIKE pmcb_t.pmcb007, 
   pmcb008 LIKE pmcb_t.pmcb008, 
   pmcb009 LIKE pmcb_t.pmcb009, 
   pmcb009_desc LIKE type_t.chr500, 
   pmcbacti LIKE pmcb_t.pmcbacti, 
   pmcb010 LIKE pmcb_t.pmcb010, 
   pmcb010_desc LIKE type_t.chr500, 
   pmcb011 LIKE pmcb_t.pmcb011
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_pmcadocno LIKE pmca_t.pmcadocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_cnt1                LIKE type_t.num5
DEFINE g_wc_table1           STRING 
DEFINE l_times          LIKE type_t.num5
DEFINE l_ins_times       LIKE type_t.num5
DEFINE g_flag          LIKE type_t.num5 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_pmca_m          type_g_pmca_m
DEFINE g_pmca_m_t        type_g_pmca_m
DEFINE g_pmca_m_o        type_g_pmca_m
DEFINE g_pmca_m_mask_o   type_g_pmca_m #轉換遮罩前資料
DEFINE g_pmca_m_mask_n   type_g_pmca_m #轉換遮罩後資料
 
   DEFINE g_pmcadocno_t LIKE pmca_t.pmcadocno
 
 
DEFINE g_pmcb_d          DYNAMIC ARRAY OF type_g_pmcb_d
DEFINE g_pmcb_d_t        type_g_pmcb_d
DEFINE g_pmcb_d_o        type_g_pmcb_d
DEFINE g_pmcb_d_mask_o   DYNAMIC ARRAY OF type_g_pmcb_d #轉換遮罩前資料
DEFINE g_pmcb_d_mask_n   DYNAMIC ARRAY OF type_g_pmcb_d #轉換遮罩後資料
 
 
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
 
{<section id="apmt820.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_para_data LIKE type_t.chr80 #150424-00018#2 15/05/28 by s983961 add
   DEFINE l_success LIKE type_t.num5    #161006-00008#11 by sakura add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
   LET g_flag = FALSE
   #150424-00018#2 2015/08/27 by s983961 add(s)   
 CALL cl_get_para(g_enterprise,g_site,'E-CIR-0016') RETURNING l_para_data
 IF l_para_data='N' THEN      
   INITIALIZE g_errparam TO NULL
   LET g_errparam.code = 'apm-00994'
   LET g_errparam.extend = ''
   LET g_errparam.popup = TRUE
   CALL cl_err()      
   CALL cl_ap_exitprogram("0")
 END IF  
   #150424-00018#2 2015/08/27 by s983961 add(e) 
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmcadocno,pmcadocdt,pmca001,pmca002,'',pmca003,'',pmcastus,pmcaownid, 
       '',pmcaowndp,'',pmcacrtid,'',pmcacrtdp,'',pmcacrtdt,pmcamodid,'',pmcamoddt,pmcacnfid,'',pmcacnfdt", 
        
                      " FROM pmca_t",
                      " WHERE pmcaent= ? AND pmcadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt820_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmcadocno,t0.pmcadocdt,t0.pmca001,t0.pmca002,t0.pmca003,t0.pmcastus, 
       t0.pmcaownid,t0.pmcaowndp,t0.pmcacrtid,t0.pmcacrtdp,t0.pmcacrtdt,t0.pmcamodid,t0.pmcamoddt,t0.pmcacnfid, 
       t0.pmcacnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 , 
       t8.ooag011",
               " FROM pmca_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmca002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmca003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.pmcaownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.pmcaowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.pmcacrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.pmcacrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.pmcamodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.pmcacnfid  ",
 
               " WHERE t0.pmcaent = " ||g_enterprise|| " AND t0.pmcadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmt820_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmt820 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmt820_init()   
 
      #進入選單 Menu (="N")
      CALL apmt820_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmt820
      
   END IF 
   
   CLOSE apmt820_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #161006-00008#11 by sakura add
   DROP TABLE apmt820_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmt820.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmt820_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#11 by sakura add
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
      CALL cl_set_combo_scc_part('pmcastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('pmca001','32') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #161006-00008#11 by sakura add
   CALL cl_set_combo_scc_part('pmcastus_1','13','N,Y,X')
   CALL cl_set_combo_scc_part('pmaastus','13','N,Y,X')
   CALL s_life_cycle_display('apmm801','pmaa083','2')
   #end add-point
   
   #初始化搜尋條件
   CALL apmt820_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apmt820.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apmt820_ui_dialog()
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
            CALL apmt820_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL cl_set_combo_scc_part('pmcastus_1','13','N,Y,X')
   CALL cl_set_combo_scc_part('pmaastus_1','13','N,Y,X')
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_pmca_m.* TO NULL
         CALL g_pmcb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmt820_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_pmcb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt820_idx_chk()
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
               CALL apmt820_idx_chk()
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
            CALL apmt820_browser_fill("")
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
               CALL apmt820_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apmt820_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apmt820_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apmt820_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apmt820_set_act_visible()   
            CALL apmt820_set_act_no_visible()
            IF NOT (g_pmca_m.pmcadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pmcaent = " ||g_enterprise|| " AND",
                                  " pmcadocno = '", g_pmca_m.pmcadocno, "' "
 
               #填到對應位置
               CALL apmt820_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "pmca_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmcb_t" 
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
               CALL apmt820_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "pmca_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmcb_t" 
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
                  CALL apmt820_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmt820_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apmt820_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt820_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apmt820_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt820_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apmt820_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt820_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apmt820_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt820_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apmt820_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt820_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_pmcb_d)
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
               CALL apmt820_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apmt820_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmt820_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmt820_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apm/apmt820_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apm/apmt820_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmt820_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION batch_insert
            LET g_action_choice="batch_insert"
            IF cl_auth_chk_act("batch_insert") THEN
               
               #add-point:ON ACTION batch_insert name="menu.batch_insert"
               CALL apmt820_01(g_pmca_m.pmca001,g_pmca_m.pmcadocno,'')
               LET g_action_choice = ''
               CALL apmt820_b_fill()   #151207-00021#5 151215 by sakura add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_pmca002
            LET g_action_choice="prog_pmca002"
            IF cl_auth_chk_act("prog_pmca002") THEN
               
               #add-point:ON ACTION prog_pmca002 name="menu.prog_pmca002"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_pmca_m.pmca002)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmt820_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmt820_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmt820_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_pmca_m.pmcadocdt)
 
 
 
         
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
 
{<section id="apmt820.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apmt820_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT pmcadocno ",
                      " FROM pmca_t ",
                      " ",
                      " LEFT JOIN pmcb_t ON pmcbent = pmcaent AND pmcadocno = pmcbdocno ", "  ",
                      #add-point:browser_fill段sql(pmcb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE pmcaent = " ||g_enterprise|| " AND pmcbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pmca_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pmcadocno ",
                      " FROM pmca_t ", 
                      "  ",
                      "  ",
                      " WHERE pmcaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pmca_t")
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
      INITIALIZE g_pmca_m.* TO NULL
      CALL g_pmcb_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pmcadocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmcastus,t0.pmcadocno ",
                  " FROM pmca_t t0",
                  "  ",
                  "  LEFT JOIN pmcb_t ON pmcbent = pmcaent AND pmcadocno = pmcbdocno ", "  ", 
                  #add-point:browser_fill段sql(pmcb_t1) name="browser_fill.join.pmcb_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.pmcaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("pmca_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmcastus,t0.pmcadocno ",
                  " FROM pmca_t t0",
                  "  ",
                  
                  " WHERE t0.pmcaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("pmca_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY pmcadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmca_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmcadocno
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
   
   IF cl_null(g_browser[g_cnt].b_pmcadocno) THEN
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
 
{<section id="apmt820.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apmt820_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pmca_m.pmcadocno = g_browser[g_current_idx].b_pmcadocno   
 
   EXECUTE apmt820_master_referesh USING g_pmca_m.pmcadocno INTO g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt, 
       g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca003,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaowndp, 
       g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtdp,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamoddt, 
       g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfdt,g_pmca_m.pmca002_desc,g_pmca_m.pmca003_desc,g_pmca_m.pmcaownid_desc, 
       g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcamodid_desc, 
       g_pmca_m.pmcacnfid_desc
   
   CALL apmt820_pmca_t_mask()
   CALL apmt820_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apmt820.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apmt820_ui_detailshow()
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
 
{<section id="apmt820.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmt820_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmcadocno = g_pmca_m.pmcadocno 
 
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
 
{<section id="apmt820.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmt820_construct()
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
   INITIALIZE g_pmca_m.* TO NULL
   CALL g_pmcb_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON pmcadocno,pmcadocdt,pmca001,pmca002,pmca003,pmcastus,pmcaownid,pmcaowndp, 
          pmcacrtid,pmcacrtdp,pmcacrtdt,pmcamodid,pmcamoddt,pmcacnfid,pmcacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmcacrtdt>>----
         AFTER FIELD pmcacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmcamoddt>>----
         AFTER FIELD pmcamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmcacnfdt>>----
         AFTER FIELD pmcacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmcapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.pmcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcadocno
            #add-point:ON ACTION controlp INFIELD pmcadocno name="construct.c.pmcadocno"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            CALL q_pmcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcadocno  #顯示到畫面上

            NEXT FIELD pmcadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcadocno
            #add-point:BEFORE FIELD pmcadocno name="construct.b.pmcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcadocno
            
            #add-point:AFTER FIELD pmcadocno name="construct.a.pmcadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcadocdt
            #add-point:BEFORE FIELD pmcadocdt name="construct.b.pmcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcadocdt
            
            #add-point:AFTER FIELD pmcadocdt name="construct.a.pmcadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcadocdt
            #add-point:ON ACTION controlp INFIELD pmcadocdt name="construct.c.pmcadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmca001
            #add-point:BEFORE FIELD pmca001 name="construct.b.pmca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmca001
            
            #add-point:AFTER FIELD pmca001 name="construct.a.pmca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmca001
            #add-point:ON ACTION controlp INFIELD pmca001 name="construct.c.pmca001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmca002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmca002
            #add-point:ON ACTION controlp INFIELD pmca002 name="construct.c.pmca002"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            #CALL q_ooag001_2()                           #呼叫開窗   #151228-00009#1 20151230 mark by beckxie
            CALL q_ooag001_4()                           #呼叫開窗    #151228-00009#1 20151230 add by beckxie
            DISPLAY g_qryparam.return1 TO pmca002  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD pmca002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmca002
            #add-point:BEFORE FIELD pmca002 name="construct.b.pmca002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmca002
            
            #add-point:AFTER FIELD pmca002 name="construct.a.pmca002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmca003
            #add-point:ON ACTION controlp INFIELD pmca003 name="construct.c.pmca003"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            #150518-00050#1 Modify By Ken 150520
            #CALL q_ooea001_3()                           #呼叫開窗
            CALL q_ooeg001()
            #150518-00050#1 Modify By Ken 150520
            DISPLAY g_qryparam.return1 TO pmca003  #顯示到畫面上

            NEXT FIELD pmca003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmca003
            #add-point:BEFORE FIELD pmca003 name="construct.b.pmca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmca003
            
            #add-point:AFTER FIELD pmca003 name="construct.a.pmca003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcastus
            #add-point:BEFORE FIELD pmcastus name="construct.b.pmcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcastus
            
            #add-point:AFTER FIELD pmcastus name="construct.a.pmcastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcastus
            #add-point:ON ACTION controlp INFIELD pmcastus name="construct.c.pmcastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmcaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcaownid
            #add-point:ON ACTION controlp INFIELD pmcaownid name="construct.c.pmcaownid"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcaownid  #顯示到畫面上

            NEXT FIELD pmcaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcaownid
            #add-point:BEFORE FIELD pmcaownid name="construct.b.pmcaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcaownid
            
            #add-point:AFTER FIELD pmcaownid name="construct.a.pmcaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcaowndp
            #add-point:ON ACTION controlp INFIELD pmcaowndp name="construct.c.pmcaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcaowndp  #顯示到畫面上

            NEXT FIELD pmcaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcaowndp
            #add-point:BEFORE FIELD pmcaowndp name="construct.b.pmcaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcaowndp
            
            #add-point:AFTER FIELD pmcaowndp name="construct.a.pmcaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcacrtid
            #add-point:ON ACTION controlp INFIELD pmcacrtid name="construct.c.pmcacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcacrtid  #顯示到畫面上

            NEXT FIELD pmcacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcacrtid
            #add-point:BEFORE FIELD pmcacrtid name="construct.b.pmcacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcacrtid
            
            #add-point:AFTER FIELD pmcacrtid name="construct.a.pmcacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcacrtdp
            #add-point:ON ACTION controlp INFIELD pmcacrtdp name="construct.c.pmcacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcacrtdp  #顯示到畫面上

            NEXT FIELD pmcacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcacrtdp
            #add-point:BEFORE FIELD pmcacrtdp name="construct.b.pmcacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcacrtdp
            
            #add-point:AFTER FIELD pmcacrtdp name="construct.a.pmcacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcacrtdt
            #add-point:BEFORE FIELD pmcacrtdt name="construct.b.pmcacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmcamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcamodid
            #add-point:ON ACTION controlp INFIELD pmcamodid name="construct.c.pmcamodid"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcamodid  #顯示到畫面上

            NEXT FIELD pmcamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcamodid
            #add-point:BEFORE FIELD pmcamodid name="construct.b.pmcamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcamodid
            
            #add-point:AFTER FIELD pmcamodid name="construct.a.pmcamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcamoddt
            #add-point:BEFORE FIELD pmcamoddt name="construct.b.pmcamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmcacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcacnfid
            #add-point:ON ACTION controlp INFIELD pmcacnfid name="construct.c.pmcacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcacnfid  #顯示到畫面上

            NEXT FIELD pmcacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcacnfid
            #add-point:BEFORE FIELD pmcacnfid name="construct.b.pmcacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcacnfid
            
            #add-point:AFTER FIELD pmcacnfid name="construct.a.pmcacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcacnfdt
            #add-point:BEFORE FIELD pmcacnfdt name="construct.b.pmcacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pmcbseq,pmcb001,pmcb002,pmcb003,pmcb004,pmcb005,pmcb006,pmcb007,pmcb008, 
          pmcb009,pmcbacti,pmcb010,pmcb011
           FROM s_detail1[1].pmcbseq,s_detail1[1].pmcb001,s_detail1[1].pmcb002,s_detail1[1].pmcb003, 
               s_detail1[1].pmcb004,s_detail1[1].pmcb005,s_detail1[1].pmcb006,s_detail1[1].pmcb007,s_detail1[1].pmcb008, 
               s_detail1[1].pmcb009,s_detail1[1].pmcbacti,s_detail1[1].pmcb010,s_detail1[1].pmcb011
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcbseq
            #add-point:BEFORE FIELD pmcbseq name="construct.b.page1.pmcbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcbseq
            
            #add-point:AFTER FIELD pmcbseq name="construct.a.page1.pmcbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcbseq
            #add-point:ON ACTION controlp INFIELD pmcbseq name="construct.c.page1.pmcbseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmcb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb001
            #add-point:ON ACTION controlp INFIELD pmcb001 name="construct.c.page1.pmcb001"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " pmaa002 IN ('1','3')"
            #CALL q_pmaa001()                         #呼叫開窗  #160908-00032#2 mark by rainy 
            CALL q_pmaa001_4()                        #呼叫開窗    #160908-00032#2 by rainy 開窗改為 q_pmaa001_4()
            DISPLAY g_qryparam.return1 TO pmcb001  #顯示到畫面上
            INITIALIZE g_qryparam.where TO NULL
            NEXT FIELD pmcb001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb001
            #add-point:BEFORE FIELD pmcb001 name="construct.b.page1.pmcb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb001
            
            #add-point:AFTER FIELD pmcb001 name="construct.a.page1.pmcb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb002
            #add-point:ON ACTION controlp INFIELD pmcb002 name="construct.c.page1.pmcb002"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2036"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcb002  #顯示到畫面上

            NEXT FIELD pmcb002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb002
            #add-point:BEFORE FIELD pmcb002 name="construct.b.page1.pmcb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb002
            
            #add-point:AFTER FIELD pmcb002 name="construct.a.page1.pmcb002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb003
            #add-point:BEFORE FIELD pmcb003 name="construct.b.page1.pmcb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb003
            
            #add-point:AFTER FIELD pmcb003 name="construct.a.page1.pmcb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb003
            #add-point:ON ACTION controlp INFIELD pmcb003 name="construct.c.page1.pmcb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb004
            #add-point:BEFORE FIELD pmcb004 name="construct.b.page1.pmcb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb004
            
            #add-point:AFTER FIELD pmcb004 name="construct.a.page1.pmcb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb004
            #add-point:ON ACTION controlp INFIELD pmcb004 name="construct.c.page1.pmcb004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmcb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb005
            #add-point:ON ACTION controlp INFIELD pmcb005 name="construct.c.page1.pmcb005"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcb005  #顯示到畫面上

            NEXT FIELD pmcb005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb005
            #add-point:BEFORE FIELD pmcb005 name="construct.b.page1.pmcb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb005
            
            #add-point:AFTER FIELD pmcb005 name="construct.a.page1.pmcb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb006
            #add-point:ON ACTION controlp INFIELD pmcb006 name="construct.c.page1.pmcb006"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcb006  #顯示到畫面上

            NEXT FIELD pmcb006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb006
            #add-point:BEFORE FIELD pmcb006 name="construct.b.page1.pmcb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb006
            
            #add-point:AFTER FIELD pmcb006 name="construct.a.page1.pmcb006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb007
            #add-point:BEFORE FIELD pmcb007 name="construct.b.page1.pmcb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb007
            
            #add-point:AFTER FIELD pmcb007 name="construct.a.page1.pmcb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb007
            #add-point:ON ACTION controlp INFIELD pmcb007 name="construct.c.page1.pmcb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb008
            #add-point:BEFORE FIELD pmcb008 name="construct.b.page1.pmcb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb008
            
            #add-point:AFTER FIELD pmcb008 name="construct.a.page1.pmcb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb008
            #add-point:ON ACTION controlp INFIELD pmcb008 name="construct.c.page1.pmcb008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmcb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb009
            #add-point:ON ACTION controlp INFIELD pmcb009 name="construct.c.page1.pmcb009"
            #此段落由子樣板a08產生
            #開窗c段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE
            #150518-00050#1 Modify By Ken 150520
            #CALL q_ooea001()                           #呼叫開窗
            #CALL q_ooef001()   #161006-00008#11 by sakura mark
            #150518-00050#1 Modify By Ken 150520
            #161006-00008#11 by sakura add(S)
            IF s_aooi500_setpoint(g_prog,'pmcb009') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmcb009',g_site,'c')
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001()  
            END IF
            #161006-00008#11 by sakura add(E)
            DISPLAY g_qryparam.return1 TO pmcb009  #顯示到畫面上

            NEXT FIELD pmcb009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb009
            #add-point:BEFORE FIELD pmcb009 name="construct.b.page1.pmcb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb009
            
            #add-point:AFTER FIELD pmcb009 name="construct.a.page1.pmcb009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcbacti
            #add-point:BEFORE FIELD pmcbacti name="construct.b.page1.pmcbacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcbacti
            
            #add-point:AFTER FIELD pmcbacti name="construct.a.page1.pmcbacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcbacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcbacti
            #add-point:ON ACTION controlp INFIELD pmcbacti name="construct.c.page1.pmcbacti"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmcb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb010
            #add-point:ON ACTION controlp INFIELD pmcb010 name="construct.c.page1.pmcb010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2036"   #151207-00021#5 151215 by sakura add
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmcb010  #顯示到畫面上
            NEXT FIELD pmcb010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb010
            #add-point:BEFORE FIELD pmcb010 name="construct.b.page1.pmcb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb010
            
            #add-point:AFTER FIELD pmcb010 name="construct.a.page1.pmcb010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb011
            #add-point:BEFORE FIELD pmcb011 name="construct.b.page1.pmcb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb011
            
            #add-point:AFTER FIELD pmcb011 name="construct.a.page1.pmcb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmcb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb011
            #add-point:ON ACTION controlp INFIELD pmcb011 name="construct.c.page1.pmcb011"
            
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
                  WHEN la_wc[li_idx].tableid = "pmca_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pmcb_t" 
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
 
{<section id="apmt820.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmt820_query()
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
   CALL g_pmcb_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apmt820_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmt820_browser_fill("")
      CALL apmt820_fetch("")
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
   CALL apmt820_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apmt820_fetch("F") 
      #顯示單身筆數
      CALL apmt820_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmt820.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmt820_fetch(p_flag)
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
   
   LET g_pmca_m.pmcadocno = g_browser[g_current_idx].b_pmcadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apmt820_master_referesh USING g_pmca_m.pmcadocno INTO g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt, 
       g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca003,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaowndp, 
       g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtdp,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamoddt, 
       g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfdt,g_pmca_m.pmca002_desc,g_pmca_m.pmca003_desc,g_pmca_m.pmcaownid_desc, 
       g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcamodid_desc, 
       g_pmca_m.pmcacnfid_desc
   
   #遮罩相關處理
   LET g_pmca_m_mask_o.* =  g_pmca_m.*
   CALL apmt820_pmca_t_mask()
   LET g_pmca_m_mask_n.* =  g_pmca_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt820_set_act_visible()   
   CALL apmt820_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #170203-00024#4-S  
   #IF g_pmca_m.pmcastus = 'N' THEN
   #   CALL cl_set_act_visible("modify,delete",TRUE)
   #ELSE
   #   CALL cl_set_act_visible("modify,delete",FALSE)
   #END IF
   IF g_pmca_m.pmcastus NOT MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #170203-00024#4-E
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_pmca_m_t.* = g_pmca_m.*
   LET g_pmca_m_o.* = g_pmca_m.*
   
   LET g_data_owner = g_pmca_m.pmcaownid      
   LET g_data_dept  = g_pmca_m.pmcaowndp
   
   #重新顯示   
   CALL apmt820_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt820.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmt820_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   #ken---add---s 需求單號：141125-00002 項次：4
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004 
   #ken---add---e
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pmcb_d.clear()   
 
 
   INITIALIZE g_pmca_m.* TO NULL             #DEFAULT 設定
   
   LET g_pmcadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmca_m.pmcaownid = g_user
      LET g_pmca_m.pmcaowndp = g_dept
      LET g_pmca_m.pmcacrtid = g_user
      LET g_pmca_m.pmcacrtdp = g_dept 
      LET g_pmca_m.pmcacrtdt = cl_get_current()
      LET g_pmca_m.pmcamodid = g_user
      LET g_pmca_m.pmcamoddt = cl_get_current()
      LET g_pmca_m.pmcastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmca_m.pmca001 = "I"
      LET g_pmca_m.pmcastus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_pmca_m.pmcadocdt = g_today
      LET g_pmca_m.pmca002 = g_user
      LET g_pmca_m.pmca001 = 'I'
      SELECT ooag003 INTO g_pmca_m.pmca003 FROM ooag_t
       WHERE ooag001 = g_pmca_m.pmca002 AND ooagent = g_enterprise
      DISPLAY BY NAME g_pmca_m.pmca003
      
      #ken---add---s 需求單號：141125-00002 項次：4
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_site,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_pmca_m.pmcadocno = l_doctype      
      #ken---add---e
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pmca_m.pmca002
      CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM ooag_t LEFT OUTER JOIN oofa_t ON oofa001 = ooag002 AND oofaent = '"||g_enterprise||"' WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_pmca_m.pmca002_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_pmca_m.pmca002_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pmca_m.pmca003
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooefl001 =? AND ooeflent = '"||g_enterprise||"' AND ooefl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_pmca_m.pmca003_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_pmca_m.pmca003_desc
      LET g_pmca_m_t.* = g_pmca_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_pmca_m_t.* = g_pmca_m.*
      LET g_pmca_m_o.* = g_pmca_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmca_m.pmcastus 
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
 
 
 
    
      CALL apmt820_input("a")
      
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
         INITIALIZE g_pmca_m.* TO NULL
         INITIALIZE g_pmcb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apmt820_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_pmcb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt820_set_act_visible()   
   CALL apmt820_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmcadocno_t = g_pmca_m.pmcadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmcaent = " ||g_enterprise|| " AND",
                      " pmcadocno = '", g_pmca_m.pmcadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt820_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apmt820_cl
   
   CALL apmt820_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmt820_master_referesh USING g_pmca_m.pmcadocno INTO g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt, 
       g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca003,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaowndp, 
       g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtdp,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamoddt, 
       g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfdt,g_pmca_m.pmca002_desc,g_pmca_m.pmca003_desc,g_pmca_m.pmcaownid_desc, 
       g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcamodid_desc, 
       g_pmca_m.pmcacnfid_desc
   
   
   #遮罩相關處理
   LET g_pmca_m_mask_o.* =  g_pmca_m.*
   CALL apmt820_pmca_t_mask()
   LET g_pmca_m_mask_n.* =  g_pmca_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt,g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca002_desc, 
       g_pmca_m.pmca003,g_pmca_m.pmca003_desc,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaownid_desc, 
       g_pmca_m.pmcaowndp,g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp, 
       g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamodid_desc,g_pmca_m.pmcamoddt, 
       g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfid_desc,g_pmca_m.pmcacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_pmca_m.pmcaownid      
   LET g_data_dept  = g_pmca_m.pmcaowndp
   
   #功能已完成,通報訊息中心
   CALL apmt820_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmt820_modify()
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
   LET g_pmca_m_t.* = g_pmca_m.*
   LET g_pmca_m_o.* = g_pmca_m.*
   
   IF g_pmca_m.pmcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_pmcadocno_t = g_pmca_m.pmcadocno
 
   CALL s_transaction_begin()
   
   OPEN apmt820_cl USING g_enterprise,g_pmca_m.pmcadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt820_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt820_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt820_master_referesh USING g_pmca_m.pmcadocno INTO g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt, 
       g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca003,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaowndp, 
       g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtdp,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamoddt, 
       g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfdt,g_pmca_m.pmca002_desc,g_pmca_m.pmca003_desc,g_pmca_m.pmcaownid_desc, 
       g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcamodid_desc, 
       g_pmca_m.pmcacnfid_desc
   
   #檢查是否允許此動作
   IF NOT apmt820_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmca_m_mask_o.* =  g_pmca_m.*
   CALL apmt820_pmca_t_mask()
   LET g_pmca_m_mask_n.* =  g_pmca_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL apmt820_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_pmcadocno_t = g_pmca_m.pmcadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_pmca_m.pmcamodid = g_user 
LET g_pmca_m.pmcamoddt = cl_get_current()
LET g_pmca_m.pmcamodid_desc = cl_get_username(g_pmca_m.pmcamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #170203-00024#4-S  
      IF g_pmca_m.pmcastus MATCHES '[DR]' THEN 
         LET g_pmca_m.pmcastus = "N"
      END IF
      #170203-00024#4-E  
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apmt820_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
 
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE pmca_t SET (pmcamodid,pmcamoddt) = (g_pmca_m.pmcamodid,g_pmca_m.pmcamoddt)
          WHERE pmcaent = g_enterprise AND pmcadocno = g_pmcadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_pmca_m.* = g_pmca_m_t.*
            CALL apmt820_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_pmca_m.pmcadocno != g_pmca_m_t.pmcadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE pmcb_t SET pmcbdocno = g_pmca_m.pmcadocno
 
          WHERE pmcbent = g_enterprise AND pmcbdocno = g_pmca_m_t.pmcadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmcb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmcb_t:",SQLERRMESSAGE 
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
   CALL apmt820_set_act_visible()   
   CALL apmt820_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmcaent = " ||g_enterprise|| " AND",
                      " pmcadocno = '", g_pmca_m.pmcadocno, "' "
 
   #填到對應位置
   CALL apmt820_browser_fill("")
 
   CLOSE apmt820_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt820_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apmt820.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmt820_input(p_cmd)
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
   DEFINE l_arg1           LIKE ooef_t.ooef004
   DEFINE l_success        LIKE type_t.chr1
   DEFINE l_rtax002        LIKE rtax_t.rtax002
   DEFINE l_imaa009        LIKE imaa_t.imaa009
   DEFINE l_state          LIKE type_t.chr1
   DEFINE l_lines          LIKE type_t.num5
   DEFINE l_bottom         STRING
   DEFINE l_sql1            STRING  #160711-00040#24 add
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
   DISPLAY BY NAME g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt,g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca002_desc, 
       g_pmca_m.pmca003,g_pmca_m.pmca003_desc,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaownid_desc, 
       g_pmca_m.pmcaowndp,g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp, 
       g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamodid_desc,g_pmca_m.pmcamoddt, 
       g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfid_desc,g_pmca_m.pmcacnfdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT pmcbseq,pmcb001,pmcb002,pmcb003,pmcb004,pmcb005,pmcb006,pmcb007,pmcb008, 
       pmcb009,pmcbacti,pmcb010,pmcb011 FROM pmcb_t WHERE pmcbent=? AND pmcbdocno=? AND pmcbseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt820_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apmt820_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apmt820_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt,g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca003, 
       g_pmca_m.pmcastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apmt820.input.head" >}
      #單頭段
      INPUT BY NAME g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt,g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca003, 
          g_pmca_m.pmcastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apmt820_cl USING g_enterprise,g_pmca_m.pmcadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt820_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt820_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apmt820_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL apmt820_set_entry(p_cmd)

            CALL apmt820_set_no_entry(p_cmd)
 
            #end add-point
            CALL apmt820_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcadocno
            #add-point:BEFORE FIELD pmcadocno name="input.b.pmcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcadocno
            
            #add-point:AFTER FIELD pmcadocno name="input.a.pmcadocno"
            #此段落由子樣板a05產生
            #150504-00036#1 Modify By Ken 150504
            IF  NOT cl_null(g_pmca_m.pmcadocno) THEN  
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_pmca_m.pmcadocno != g_pmcadocno_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmca_t WHERE "||"pmcaent = '" ||g_enterprise|| "' AND "||"pmcadocno = '"||g_pmca_m.pmcadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(g_site,'',g_pmca_m.pmcadocno,g_prog) THEN
                     LET g_pmca_m.pmcadocno = g_pmcadocno_t
                     NEXT FIELD CURRENT
                  END IF 
               END IF                  
            END IF
            
            #IF  NOT cl_null(g_pmca_m.pmcadocno) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_pmca_m.pmcadocno != g_pmcadocno_t ))) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmca_t WHERE "||"pmcadocno = '"||g_pmca_m.pmcadocno ||"'",'std-00004',1) THEN 
            #         LET g_pmca_m.pmcadocno = g_pmcadocno_t
            #         DISPLAY BY NAME g_pmca_m.pmcadocno
            #         NEXT FIELD CURRENT
            #      END IF
            #      
            #      LET l_n = 0
            #      SELECT COUNT(*) INTO l_n FROM ooba_t,ooef_t,oobl_t
            #       WHERE ooba001 = ooef004 AND ooef001 = g_site
            #         AND oobaent = ooefent AND oobaent = g_enterprise
            #         AND ooba002 = g_pmca_m.pmcadocno AND ooblent = g_enterprise
            #         AND oobl001 = ooba001 AND oobl002 = ooba002
            #         AND oobl003 = 'apmt820'
            #      IF l_n = 0 THEN
            #         LET g_pmca_m.pmcadocno = g_pmcadocno_t
            #         DISPLAY BY NAME g_pmca_m.pmcadocno
            #         INITIALIZE g_errparam TO NULL
            #         LET g_errparam.code = 'apm-00001'
            #         LET g_errparam.extend = g_pmca_m.pmcadocno
            #         LET g_errparam.popup = TRUE
            #         CALL cl_err()
            #
            #         NEXT FIELD CURRENT
            #      END IF   
            #
            #      LET l_n = 0
            #      SELECT COUNT(*) INTO l_n FROM ooba_t,ooef_t,oobl_t
            #       WHERE ooba001 = ooef004 AND ooef001 = g_site
            #         AND oobaent = ooefent AND oobaent = g_enterprise
            #         AND ooba002 = g_pmca_m.pmcadocno AND ooblent = g_enterprise
            #         AND oobl001 = ooba001 AND oobl002 = ooba002
            #         AND oobl003 = 'apmt820'
            #         AND oobastus= 'Y'
            #      IF l_n = 0 THEN
            #         LET g_pmca_m.pmcadocno = g_pmcadocno_t
            #         DISPLAY BY NAME g_pmca_m.pmcadocno
            #         INITIALIZE g_errparam TO NULL
            #         LET g_errparam.code = 'sub-00114'
            #         LET g_errparam.extend = g_pmca_m.pmcadocno
            #         LET g_errparam.popup = TRUE
            #         CALL cl_err()
            #
            #         NEXT FIELD CURRENT
            #      END IF
            #      
            #   END IF
            #END IF
            #150504-00036#1 Modify


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcadocno
            #add-point:ON CHANGE pmcadocno name="input.g.pmcadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcadocdt
            #add-point:BEFORE FIELD pmcadocdt name="input.b.pmcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcadocdt
            
            #add-point:AFTER FIELD pmcadocdt name="input.a.pmcadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcadocdt
            #add-point:ON CHANGE pmcadocdt name="input.g.pmcadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmca001
            #add-point:BEFORE FIELD pmca001 name="input.b.pmca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmca001
            
            #add-point:AFTER FIELD pmca001 name="input.a.pmca001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmca001
            #add-point:ON CHANGE pmca001 name="input.g.pmca001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmca002
            
            #add-point:AFTER FIELD pmca002 name="input.a.pmca002"
            #20160907先Mark(S)
            #160822-00022#4 Add By Ken 160822(S)
            #IF NOT cl_null(g_pmca_m.pmca002) THEN       #紅色即為助記碼會增加的程式段落  (有順序問題，要最先做)
            #   INITIALIZE g_rtn_fields TO NULL
            #           #助記碼搜尋    目標table     傳入資料          傳入where condiction      搜尋欄位                                    回傳值       是否發生問題
            #   CALL cl_mnemonic('ooag_t',g_pmca_m.pmca002,"",'ooag001,ooag011,ooag014') RETURNING g_rtn_fields, g_chk
            #   IF g_chk THEN
            #      LET g_pmca_m.pmca002 = g_rtn_fields[1]
            #   ELSE
            #      LET g_pmca_m.pmca002 = ""
            #   END IF
            #   DISPLAY BY NAME g_pmca_m.pmca002   #顯示回需要資料的欄位
            #END IF            
            #160822-00022#4 Add By Ken 160822(E)
            #20160907先Mark(E)
            
            IF NOT cl_null(g_pmca_m.pmca002) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_pmca_m.pmca002
               IF l_n = 0 THEN
                  LET g_pmca_m.pmca002 = g_pmca_m_t.pmca002
                  LET g_pmca_m.pmca002_desc = g_pmca_m_t.pmca002_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00069'
                  LET g_errparam.extend = g_pmca_m.pmca002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooagstus= 'Y'
                  AND ooag001 = g_pmca_m.pmca002
               IF l_n = 0 THEN
                  LET g_pmca_m.pmca002 = g_pmca_m_t.pmca002
                  LET g_pmca_m.pmca002_desc = g_pmca_m_t.pmca002_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-01302'  #aim-00070   #160318-00005#37  By 07900--mod
                  LET g_errparam.extend = g_pmca_m.pmca002
                   #160318-00005#317  By 07900 --add-str
                   LET g_errparam.replace[1] ='aooi130'
                   LET g_errparam.replace[2] = cl_get_progname("aooi130",g_lang,"2")
                   LET g_errparam.exeprog ='aooi130'
                   #160318-00005#37  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               
               SELECT ooag003 INTO g_pmca_m.pmca003 FROM ooag_t
                WHERE ooag001 = g_pmca_m.pmca002 AND ooagent = g_enterprise
               IF cl_null(g_pmca_m.pmca003) THEN
                  LET g_pmca_m.pmca002 = g_pmca_m_t.pmca002
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00170'
                  LET g_errparam.extend = g_pmca_m.pmca003
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               DISPLAY BY NAME g_pmca_m.pmca003
            END IF
           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmca_m.pmca002
            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM ooag_t LEFT OUTER JOIN oofa_t ON oofa001 = ooag002 AND oofaent = '"||g_enterprise||"' WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmca_m.pmca002_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_pmca_m.pmca002_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmca_m.pmca003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooefl001 =? AND ooeflent = '"||g_enterprise||"' AND ooefl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmca_m.pmca003_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_pmca_m.pmca003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmca002
            #add-point:BEFORE FIELD pmca002 name="input.b.pmca002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmca002
            #add-point:ON CHANGE pmca002 name="input.g.pmca002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmca003
            
            #add-point:AFTER FIELD pmca003 name="input.a.pmca003"
            
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmca_m.pmca003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag003 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmca_m.pmca003_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_pmca_m.pmca003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmca003
            #add-point:BEFORE FIELD pmca003 name="input.b.pmca003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmca003
            #add-point:ON CHANGE pmca003 name="input.g.pmca003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcastus
            #add-point:BEFORE FIELD pmcastus name="input.b.pmcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcastus
            
            #add-point:AFTER FIELD pmcastus name="input.a.pmcastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcastus
            #add-point:ON CHANGE pmcastus name="input.g.pmcastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcadocno
            #add-point:ON ACTION controlp INFIELD pmcadocno name="input.c.pmcadocno"
#此段落由子樣板a07產生            
            #開窗i段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmca_m.pmcadocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_arg1 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_arg1 #參照表編號
            #150504-00036#1 Modify By Ken 150504
            LET g_qryparam.arg2 = g_prog
            #LET g_qryparam.arg2 = "apmt820" #單據性質
            #150504-00036#1 Modify
            #160711-00040#24 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#24 add(e)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_pmca_m.pmcadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmca_m.pmcadocno TO pmcadocno              #顯示到畫面上

            NEXT FIELD pmcadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcadocdt
            #add-point:ON ACTION controlp INFIELD pmcadocdt name="input.c.pmcadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmca001
            #add-point:ON ACTION controlp INFIELD pmca001 name="input.c.pmca001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmca002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmca002
            #add-point:ON ACTION controlp INFIELD pmca002 name="input.c.pmca002"
#此段落由子樣板a07產生            
            #開窗i段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmca_m.pmca002             #給予default值
            LET g_qryparam.default2 = "" #g_pmca_m.oofa011 #全名

            #給予arg
            LET g_qryparam.where = " ooag003 IS NOT NULL"
            #CALL q_ooag001_2()                           #呼叫開窗   #151228-00009#1 20151230 mark by beckxie
            CALL q_ooag001_4()                           #呼叫開窗    #151228-00009#1 20151230 add by beckxie
            INITIALIZE g_qryparam.where TO NULL
            LET g_pmca_m.pmca002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_pmca_m.oofa011 = g_qryparam.return2 #全名

            DISPLAY g_pmca_m.pmca002 TO pmca002              #顯示到畫面上
            #DISPLAY g_pmca_m.oofa011 TO oofa011 #全名

            NEXT FIELD pmca002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmca003
            #add-point:ON ACTION controlp INFIELD pmca003 name="input.c.pmca003"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcastus
            #add-point:ON ACTION controlp INFIELD pmcastus name="input.c.pmcastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pmca_m.pmcadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                   CALL s_aooi200_gen_docno(g_site,g_pmca_m.pmcadocno,g_today,g_prog) RETURNING l_success,g_pmca_m.pmcadocno
                   LET g_pmcadocno_t = g_pmca_m.pmcadocno
               #end add-point
               
               INSERT INTO pmca_t (pmcaent,pmcadocno,pmcadocdt,pmca001,pmca002,pmca003,pmcastus,pmcaownid, 
                   pmcaowndp,pmcacrtid,pmcacrtdp,pmcacrtdt,pmcamodid,pmcamoddt,pmcacnfid,pmcacnfdt)
               VALUES (g_enterprise,g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt,g_pmca_m.pmca001,g_pmca_m.pmca002, 
                   g_pmca_m.pmca003,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaowndp,g_pmca_m.pmcacrtid, 
                   g_pmca_m.pmcacrtdp,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamoddt,g_pmca_m.pmcacnfid, 
                   g_pmca_m.pmcacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_pmca_m:",SQLERRMESSAGE 
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
                  CALL apmt820_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apmt820_b_fill()
                  CALL apmt820_b_fill2('0')
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
               CALL apmt820_pmca_t_mask_restore('restore_mask_o')
               
               UPDATE pmca_t SET (pmcadocno,pmcadocdt,pmca001,pmca002,pmca003,pmcastus,pmcaownid,pmcaowndp, 
                   pmcacrtid,pmcacrtdp,pmcacrtdt,pmcamodid,pmcamoddt,pmcacnfid,pmcacnfdt) = (g_pmca_m.pmcadocno, 
                   g_pmca_m.pmcadocdt,g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca003,g_pmca_m.pmcastus, 
                   g_pmca_m.pmcaownid,g_pmca_m.pmcaowndp,g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtdp,g_pmca_m.pmcacrtdt, 
                   g_pmca_m.pmcamodid,g_pmca_m.pmcamoddt,g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfdt)
                WHERE pmcaent = g_enterprise AND pmcadocno = g_pmcadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "pmca_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL apmt820_pmca_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_pmca_m_t)
               LET g_log2 = util.JSON.stringify(g_pmca_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_pmcadocno_t = g_pmca_m.pmcadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="apmt820.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pmcb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmcb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt820_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pmcb_d.getLength()
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
            OPEN apmt820_cl USING g_enterprise,g_pmca_m.pmcadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt820_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt820_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pmcb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmcb_d[l_ac].pmcbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pmcb_d_t.* = g_pmcb_d[l_ac].*  #BACKUP
               LET g_pmcb_d_o.* = g_pmcb_d[l_ac].*  #BACKUP
               CALL apmt820_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL apmt820_set_no_entry_b(l_cmd)
               IF NOT apmt820_lock_b("pmcb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt820_bcl INTO g_pmcb_d[l_ac].pmcbseq,g_pmcb_d[l_ac].pmcb001,g_pmcb_d[l_ac].pmcb002, 
                      g_pmcb_d[l_ac].pmcb003,g_pmcb_d[l_ac].pmcb004,g_pmcb_d[l_ac].pmcb005,g_pmcb_d[l_ac].pmcb006, 
                      g_pmcb_d[l_ac].pmcb007,g_pmcb_d[l_ac].pmcb008,g_pmcb_d[l_ac].pmcb009,g_pmcb_d[l_ac].pmcbacti, 
                      g_pmcb_d[l_ac].pmcb010,g_pmcb_d[l_ac].pmcb011
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pmcb_d_t.pmcbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmcb_d_mask_o[l_ac].* =  g_pmcb_d[l_ac].*
                  CALL apmt820_pmcb_t_mask()
                  LET g_pmcb_d_mask_n[l_ac].* =  g_pmcb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmt820_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
#            IF l_cmd = 'u' AND l_times = 0 THEN   
#               CALL apmt820_01(g_pmca_m.pmca001,g_pmca_m.pmcadocno,g_pmcb_d[l_ac].pmcbseq) RETURNING l_times
#               LET g_action_choice = ''
#               CALL apmt820_upd_show()
#               CALL FGL_SET_ARR_CURR(l_ac)
#            END IF
#            IF l_times != 0 THEN
#               LET l_times = 0
#            END IF
            
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
            INITIALIZE g_pmcb_d[l_ac].* TO NULL 
            INITIALIZE g_pmcb_d_t.* TO NULL 
            INITIALIZE g_pmcb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_pmcb_d[l_ac].pmcbacti = "Y"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_pmcb_d_t.* = g_pmcb_d[l_ac].*     #新輸入資料
            LET g_pmcb_d_o.* = g_pmcb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmt820_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL apmt820_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmcb_d[li_reproduce_target].* = g_pmcb_d[li_reproduce].*
 
               LET g_pmcb_d[li_reproduce_target].pmcbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
#            LET l_times = 0 
#            IF g_pmca_m.pmca001 = 'I' THEN
#               CALL apmt820_01(g_pmca_m.pmca001,g_pmca_m.pmcadocno,'') RETURNING l_times
#               LET g_action_choice = ''
#               CALL apmt820_ins_fill()             
#               IF l_times != 0 THEN   #如果子程式新增資料大於0筆
#                  DISPLAY ARRAY g_pmcb_d TO s_detail1.* 
#                     BEFORE DISPLAY
#                        EXIT DISPLAY
#                  END DISPLAY
#                  CALL ui.Interface.refresh()
#                  CALL s_transaction_begin()
#                  CALL FGL_SET_ARR_CURR(l_ac)
#               END IF 
#            END IF
#            IF l_times = 0 THEN
               #LET g_pmcb_d[l_ac].pmcb009 = g_site   #161006-00008#11 by sakura mark
               #161006-00008#11 by sakura add(S)
               CALL s_aooi500_default(g_prog,'pmcb009',g_pmcb_d[l_ac].pmcb009)
               RETURNING l_insert,g_pmcb_d[l_ac].pmcb009
               #161006-00008#11 by sakura add(E)
               IF g_pmca_m.pmca001 = 'I' THEN
                  LET g_pmcb_d[l_ac].pmcbacti='Y'
               END IF
               SELECT MAX(pmcbseq) INTO g_pmcb_d[l_ac].pmcbseq 
                 FROM pmcb_t WHERE pmcbdocno = g_pmca_m.pmcadocno
                  AND pmcbent = g_enterprise
               LET g_pmcb_d[l_ac].pmcb007 = g_today
               IF cl_null(g_pmcb_d[l_ac].pmcbseq) THEN LET g_pmcb_d[l_ac].pmcbseq  = 0 END IF
               LET g_pmcb_d[l_ac].pmcbseq = g_pmcb_d[l_ac].pmcbseq + 1  
               LET g_pmcb_d_t.* = g_pmcb_d[l_ac].*
#            END IF               
 
            
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
#            IF l_times != 0 OR l_ins_times != 0 THEN
#               CALL s_transaction_end('N','0')
#               CANCEL INSERT
#            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM pmcb_t 
             WHERE pmcbent = g_enterprise AND pmcbdocno = g_pmca_m.pmcadocno
 
               AND pmcbseq = g_pmcb_d[l_ac].pmcbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
 
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmca_m.pmcadocno
               LET gs_keys[2] = g_pmcb_d[g_detail_idx].pmcbseq
               CALL apmt820_insert_b('pmcb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
            
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_pmcb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmcb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apmt820_b_fill()
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
               LET gs_keys[01] = g_pmca_m.pmcadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_pmcb_d_t.pmcbseq
 
            
               #刪除同層單身
               IF NOT apmt820_delete_b('pmcb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt820_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmt820_key_delete_b(gs_keys,'pmcb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt820_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apmt820_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_pmcb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmcb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcbseq
            #add-point:BEFORE FIELD pmcbseq name="input.b.page1.pmcbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcbseq
            
            #add-point:AFTER FIELD pmcbseq name="input.a.page1.pmcbseq"
            #此段落由子樣板a05產生
          #IF l_times = 0 THEN
               IF  NOT cl_null(g_pmca_m.pmcadocno) AND NOT cl_null(g_pmcb_d[l_ac].pmcbseq) THEN 
                  IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_pmca_m.pmcadocno != g_pmcadocno_t OR g_pmcb_d[l_ac].pmcbseq != g_pmcb_d_t.pmcbseq))) THEN 
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmcb_t WHERE "||"pmcbdocno = '"||g_pmca_m.pmcadocno ||"' AND "|| "pmcbseq = '"||g_pmcb_d[l_ac].pmcbseq ||"' AND pmcbent = "||g_enterprise,'std-00004',0) THEN #160905-00007#11 Add ent
                        LET g_pmcb_d[l_ac].pmcbseq = g_pmcb_d_t.pmcbseq
                        DISPLAY BY NAME g_pmcb_d[l_ac].pmcbseq
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            #END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcbseq
            #add-point:ON CHANGE pmcbseq name="input.g.page1.pmcbseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb001
            
            #add-point:AFTER FIELD pmcb001 name="input.a.page1.pmcb001"
            DISPLAY '' TO s_detail1[l_ac].pmcb001_desc
            DISPLAY '' TO s_detail1[l_ac].pmaastus
            DISPLAY '' TO s_detail1[l_ac].pmaa083
            #20160907先Mark(S)
            #160822-00022#4 Add By ken 160822(S)
            #IF NOT cl_null(g_pmcb_d[l_ac].pmcb001) THEN       #紅色即為助記碼會增加的程式段落  (有順序問題，要最先做)
            #   INITIALIZE g_rtn_fields TO NULL
            #           #助記碼搜尋    目標table     傳入資料          傳入where condiction      搜尋欄位                                    回傳值       是否發生問題
            #   CALL cl_mnemonic('pmaal_t',g_pmcb_d[l_ac].pmcb001,"pmaal002='"||g_dlang||"'",'pmaal001,pmaal003,pmaal005') RETURNING g_rtn_fields, g_chk
            #   IF g_chk THEN
            #      LET g_pmcb_d[l_ac].pmcb001 = g_rtn_fields[1]
            #   ELSE
            #      LET g_pmcb_d[l_ac].pmcb001 = ""
            #   END IF
            #   DISPLAY BY NAME g_pmcb_d[l_ac].pmcb001   #顯示回需要資料的欄位
            #END IF            
            #160822-00022#4 Add By ken 160822(E)
            #20160907先Mark(E)
            
            IF l_cmd = 'a' OR( l_cmd = 'u' AND g_pmcb_d[l_ac].pmcb001 !=g_pmcb_d_t.pmcb001) THEN
               IF NOT cl_null(g_pmcb_d[l_ac].pmcb001) THEN
                  IF NOT ap_chk_isExist(g_pmcb_d[l_ac].pmcb001,"SELECT COUNT(*) FROM pmaa_t WHERE pmaa001 = ? AND pmaaent = "||g_enterprise||" ",'apm-00016',1) THEN
                     LET g_pmcb_d[l_ac].pmcb001 = g_pmcb_d_t.pmcb001
                     CALL apmt820_pmcb001_desc()
                     DISPLAY BY NAME g_pmcb_d[l_ac].pmcb001
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT ap_chk_isExist(g_pmcb_d[l_ac].pmcb001,"SELECT COUNT(*) FROM pmaa_t WHERE pmaa001 = ? AND pmaaent = "||g_enterprise||" AND pmaastus= 'Y' ",'apm-00017',1) THEN
                     LET g_pmcb_d[l_ac].pmcb001 = g_pmcb_d_t.pmcb001
                     CALL apmt820_pmcb001_desc()
                     DISPLAY BY NAME g_pmcb_d[l_ac].pmcb001
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT apmt820_key_chk() THEN
                     LET g_pmcb_d[l_ac].pmcb001 = g_pmcb_d_t.pmcb001
                     CALL apmt820_pmcb001_desc()
                     IF g_pmca_m.pmca001 = 'I' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00033'
                        LET g_errparam.extend = g_pmcb_d[l_ac].pmcb001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                     ELSE
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00204'
                        LET g_errparam.extend = g_pmcb_d[l_ac].pmcb001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                     END IF
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF g_pmca_m.pmca001 = 'I' THEN
                     IF NOT apmt820_pmag001_pmag002_pmag003_chk() THEN
                        LET g_pmcb_d[l_ac].pmcb001 = g_pmcb_d_t.pmcb001
                        CALL apmt820_pmcb001_desc()
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00205'
                        LET g_errparam.extend = g_pmcb_d[l_ac].pmcb001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF NOT apmt820_pmag001_exists() THEN
                        LET g_pmcb_d[l_ac].pmcb001 = g_pmcb_d_t.pmcb001
                        CALL apmt820_pmcb001_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  IF l_cmd = 'a' AND g_pmca_m.pmca001 = 'U' THEN
                     LET l_state =  g_qryparam.state
                     LET g_qryparam.state = "m"
                     LET g_qryparam.reqry = FALSE
                     LET g_qryparam.default1 = g_pmcb_d[l_ac].pmcb001
                     LET g_qryparam.arg1 = g_pmcb_d[l_ac].pmcb001
                     CALL q_pmag_1()
                     LET l_lines = 1
                     IF g_qryparam.str_array.getLength() > 0 THEN
                        CALL apmt820_controlp_chk(g_qryparam.str_array) RETURNING l_lines
                     END IF
                     LET g_qryparam.state = l_state
                     IF l_lines <= 1 AND g_qryparam.str_array.getLength() != 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00206'
                        LET g_errparam.extend = g_pmcb_d[l_ac].pmcb001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_flag = FALSE
                        NEXT FIELD CURRENT
                     END IF
                     IF g_qryparam.str_array.getLength() = 0 THEN
                        LET g_flag = FALSE
                        NEXT FIELD CURRENT
                     END IF
                     CALL apmt820_show()
                     LET g_flag = TRUE
                     EXIT DIALOG
                  END IF
               END IF
            END IF
            
            CALL apmt820_pmcb001_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb001
            #add-point:BEFORE FIELD pmcb001 name="input.b.page1.pmcb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcb001
            #add-point:ON CHANGE pmcb001 name="input.g.page1.pmcb001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb002
            
            #add-point:AFTER FIELD pmcb002 name="input.a.page1.pmcb002"
            DISPLAY '' TO s_detail1[l_ac].pmcb002_desc
            IF l_cmd = 'a' OR( l_cmd = 'u' AND g_pmcb_d[l_ac].pmcb002 !=g_pmcb_d_t.pmcb002) THEN
               IF NOT cl_null(g_pmcb_d[l_ac].pmcb002) THEN
                  IF NOT ap_chk_isExist(g_pmcb_d[l_ac].pmcb002,"SELECT COUNT(*) FROM oocq_t WHERE oocq001 = '2036' AND oocqent = "||g_enterprise||" AND oocq002 = ? ",'sub-01303',"apmi036") THEN  #apm-00018  #160318-00005#37  By 07900--mod
                     LET g_pmcb_d[l_ac].pmcb002 = g_pmcb_d_t.pmcb002
                     CALL apmt820_pmcb002_desc()
                     DISPLAY BY NAME g_pmcb_d[l_ac].pmcb002
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT ap_chk_isExist(g_pmcb_d[l_ac].pmcb002,"SELECT COUNT(*) FROM oocq_t WHERE oocq001 = '2036' AND oocqent = "||g_enterprise||" AND oocq002 = ? AND oocqstus='Y'",'sub-01302',"apmi036") THEN  #apm-00019  #160318-00005#37  By 07900--mod
                     LET g_pmcb_d[l_ac].pmcb002 = g_pmcb_d_t.pmcb002
                     CALL apmt820_pmcb002_desc()
                     DISPLAY BY NAME g_pmcb_d[l_ac].pmcb002
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT apmt820_key_chk() THEN
                     LET g_pmcb_d[l_ac].pmcb002 = g_pmcb_d_t.pmcb002
                     CALL apmt820_pmcb002_desc()
                     IF g_pmca_m.pmca001 = 'I' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00033'
                        LET g_errparam.extend = g_pmcb_d[l_ac].pmcb002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                     ELSE
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00204'
                        LET g_errparam.extend = g_pmcb_d[l_ac].pmcb002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                     END IF
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF g_pmca_m.pmca001 = 'I' THEN
                     IF NOT apmt820_pmag001_pmag002_pmag003_chk() THEN
                        LET g_pmcb_d[l_ac].pmcb002 = g_pmcb_d_t.pmcb002
                        CALL apmt820_pmcb002_desc()
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apm-00205'
                        LET g_errparam.extend = g_pmcb_d[l_ac].pmcb002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL apmt820_pmcb002_desc()
            
            let g_pmcb_d[l_ac].pmcb004=g_pmcb_d[l_ac].pmcb002_desc
            display by name g_pmcb_d[l_ac].pmcb004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb002
            #add-point:BEFORE FIELD pmcb002 name="input.b.page1.pmcb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcb002
            #add-point:ON CHANGE pmcb002 name="input.g.page1.pmcb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb003
            #add-point:BEFORE FIELD pmcb003 name="input.b.page1.pmcb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb003
            
            #add-point:AFTER FIELD pmcb003 name="input.a.page1.pmcb003"
            IF l_cmd = 'a' OR( l_cmd = 'u' AND g_pmcb_d[l_ac].pmcb003 !=g_pmcb_d_t.pmcb003) THEN
               IF NOT apmt820_key_chk() THEN
                  LET g_pmcb_d[l_ac].pmcb003 = g_pmcb_d_t.pmcb003
                  IF g_pmca_m.pmca001 = 'I' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00033'
                     LET g_errparam.extend = g_pmcb_d[l_ac].pmcb003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00204'
                     LET g_errparam.extend = g_pmcb_d[l_ac].pmcb003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  END IF
                  NEXT FIELD CURRENT
               END IF
               IF g_pmca_m.pmca001 = 'I' THEN
                  IF NOT apmt820_pmag001_pmag002_pmag003_chk() THEN
                     LET g_pmcb_d[l_ac].pmcb003 = g_pmcb_d_t.pmcb003
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00205'
                     LET g_errparam.extend = g_pmcb_d[l_ac].pmcb003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcb003
            #add-point:ON CHANGE pmcb003 name="input.g.page1.pmcb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb004
            #add-point:BEFORE FIELD pmcb004 name="input.b.page1.pmcb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb004
            
            #add-point:AFTER FIELD pmcb004 name="input.a.page1.pmcb004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcb004
            #add-point:ON CHANGE pmcb004 name="input.g.page1.pmcb004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb005
            
            #add-point:AFTER FIELD pmcb005 name="input.a.page1.pmcb005"
            CALL apmt820_pmcb005_desc()
            IF NOT cl_null(g_pmcb_d[l_ac].pmcb005) THEN
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM rtax_t
                WHERE rtax001 = g_pmcb_d[l_ac].pmcb005
                  AND rtaxent = g_enterprise
               IF l_n = 0 THEN
                  LET g_pmcb_d[l_ac].pmcb005 = g_pmcb_d_t.pmcb005
                  DISPLAY BY NAME g_pmcb_d[l_ac].pmcb005
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00002'
                  LET g_errparam.extend = g_pmcb_d[l_ac].pmcb005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM rtax_t
                WHERE rtax001 = g_pmcb_d[l_ac].pmcb005
                  AND rtaxent = g_enterprise
                  AND rtaxstus= 'Y'
               IF l_n = 0 THEN
                  LET g_pmcb_d[l_ac].pmcb005 = g_pmcb_d_t.pmcb005
                  DISPLAY BY NAME g_pmcb_d[l_ac].pmcb005
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-01302'  #art-00009  #160318-00005#37 by 07900 --mod  
                  LET g_errparam.extend = g_pmcb_d[l_ac].pmcb005
                  #160318-00005#317  By 07900 --add-str
                   LET g_errparam.replace[1] ='arti202'
                   LET g_errparam.replace[2] = cl_get_progname("arti202",g_lang,"2")
                   LET g_errparam.exeprog ='arti202'
                   #160318-00005#37  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_pmcb_d[l_ac].pmcb006) THEN
                  IF NOT apmt820_pmcb005_pmcb006_chk() THEN                  
                     LET g_pmcb_d[l_ac].pmcb005 = g_pmcb_d_t.pmcb005
                     DISPLAY BY NAME g_pmcb_d[l_ac].pmcb005
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00021'
                     LET g_errparam.extend = g_pmcb_d[l_ac].pmcb006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT 
                  END IF 
               END IF
            END IF
            
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb005
            #add-point:BEFORE FIELD pmcb005 name="input.b.page1.pmcb005"
            CALL apmt820_pmcb005_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcb005
            #add-point:ON CHANGE pmcb005 name="input.g.page1.pmcb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb006
            
            #add-point:AFTER FIELD pmcb006 name="input.a.page1.pmcb006"
            LET g_pmcb_d[l_ac].pmcb006_desc = ''
            LET g_pmcb_d[l_ac].pmcb006_desc_desc = ''
            DISPLAY BY NAME g_pmcb_d[l_ac].pmcb006_desc,g_pmcb_d[l_ac].pmcb005_desc
            IF NOT cl_null(g_pmcb_d[l_ac].pmcb006) THEN
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM imaa_t
                WHERE imaa001 = g_pmcb_d[l_ac].pmcb006
                  AND imaaent = g_enterprise
               IF l_n = 0 THEN
                  LET g_pmcb_d[l_ac].pmcb006 = g_pmcb_d_t.pmcb006
                  DISPLAY BY NAME g_pmcb_d[l_ac].pmcb006
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00001'
                  LET g_errparam.extend = g_pmcb_d[l_ac].pmcb006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               
               LET l_n = 0 
               SELECT COUNT(*) INTO l_n FROM imaa_t
                WHERE imaa001 = g_pmcb_d[l_ac].pmcb006
                  AND imaaent = g_enterprise
                  AND imaastus= 'Y'
               IF l_n = 0 THEN
                  LET g_pmcb_d[l_ac].pmcb006 = g_pmcb_d_t.pmcb006
                  DISPLAY BY NAME g_pmcb_d[l_ac].pmcb006
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00101'
                  LET g_errparam.extend = g_pmcb_d[l_ac].pmcb006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_pmcb_d[l_ac].pmcb005) THEN
                  IF NOT apmt820_pmcb005_pmcb006_chk() THEN  
                     LET g_pmcb_d[l_ac].pmcb006 = g_pmcb_d_t.pmcb006
                     DISPLAY BY NAME g_pmcb_d[l_ac].pmcb006
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00020'
                     LET g_errparam.extend = g_pmcb_d[l_ac].pmcb006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT 
                  END IF
               ELSE
                  SELECT imaa009 INTO g_pmcb_d[l_ac].pmcb005 FROM imaa_t
                   WHERE imaaent = g_enterprise
                     AND imaa001 = g_pmcb_d[l_ac].pmcb006
                  DISPLAY BY NAME g_pmcb_d[l_ac].pmcb005
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmcb_d[l_ac].pmcb006_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_pmcb_d[l_ac].pmcb006_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb006
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmcb_d[l_ac].pmcb006_desc_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_pmcb_d[l_ac].pmcb006_desc_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb006
            #add-point:BEFORE FIELD pmcb006 name="input.b.page1.pmcb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcb006
            #add-point:ON CHANGE pmcb006 name="input.g.page1.pmcb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb007
            #add-point:BEFORE FIELD pmcb007 name="input.b.page1.pmcb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb007
            
            #add-point:AFTER FIELD pmcb007 name="input.a.page1.pmcb007"
            IF NOT cl_null(g_pmcb_d[l_ac].pmcb007) AND NOT cl_null(g_pmcb_d[l_ac].pmcb008) THEN
              IF g_pmcb_d[l_ac].pmcb007 > g_pmcb_d[l_ac].pmcb008 THEN
                  LET g_pmcb_d[l_ac].pmcb007 = g_pmcb_d_t.pmcb007
                  DISPLAY BY NAME g_pmcb_d[l_ac].pmcb007
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00122'
                  LET g_errparam.extend = g_pmcb_d[l_ac].pmcb007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
              END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcb007
            #add-point:ON CHANGE pmcb007 name="input.g.page1.pmcb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb008
            #add-point:BEFORE FIELD pmcb008 name="input.b.page1.pmcb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb008
            
            #add-point:AFTER FIELD pmcb008 name="input.a.page1.pmcb008"
            IF NOT cl_null(g_pmcb_d[l_ac].pmcb007) AND NOT cl_null(g_pmcb_d[l_ac].pmcb008) THEN
              IF g_pmcb_d[l_ac].pmcb007 > g_pmcb_d[l_ac].pmcb008 THEN
                 LET g_pmcb_d[l_ac].pmcb008 = g_pmcb_d_t.pmcb008
                 DISPLAY BY NAME g_pmcb_d[l_ac].pmcb008
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'aoo-00122'
                 LET g_errparam.extend = g_pmcb_d[l_ac].pmcb007
                 LET g_errparam.popup = TRUE
                 CALL cl_err()

                 NEXT FIELD CURRENT   
              END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcb008
            #add-point:ON CHANGE pmcb008 name="input.g.page1.pmcb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcb009
            
            #add-point:AFTER FIELD pmcb009 name="input.a.page1.pmcb009"
            LET g_pmcb_d[l_ac].pmcb009_desc = ''
            DISPLAY BY NAME g_pmcb_d[l_ac].pmcb009_desc
            IF NOT cl_null(g_pmcb_d[l_ac].pmcb009) THEN
               #150518-00050#1 Modify By Ken 150520
               #IF NOT ap_chk_isExist(g_pmcb_d[l_ac].pmcb009,"SELECT COUNT(*) FROM ooea_t WHERE ooea001 = ? AND ooeaent = '"||g_enterprise||"'",'aoo-00094',1) THEN
               IF NOT ap_chk_isExist(g_pmcb_d[l_ac].pmcb009,"SELECT COUNT(*) FROM ooef_t WHERE ooef001 = ? AND ooefent = '"||g_enterprise||"'",'aoo-00094',1) THEN               
                  LET g_pmcb_d[l_ac].pmcb009 = g_pmcb_d_t.pmcb009
                  NEXT FIELD CURRENT
               END IF
               
               #IF NOT ap_chk_isExist(g_pmcb_d[l_ac].pmcb009,"SELECT COUNT(*) FROM ooea_t WHERE ooea001 = ? AND ooeaent = '"||g_enterprise||"' AND ooeastus= 'Y'",'aoo-00095',1) THEN
               IF NOT ap_chk_isExist(g_pmcb_d[l_ac].pmcb009,"SELECT COUNT(*) FROM ooef_t WHERE ooef001 = ? AND ooefent = '"||g_enterprise||"' AND ooefstus= 'Y'",'sub-01302',"aooi125") THEN  #aoo-00095  #160318-00005#37  By 07900--mod
                  LET g_pmcb_d[l_ac].pmcb009 = g_pmcb_d_t.pmcb009
                  NEXT FIELD CURRENT
               END IF
               #150518-00050#1 Modify By Ken 150520
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb009
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_pmcb_d[l_ac].pmcb009_desc = g_rtn_fields[1]
               DISPLAY BY NAME g_pmcb_d[l_ac].pmcb009_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcb009
            #add-point:BEFORE FIELD pmcb009 name="input.b.page1.pmcb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcb009
            #add-point:ON CHANGE pmcb009 name="input.g.page1.pmcb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcbacti
            #add-point:BEFORE FIELD pmcbacti name="input.b.page1.pmcbacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcbacti
            
            #add-point:AFTER FIELD pmcbacti name="input.a.page1.pmcbacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcbacti
            #add-point:ON CHANGE pmcbacti name="input.g.page1.pmcbacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmcbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcbseq
            #add-point:ON ACTION controlp INFIELD pmcbseq name="input.c.page1.pmcbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb001
            #add-point:ON ACTION controlp INFIELD pmcb001 name="input.c.page1.pmcb001"
#此段落由子樣板a07產生            
            #開窗i段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcb_d[l_ac].pmcb001             #給予default值

            #給予arg
            IF g_pmca_m.pmca001 = 'I' THEN
               #LET g_qryparam.where = " pmaa002 IN ('1','3')"
               #CALL q_pmaa001()                         #呼叫開窗  #160908-00032#2 mark by rainy 
               CALL q_pmaa001_4()                        #呼叫開窗    #160908-00032#2 by rainy 開窗改為 q_pmaa001_4()
               INITIALIZE g_qryparam.where TO NULL
            ELSE
               CALL q_pmag001()
            END IF
            LET g_pmcb_d[l_ac].pmcb001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcb_d[l_ac].pmcb001 TO pmcb001              #顯示到畫面上

            NEXT FIELD pmcb001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb002
            #add-point:ON ACTION controlp INFIELD pmcb002 name="input.c.page1.pmcb002"
#此段落由子樣板a07產生            
            #開窗i段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcb_d[l_ac].pmcb002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2036" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmcb_d[l_ac].pmcb002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcb_d[l_ac].pmcb002 TO pmcb002              #顯示到畫面上

            NEXT FIELD pmcb002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb003
            #add-point:ON ACTION controlp INFIELD pmcb003 name="input.c.page1.pmcb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb004
            #add-point:ON ACTION controlp INFIELD pmcb004 name="input.c.page1.pmcb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb005
            #add-point:ON ACTION controlp INFIELD pmcb005 name="input.c.page1.pmcb005"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcb_d[l_ac].pmcb005             #給予default值

            #給予arg

            CALL q_rtax001_1()                                #呼叫開窗

            LET g_pmcb_d[l_ac].pmcb005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcb_d[l_ac].pmcb005 TO pmcb005              #顯示到畫面上

            NEXT FIELD pmcb005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb006
            #add-point:ON ACTION controlp INFIELD pmcb006 name="input.c.page1.pmcb006"
#此段落由子樣板a07產生            
            #開窗i段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcb_d[l_ac].pmcb006             #給予default值

            #給予arg
            IF NOT cl_null(g_pmcb_d[l_ac].pmcb005) THEN
               CALL apmt820_get_bottom() RETURNING  l_bottom
               LET g_qryparam.where = " imaa009 IN (",l_bottom,")"
            END IF
            CALL q_imaa001()                                #呼叫開窗
            INITIALIZE g_qryparam.where TO NULL
            LET g_pmcb_d[l_ac].pmcb006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcb_d[l_ac].pmcb006 TO pmcb006              #顯示到畫面上

            NEXT FIELD pmcb006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb007
            #add-point:ON ACTION controlp INFIELD pmcb007 name="input.c.page1.pmcb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb008
            #add-point:ON ACTION controlp INFIELD pmcb008 name="input.c.page1.pmcb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcb009
            #add-point:ON ACTION controlp INFIELD pmcb009 name="input.c.page1.pmcb009"
#此段落由子樣板a07產生            
            #開窗i段
            #151207-00021#5 151215 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'            
            #151207-00021#5 151215 by sakura add(E)            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmcb_d[l_ac].pmcb009             #給予default值

            #給予arg
            #150518-00050#1 Modify By Ken 150520
            #CALL q_ooea001()                                #呼叫開窗
            #CALL q_ooef001()   #161006-00008#11 by sakura mark
            #150518-00050#1 Modify By Ken 150520
            #161006-00008#11 by sakura add(S)
            IF s_aooi500_setpoint(g_prog,'pmcb009') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmcb009',g_site,'c')
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001()  
            END IF
            #161006-00008#11 by sakura add(E)            
            
            LET g_pmcb_d[l_ac].pmcb009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmcb_d[l_ac].pmcb009 TO pmcb009              #顯示到畫面上

            NEXT FIELD pmcb009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmcbacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcbacti
            #add-point:ON ACTION controlp INFIELD pmcbacti name="input.c.page1.pmcbacti"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmcb_d[l_ac].* = g_pmcb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmt820_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmcb_d[l_ac].pmcbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_pmcb_d[l_ac].* = g_pmcb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               IF l_cmd !='a' THEN
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL apmt820_pmcb_t_mask_restore('restore_mask_o')
      
               UPDATE pmcb_t SET (pmcbdocno,pmcbseq,pmcb001,pmcb002,pmcb003,pmcb004,pmcb005,pmcb006, 
                   pmcb007,pmcb008,pmcb009,pmcbacti,pmcb010,pmcb011) = (g_pmca_m.pmcadocno,g_pmcb_d[l_ac].pmcbseq, 
                   g_pmcb_d[l_ac].pmcb001,g_pmcb_d[l_ac].pmcb002,g_pmcb_d[l_ac].pmcb003,g_pmcb_d[l_ac].pmcb004, 
                   g_pmcb_d[l_ac].pmcb005,g_pmcb_d[l_ac].pmcb006,g_pmcb_d[l_ac].pmcb007,g_pmcb_d[l_ac].pmcb008, 
                   g_pmcb_d[l_ac].pmcb009,g_pmcb_d[l_ac].pmcbacti,g_pmcb_d[l_ac].pmcb010,g_pmcb_d[l_ac].pmcb011) 
 
                WHERE pmcbent = g_enterprise AND pmcbdocno = g_pmca_m.pmcadocno 
 
                  AND pmcbseq = g_pmcb_d_t.pmcbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pmcb_d[l_ac].* = g_pmcb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmcb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pmcb_d[l_ac].* = g_pmcb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmcb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmca_m.pmcadocno
               LET gs_keys_bak[1] = g_pmcadocno_t
               LET gs_keys[2] = g_pmcb_d[g_detail_idx].pmcbseq
               LET gs_keys_bak[2] = g_pmcb_d_t.pmcbseq
               CALL apmt820_update_b('pmcb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apmt820_pmcb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pmcb_d[g_detail_idx].pmcbseq = g_pmcb_d_t.pmcbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_pmca_m.pmcadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmcb_d_t.pmcbseq
 
                  CALL apmt820_key_update_b(gs_keys,'pmcb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmca_m),util.JSON.stringify(g_pmcb_d_t)
               LET g_log2 = util.JSON.stringify(g_pmca_m),util.JSON.stringify(g_pmcb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL apmt820_unlock_b("pmcb_t","'1'")
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
               LET g_pmcb_d[li_reproduce_target].* = g_pmcb_d[li_reproduce].*
 
               LET g_pmcb_d[li_reproduce_target].pmcbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmcb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmcb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="apmt820.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF g_flag THEN
            LET g_flag = FALSE
            NEXT FIELD pmcbseq
         END IF 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD pmcadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pmcbseq
 
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
   IF g_flag THEN
      CALL apmt820_input('u')
   END IF
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
   END IF   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apmt820.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apmt820_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apmt820_b_fill() #單身填充
      CALL apmt820_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmt820_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmca_m.pmcaownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmca_m.pmcaownid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmca_m.pmcaownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmca_m.pmcaowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmca_m.pmcaowndp_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmca_m.pmcaowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmca_m.pmcacrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmca_m.pmcacrtid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmca_m.pmcacrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmca_m.pmcacrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmca_m.pmcacrtdp_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmca_m.pmcacrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmca_m.pmcamodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmca_m.pmcamodid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmca_m.pmcamodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmca_m.pmcacnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmca_m.pmcacnfid_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmca_m.pmcacnfid_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmca_m.pmca002
#            CALL ap_ref_array2(g_ref_fields,"SELECT oofa011 FROM ooag_t LEFT OUTER JOIN oofa_t ON oofa001 = ooag002 AND oofaent = '"||g_enterprise||"' WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_pmca_m.pmca002_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmca_m.pmca002_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmca_m.pmca003
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooefl001 =? AND ooeflent = '"||g_enterprise||"' AND ooefl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmca_m.pmca003_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmca_m.pmca003_desc
         
           
   #end add-point
   
   #遮罩相關處理
   LET g_pmca_m_mask_o.* =  g_pmca_m.*
   CALL apmt820_pmca_t_mask()
   LET g_pmca_m_mask_n.* =  g_pmca_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt,g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca002_desc, 
       g_pmca_m.pmca003,g_pmca_m.pmca003_desc,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaownid_desc, 
       g_pmca_m.pmcaowndp,g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp, 
       g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamodid_desc,g_pmca_m.pmcamoddt, 
       g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfid_desc,g_pmca_m.pmcacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmca_m.pmcastus 
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
   FOR l_ac = 1 TO g_pmcb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            SELECT pmaastus,pmaa083 INTO g_pmcb_d[l_ac].pmaastus,g_pmcb_d[l_ac].pmaa083 FROM pmaa_t
             WHERE pmaaent = g_enterprise
               AND pmaa001 = g_pmcb_d[l_ac].pmcb001
            DISPLAY BY NAME g_pmcb_d[l_ac].pmaastus,g_pmcb_d[l_ac].pmaa083
            
            #CALL apmt820_pmaa083_desc()
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb001
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcb_d[l_ac].pmcb001_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcb_d[l_ac].pmcb001_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb002
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2036' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcb_d[l_ac].pmcb002_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcb_d[l_ac].pmcb002_desc
#        
#            CALL apmt820_pmcb005_desc()
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb009
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_pmcb_d[l_ac].pmcb009_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_pmcb_d[l_ac].pmcb009_desc
#            
#            CALL apmt820_pmcb001_desc()

      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apmt820_detail_show()
 
   #add-point:show段之後 name="show.after"
   #CALL apmt820_only_show(1)
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apmt820_detail_show()
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
 
{<section id="apmt820.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmt820_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE pmca_t.pmcadocno 
   DEFINE l_oldno     LIKE pmca_t.pmcadocno 
 
   DEFINE l_master    RECORD LIKE pmca_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pmcb_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_pmca_m.pmcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_pmcadocno_t = g_pmca_m.pmcadocno
 
    
   LET g_pmca_m.pmcadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmca_m.pmcaownid = g_user
      LET g_pmca_m.pmcaowndp = g_dept
      LET g_pmca_m.pmcacrtid = g_user
      LET g_pmca_m.pmcacrtdp = g_dept 
      LET g_pmca_m.pmcacrtdt = cl_get_current()
      LET g_pmca_m.pmcamodid = g_user
      LET g_pmca_m.pmcamoddt = cl_get_current()
      LET g_pmca_m.pmcastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmca_m.pmcastus 
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
   
   
   CALL apmt820_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_pmca_m.* TO NULL
      INITIALIZE g_pmcb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apmt820_show()
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
   CALL apmt820_set_act_visible()   
   CALL apmt820_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmcadocno_t = g_pmca_m.pmcadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmcaent = " ||g_enterprise|| " AND",
                      " pmcadocno = '", g_pmca_m.pmcadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt820_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL apmt820_idx_chk()
   
   LET g_data_owner = g_pmca_m.pmcaownid      
   LET g_data_dept  = g_pmca_m.pmcaowndp
   
   #功能已完成,通報訊息中心
   CALL apmt820_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt820.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apmt820_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pmcb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apmt820_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmcb_t
    WHERE pmcbent = g_enterprise AND pmcbdocno = g_pmcadocno_t
 
    INTO TEMP apmt820_detail
 
   #將key修正為調整後   
   UPDATE apmt820_detail 
      #更新key欄位
      SET pmcbdocno = g_pmca_m.pmcadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO pmcb_t SELECT * FROM apmt820_detail
   
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
   DROP TABLE apmt820_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pmcadocno_t = g_pmca_m.pmcadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apmt820_delete()
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
   
   IF g_pmca_m.pmcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN apmt820_cl USING g_enterprise,g_pmca_m.pmcadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt820_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt820_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt820_master_referesh USING g_pmca_m.pmcadocno INTO g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt, 
       g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca003,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaowndp, 
       g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtdp,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamoddt, 
       g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfdt,g_pmca_m.pmca002_desc,g_pmca_m.pmca003_desc,g_pmca_m.pmcaownid_desc, 
       g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcamodid_desc, 
       g_pmca_m.pmcacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT apmt820_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmca_m_mask_o.* =  g_pmca_m.*
   CALL apmt820_pmca_t_mask()
   LET g_pmca_m_mask_n.* =  g_pmca_m.*
   
   CALL apmt820_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmt820_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_pmcadocno_t = g_pmca_m.pmcadocno
 
 
      DELETE FROM pmca_t
       WHERE pmcaent = g_enterprise AND pmcadocno = g_pmca_m.pmcadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_pmca_m.pmcadocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM pmcb_t
       WHERE pmcbent = g_enterprise AND pmcbdocno = g_pmca_m.pmcadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmcb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmca_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apmt820_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_pmcb_d.clear() 
 
     
      CALL apmt820_ui_browser_refresh()  
      #CALL apmt820_ui_headershow()  
      #CALL apmt820_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apmt820_browser_fill("")
         CALL apmt820_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmt820_cl
 
   #功能已完成,通報訊息中心
   CALL apmt820_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apmt820.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmt820_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_pmcb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF apmt820_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmcbseq,pmcb001,pmcb002,pmcb003,pmcb004,pmcb005,pmcb006,pmcb007, 
             pmcb008,pmcb009,pmcbacti,pmcb010,pmcb011 ,t1.pmaal003 ,t2.oocql004 ,t3.rtaxl003 ,t4.imaal003 , 
             t5.imaal004 ,t6.ooefl003 ,t7.oocql004 FROM pmcb_t",   
                     " INNER JOIN pmca_t ON pmcaent = " ||g_enterprise|| " AND pmcadocno = pmcbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=pmcb001 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2036' AND t2.oocql002=pmcb002 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=pmcb005 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=pmcb006 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=pmcb006 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=pmcb009 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2036' AND t7.oocql002=pmcb010 AND t7.oocql003='"||g_dlang||"' ",
 
                     " WHERE pmcbent=? AND pmcbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmcb_t.pmcbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt820_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apmt820_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pmca_m.pmcadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pmca_m.pmcadocno INTO g_pmcb_d[l_ac].pmcbseq,g_pmcb_d[l_ac].pmcb001, 
          g_pmcb_d[l_ac].pmcb002,g_pmcb_d[l_ac].pmcb003,g_pmcb_d[l_ac].pmcb004,g_pmcb_d[l_ac].pmcb005, 
          g_pmcb_d[l_ac].pmcb006,g_pmcb_d[l_ac].pmcb007,g_pmcb_d[l_ac].pmcb008,g_pmcb_d[l_ac].pmcb009, 
          g_pmcb_d[l_ac].pmcbacti,g_pmcb_d[l_ac].pmcb010,g_pmcb_d[l_ac].pmcb011,g_pmcb_d[l_ac].pmcb001_desc, 
          g_pmcb_d[l_ac].pmcb002_desc,g_pmcb_d[l_ac].pmcb005_desc,g_pmcb_d[l_ac].pmcb006_desc,g_pmcb_d[l_ac].pmcb006_desc_desc, 
          g_pmcb_d[l_ac].pmcb009_desc,g_pmcb_d[l_ac].pmcb010_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
      #LET g_cnt = l_ac 
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
   
   CALL g_pmcb_d.deleteElement(g_pmcb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apmt820_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmcb_d.getLength()
      LET g_pmcb_d_mask_o[l_ac].* =  g_pmcb_d[l_ac].*
      CALL apmt820_pmcb_t_mask()
      LET g_pmcb_d_mask_n[l_ac].* =  g_pmcb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apmt820.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apmt820_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM pmcb_t
       WHERE pmcbent = g_enterprise AND
         pmcbdocno = ps_keys_bak[1] AND pmcbseq = ps_keys_bak[2]
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
         CALL g_pmcb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apmt820_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO pmcb_t
                  (pmcbent,
                   pmcbdocno,
                   pmcbseq
                   ,pmcb001,pmcb002,pmcb003,pmcb004,pmcb005,pmcb006,pmcb007,pmcb008,pmcb009,pmcbacti,pmcb010,pmcb011) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_pmcb_d[g_detail_idx].pmcb001,g_pmcb_d[g_detail_idx].pmcb002,g_pmcb_d[g_detail_idx].pmcb003, 
                       g_pmcb_d[g_detail_idx].pmcb004,g_pmcb_d[g_detail_idx].pmcb005,g_pmcb_d[g_detail_idx].pmcb006, 
                       g_pmcb_d[g_detail_idx].pmcb007,g_pmcb_d[g_detail_idx].pmcb008,g_pmcb_d[g_detail_idx].pmcb009, 
                       g_pmcb_d[g_detail_idx].pmcbacti,g_pmcb_d[g_detail_idx].pmcb010,g_pmcb_d[g_detail_idx].pmcb011) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmcb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_pmcb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apmt820_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmcb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL apmt820_pmcb_t_mask_restore('restore_mask_o')
               
      UPDATE pmcb_t 
         SET (pmcbdocno,
              pmcbseq
              ,pmcb001,pmcb002,pmcb003,pmcb004,pmcb005,pmcb006,pmcb007,pmcb008,pmcb009,pmcbacti,pmcb010,pmcb011) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_pmcb_d[g_detail_idx].pmcb001,g_pmcb_d[g_detail_idx].pmcb002,g_pmcb_d[g_detail_idx].pmcb003, 
                  g_pmcb_d[g_detail_idx].pmcb004,g_pmcb_d[g_detail_idx].pmcb005,g_pmcb_d[g_detail_idx].pmcb006, 
                  g_pmcb_d[g_detail_idx].pmcb007,g_pmcb_d[g_detail_idx].pmcb008,g_pmcb_d[g_detail_idx].pmcb009, 
                  g_pmcb_d[g_detail_idx].pmcbacti,g_pmcb_d[g_detail_idx].pmcb010,g_pmcb_d[g_detail_idx].pmcb011)  
 
         WHERE pmcbent = g_enterprise AND pmcbdocno = ps_keys_bak[1] AND pmcbseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmcb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmcb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmt820_pmcb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="apmt820.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apmt820_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt820.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apmt820_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt820.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apmt820_lock_b(ps_table,ps_page)
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
   #CALL apmt820_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pmcb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmt820_bcl USING g_enterprise,
                                       g_pmca_m.pmcadocno,g_pmcb_d[g_detail_idx].pmcbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt820_bcl:",SQLERRMESSAGE 
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
 
{<section id="apmt820.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apmt820_unlock_b(ps_table,ps_page)
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
      CLOSE apmt820_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apmt820.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmt820_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("pmcadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmcadocno",TRUE)
      CALL cl_set_comp_entry("pmcadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("pmca001",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt820.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmt820_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmcadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("pmcadocdt",FALSE)
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("pmcadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("pmcadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT apmt820_detail_count() THEN
      CALL cl_set_comp_entry("pmca001",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt820.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apmt820_set_entry_b(p_cmd)
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
   
   CALL cl_set_comp_entry("pmcb001,pmcb002,pmcb003,pmcbacti",TRUE)

   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="apmt820.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apmt820_set_no_entry_b(p_cmd)
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
   #151207-00021#5 151215 by sakura mark(S)
   #IF p_cmd = 'u'  THEN
   #   CALL cl_set_comp_entry("pmcb001,pmcb002",FALSE)
   #END IF
   #151207-00021#5 151215 by sakura mark(E)
   IF g_pmca_m.pmca001 = 'U' THEN
      #CALL cl_set_comp_entry("pmcb002,pmcb003",FALSE)   #151207-00021#5 151215 by sakura mark
   ELSE
      CALL cl_set_comp_entry("pmcbacti",FALSE)
   END IF
   CALL cl_set_comp_entry("pmcadocno",FALSE)
   CALL cl_set_comp_entry("pmcadocdt",FALSE)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="apmt820.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmt820_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("batch_insert", TRUE) #150504-00037#1 Add By Ken 150504
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmt820_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_pmca_m.pmcastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
      CALL cl_set_act_visible("batch_insert", FALSE) #150504-00037#1 Add By Ken 150504
   END IF
   #151207-00021#5 151215 by sakura add(S)
   IF g_pmca_m.pmca001 = 'U' THEN
      CALL cl_set_act_visible("batch_insert", FALSE)
   END IF
   #151207-00021#5 151215 by sakura add(E)   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apmt820_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apmt820_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmt820_default_search()
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
      LET ls_wc = ls_wc, " pmcadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "pmca_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pmcb_t" 
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
 
{<section id="apmt820.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apmt820_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_errno      LIKE type_t.chr10
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_pmca_m.pmcastus = 'X' OR g_pmca_m.pmcastus = 'Y' THEN
      RETURN 
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pmca_m.pmcadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apmt820_cl USING g_enterprise,g_pmca_m.pmcadocno
   IF STATUS THEN
      CLOSE apmt820_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt820_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apmt820_master_referesh USING g_pmca_m.pmcadocno INTO g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt, 
       g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca003,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaowndp, 
       g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtdp,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamoddt, 
       g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfdt,g_pmca_m.pmca002_desc,g_pmca_m.pmca003_desc,g_pmca_m.pmcaownid_desc, 
       g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcamodid_desc, 
       g_pmca_m.pmcacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT apmt820_action_chk() THEN
      CLOSE apmt820_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt,g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca002_desc, 
       g_pmca_m.pmca003,g_pmca_m.pmca003_desc,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaownid_desc, 
       g_pmca_m.pmcaowndp,g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp, 
       g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamodid_desc,g_pmca_m.pmcamoddt, 
       g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfid_desc,g_pmca_m.pmcacnfdt
 
   CASE g_pmca_m.pmcastus
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
         CASE g_pmca_m.pmcastus
            
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
      #160505-00020#1 Add By Ken 160506 加上簽核bpm(s)
      #open皆改為unconfirmed
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)

      CASE g_pmca_m.pmcastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"
            CALL cl_set_act_visible("confirmed ",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)

        #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

      END CASE
      #160505-00020#1 Add By Ken 160506 加上簽核bpm(e)
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT apmt820_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt820_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT apmt820_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt820_cl
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
      g_pmca_m.pmcastus = lc_state OR cl_null(lc_state) THEN
      CLOSE apmt820_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE lc_state
      WHEN 'Y'
         CALl s_apmt820_conf_chk(g_pmca_m.pmcadocno,g_pmca_m.pmcastus,g_pmca_m.pmca001) RETURNING l_success,l_errno
         IF l_success THEN
            IF cl_ask_confirm('apm-00173') THEN
               CALL s_transaction_begin()
               CALL s_apmt820_carry_upd(g_pmca_m.pmcadocno,g_pmca_m.pmca001) RETURNING l_success,l_errno 
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmca_m.pmcadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_apmt820_conf_upd(g_pmca_m.pmcadocno) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmca_m.pmcadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','1')
                  END IF 
               END IF
            ELSE
               CALL s_transaction_end('N','0')     #160812-00017#8 Add By Ken 160816
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmca_m.pmcadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

            RETURN 
         END IF
      WHEN 'X'
         CALL s_apmt820_void_chk(g_pmca_m.pmcadocno,g_pmca_m.pmcastus) RETURNING l_success,l_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_apmt820_void_upd(g_pmca_m.pmcadocno) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmca_m.pmcadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')     #160812-00017#8 Add By Ken 160816
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_pmca_m.pmcadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')     #160812-00017#8 Add By Ken 160816
            RETURN 
         END IF
   END CASE
   #end add-point
   
   LET g_pmca_m.pmcamodid = g_user
   LET g_pmca_m.pmcamoddt = cl_get_current()
   LET g_pmca_m.pmcastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pmca_t 
      SET (pmcastus,pmcamodid,pmcamoddt) 
        = (g_pmca_m.pmcastus,g_pmca_m.pmcamodid,g_pmca_m.pmcamoddt)     
    WHERE pmcaent = g_enterprise AND pmcadocno = g_pmca_m.pmcadocno
 
    
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
      EXECUTE apmt820_master_referesh USING g_pmca_m.pmcadocno INTO g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt, 
          g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca003,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaowndp, 
          g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtdp,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamoddt, 
          g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfdt,g_pmca_m.pmca002_desc,g_pmca_m.pmca003_desc,g_pmca_m.pmcaownid_desc, 
          g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcamodid_desc, 
          g_pmca_m.pmcacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pmca_m.pmcadocno,g_pmca_m.pmcadocdt,g_pmca_m.pmca001,g_pmca_m.pmca002,g_pmca_m.pmca002_desc, 
          g_pmca_m.pmca003,g_pmca_m.pmca003_desc,g_pmca_m.pmcastus,g_pmca_m.pmcaownid,g_pmca_m.pmcaownid_desc, 
          g_pmca_m.pmcaowndp,g_pmca_m.pmcaowndp_desc,g_pmca_m.pmcacrtid,g_pmca_m.pmcacrtid_desc,g_pmca_m.pmcacrtdp, 
          g_pmca_m.pmcacrtdp_desc,g_pmca_m.pmcacrtdt,g_pmca_m.pmcamodid,g_pmca_m.pmcamodid_desc,g_pmca_m.pmcamoddt, 
          g_pmca_m.pmcacnfid,g_pmca_m.pmcacnfid_desc,g_pmca_m.pmcacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE apmt820_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt820_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt820.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apmt820_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_pmcb_d.getLength() THEN
         LET g_detail_idx = g_pmcb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmcb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmcb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmt820_b_fill2(pi_idx)
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
   
   CALL apmt820_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apmt820_fill_chk(ps_idx)
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
 
{<section id="apmt820.status_show" >}
PRIVATE FUNCTION apmt820_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt820.mask_functions" >}
&include "erp/apm/apmt820_mask.4gl"
 
{</section>}
 
{<section id="apmt820.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION apmt820_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   #170203-00024#4-S   
   DEFINE l_success LIKE type_t.num5  
   DEFINE l_errno   LIKE type_t.chr10
   #170203-00024#4-E
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL apmt820_show()
   CALL apmt820_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #170203-00024#4-S
   #確認前檢核段
   CALL s_apmt820_conf_chk(g_pmca_m.pmcadocno,g_pmca_m.pmcastus,g_pmca_m.pmca001) RETURNING l_success,l_errno
   IF NOT l_success THEN   
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = g_pmca_m.pmcadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE apmt820_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #170203-00024#4-E
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_pmca_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_pmcb_d))
 
 
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
   #CALL apmt820_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL apmt820_ui_headershow()
   CALL apmt820_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION apmt820_draw_out()
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
   CALL apmt820_ui_headershow()  
   CALL apmt820_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="apmt820.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmt820_set_pk_array()
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
   LET g_pk_array[1].values = g_pmca_m.pmcadocno
   LET g_pk_array[1].column = 'pmcadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt820.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apmt820.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmt820_msgcentre_notify(lc_state)
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
   CALL apmt820_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmca_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt820.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmt820_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#28 add-S
   SELECT pmcastus  INTO g_pmca_m.pmcastus
     FROM pmca_t
    WHERE pmcaent = g_enterprise
      AND pmcadocno = g_pmca_m.pmcadocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_pmca_m.pmcastus
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
        LET g_errparam.extend = g_pmca_m.pmcadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL apmt820_set_act_visible()
        CALL apmt820_set_act_no_visible()
        CALL apmt820_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#28 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt820.other_function" readonly="Y" >}
#+ 批量新增完單身後填充
PRIVATE FUNCTION apmt820_ins_fill()
   CALL g_pmcb_d.clear()    #g_pmcb_d 單頭及單身 
   
   LET g_sql = "SELECT  UNIQUE pmcbseq,pmcb009,pmcb001,'',pmcb002,'',pmcb003,pmcb004,pmcb005,pmcb006,'','',pmcb007,pmcb008,pmcbacti FROM pmcb_t",    
               "",
               " WHERE pmcbent=? AND pmcbdocno=?"
 
   IF NOT cl_null(g_wc_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_table1 CLIPPED
   END IF
 
   LET g_sql = g_sql, " ORDER BY pmcb_t.pmcbseq"
 
   #add-point:單身填充控制

   #end add-point
   
   PREPARE apmt820_pb1 FROM g_sql
   DECLARE ins_fill_cs CURSOR FOR apmt820_pb1
 
   LET g_cnt1 = 1
 
   OPEN ins_fill_cs USING g_enterprise,g_pmca_m.pmcadocno

                                            
   FOREACH ins_fill_cs INTO g_pmcb_d[g_cnt1].pmcbseq,g_pmcb_d[g_cnt1].pmcb009,g_pmcb_d[g_cnt1].pmcb001,g_pmcb_d[g_cnt1].pmcb001_desc,g_pmcb_d[g_cnt1].pmcb002,g_pmcb_d[g_cnt1].pmcb002_desc,g_pmcb_d[g_cnt1].pmcb003,g_pmcb_d[g_cnt1].pmcb004,g_pmcb_d[g_cnt1].pmcb005,g_pmcb_d[g_cnt1].pmcb006,g_pmcb_d[g_cnt1].pmcb006_desc,g_pmcb_d[g_cnt1].pmcb005_desc,g_pmcb_d[g_cnt1].pmcb007,g_pmcb_d[g_cnt1].pmcb008,g_pmcb_d[g_cnt1].pmcbacti
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
       
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pmcb_d[g_cnt1].pmcb001
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_pmcb_d[g_cnt1].pmcb001_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_pmcb_d[g_cnt1].pmcb001_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pmcb_d[g_cnt1].pmcb002
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2036' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_pmcb_d[g_cnt1].pmcb002_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_pmcb_d[g_cnt1].pmcb002_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pmcb_d[g_cnt1].pmcb006
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_pmcb_d[g_cnt1].pmcb006_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_pmcb_d[g_cnt1].pmcb006_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_pmcb_d[g_cnt1].pmcb006
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_pmcb_d[g_cnt1].pmcb005_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_pmcb_d[g_cnt1].pmcb006_desc_desc       
 
      LET g_cnt1 = g_cnt1 + 1
      IF g_cnt1 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   
   LET l_ac = g_cnt1 
   
   CALL g_pmcb_d.deleteElement(g_pmcb_d.getLength())
   
   FREE apmt820_pb1
END FUNCTION

#+
PRIVATE FUNCTION apmt820_key_chk()
DEFINE l_n     LIKE type_t.num5
   IF NOT cl_null(g_pmcb_d[l_ac].pmcb001) AND NOT cl_null(g_pmcb_d[l_ac].pmcb002) AND NOT cl_null(g_pmcb_d[l_ac].pmcb003) THEN
      LET l_n = 0 
      IF g_pmca_m.pmca001 = 'I' THEN
         SELECT COUNT(*) INTO l_n FROM pmcb_t WHERE pmcbent = g_enterprise
            AND pmcb001 = g_pmcb_d[l_ac].pmcb001
            AND pmcb002 = g_pmcb_d[l_ac].pmcb002
            AND pmcb003 = g_pmcb_d[l_ac].pmcb003
            AND pmcbdocno = g_pmca_m.pmcadocno
         IF l_n > 0 THEN   
            RETURN FALSE
         END IF
      ELSE
         SELECT COUNT(*) INTO l_n FROM pmcb_t,pmca_t WHERE pmcbent = g_enterprise
            AND pmcadocno = pmcbdocno
            AND pmcaent = pmcbent
            AND pmcastus = 'N'
            AND pmcb001 = g_pmcb_d[l_ac].pmcb001
            AND pmcb002 = g_pmcb_d[l_ac].pmcb002
            AND pmcb003 = g_pmcb_d[l_ac].pmcb003
         IF l_n > 0 THEN
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
#+
PRIVATE FUNCTION apmt820_only_show()
#DEFINE p_ac   LIKE type_t.num5   
#   LET g_pmca_m.pmcb009_1 = g_pmcb_d[p_ac].pmcb009
#   LET g_pmca_m.pmaa001_1 = g_pmcb_d[p_ac].pmcb001
#   SELECT pmaal003 INTO g_pmca_m.pmaal003_1 FROM pmaal_t
#    WHERE pmaalent = g_enterprise
#      AND pmaal001 = g_pmca_m.pmaa001_1
#      AND pmaal002 = g_dlang
#   SELECT pmaastus,pmaa083 INTO g_pmca_m.pmaastus_1,g_pmca_m.pmaa083_1 FROM pmaa_t
#    WHERE pmaaent = g_enterprise
#      AND pmaa001 = g_pmca_m.pmaa001_1
#   LET g_pmca_m.pmcb002_1 = g_pmcb_d[p_ac].pmcb002  
#   LET g_pmca_m.pmcb003_1 = g_pmcb_d[p_ac].pmcb003  
#   LET g_pmca_m.pmcb004_1 = g_pmcb_d[p_ac].pmcb004  
#   LET g_pmca_m.pmcb005_1 = g_pmcb_d[p_ac].pmcb005  
#   LET g_pmca_m.pmcb006_1 = g_pmcb_d[p_ac].pmcb006  
#   LET g_pmca_m.imaal003_1 = g_pmcb_d[p_ac].pmcb006_desc  
#   LET g_pmca_m.imaal004_1 = g_pmcb_d[p_ac].pmcb005_desc  
#   LET g_pmca_m.pmcb007_1 = g_pmcb_d[p_ac].pmcb007  
#   LET g_pmca_m.pmcb008_1 = g_pmcb_d[p_ac].pmcb008  
#   LET g_pmca_m.pmcastus_1 = g_pmca_m.pmcastus 
#   DISPLAY BY NAME g_pmca_m.pmcb009_1,g_pmca_m.pmcb002_1,g_pmca_m.pmcb007_1,g_pmca_m.pmaa001_1,g_pmca_m.pmcb003_1,
#                   g_pmca_m.pmcb008_1,g_pmca_m.pmaal003_1,g_pmca_m.pmcb004_1,g_pmca_m.pmcastus_1,g_pmca_m.pmaastus_1,
#                   g_pmca_m.pmcb005_1,g_pmca_m.pmaa083_1,g_pmca_m.pmcb006_1,g_pmca_m.imaal003_1,g_pmca_m.imaal004_1   
END FUNCTION
#+
PRIVATE FUNCTION apmt820_upd_show()
   SELECT pmcb001,pmcb002,pmcb003,pmcb004,pmcb005,pmcb006,pmcb007,pmcb008,pmcb009
     INTO g_pmcb_d[l_ac].pmcb001,g_pmcb_d[l_ac].pmcb002,g_pmcb_d[l_ac].pmcb003,g_pmcb_d[l_ac].pmcb004,
          g_pmcb_d[l_ac].pmcb005,g_pmcb_d[l_ac].pmcb006,g_pmcb_d[l_ac].pmcb007,g_pmcb_d[l_ac].pmcb008,g_pmcb_d[l_ac].pmcb009
     FROM pmcb_t
    WHERE pmcbdocno = g_pmca_m.pmcadocno
      AND pmcbseq   = g_pmcb_d[l_ac].pmcbseq
      AND pmcbent   = g_enterprise
   DISPLAY BY NAME g_pmcb_d[l_ac].pmcb001,g_pmcb_d[l_ac].pmcb002,g_pmcb_d[l_ac].pmcb003,g_pmcb_d[l_ac].pmcb004,
                   g_pmcb_d[l_ac].pmcb005,g_pmcb_d[l_ac].pmcb006,g_pmcb_d[l_ac].pmcb007,g_pmcb_d[l_ac].pmcb008,g_pmcb_d[l_ac].pmcb009   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcb_d[l_ac].pmcb001_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_pmcb_d[l_ac].pmcb001_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2036' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcb_d[l_ac].pmcb002_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_pmcb_d[l_ac].pmcb002_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb006
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcb_d[l_ac].pmcb006_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_pmcb_d[l_ac].pmcb006_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb006
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcb_d[l_ac].pmcb006_desc_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_pmcb_d[l_ac].pmcb006_desc_desc
   
END FUNCTION
#+檢查批量新增的pmag資料是否正確
PRIVATE FUNCTION apmt820_pmag_chk(p_pmcb001,p_pmcb002,p_pmcb003)
#161104-00002#11 161110 By rainy mod---(S) 
#調整*寫法   
 #DEFINE l_pmcb RECORD LIKE pmcb_t.*
  DEFINE l_pmcb RECORD  #供應商證照異動單明細檔
       pmcbent LIKE pmcb_t.pmcbent, #企業編號
       pmcbdocno LIKE pmcb_t.pmcbdocno, #單據編號
       pmcbseq LIKE pmcb_t.pmcbseq, #項次
       pmcb001 LIKE pmcb_t.pmcb001, #供應商編號
       pmcb002 LIKE pmcb_t.pmcb002, #證照類別
       pmcb003 LIKE pmcb_t.pmcb003, #證照號碼
       pmcb004 LIKE pmcb_t.pmcb004, #證照名稱
       pmcb005 LIKE pmcb_t.pmcb005, #經營品類
       pmcb006 LIKE pmcb_t.pmcb006, #商品編號
       pmcb007 LIKE pmcb_t.pmcb007, #生效日期
       pmcb008 LIKE pmcb_t.pmcb008, #失效日期
       pmcb009 LIKE pmcb_t.pmcb009, #證照提供組織
       pmcbacti LIKE pmcb_t.pmcbacti, #證照有效
       pmcbud001 LIKE pmcb_t.pmcbud001, #自定義欄位(文字)001
       pmcbud002 LIKE pmcb_t.pmcbud002, #自定義欄位(文字)002
       pmcbud003 LIKE pmcb_t.pmcbud003, #自定義欄位(文字)003
       pmcbud004 LIKE pmcb_t.pmcbud004, #自定義欄位(文字)004
       pmcbud005 LIKE pmcb_t.pmcbud005, #自定義欄位(文字)005
       pmcbud006 LIKE pmcb_t.pmcbud006, #自定義欄位(文字)006
       pmcbud007 LIKE pmcb_t.pmcbud007, #自定義欄位(文字)007
       pmcbud008 LIKE pmcb_t.pmcbud008, #自定義欄位(文字)008
       pmcbud009 LIKE pmcb_t.pmcbud009, #自定義欄位(文字)009
       pmcbud010 LIKE pmcb_t.pmcbud010, #自定義欄位(文字)010
       pmcbud011 LIKE pmcb_t.pmcbud011, #自定義欄位(數字)011
       pmcbud012 LIKE pmcb_t.pmcbud012, #自定義欄位(數字)012
       pmcbud013 LIKE pmcb_t.pmcbud013, #自定義欄位(數字)013
       pmcbud014 LIKE pmcb_t.pmcbud014, #自定義欄位(數字)014
       pmcbud015 LIKE pmcb_t.pmcbud015, #自定義欄位(數字)015
       pmcbud016 LIKE pmcb_t.pmcbud016, #自定義欄位(數字)016
       pmcbud017 LIKE pmcb_t.pmcbud017, #自定義欄位(數字)017
       pmcbud018 LIKE pmcb_t.pmcbud018, #自定義欄位(數字)018
       pmcbud019 LIKE pmcb_t.pmcbud019, #自定義欄位(數字)019
       pmcbud020 LIKE pmcb_t.pmcbud020, #自定義欄位(數字)020
       pmcbud021 LIKE pmcb_t.pmcbud021, #自定義欄位(日期時間)021
       pmcbud022 LIKE pmcb_t.pmcbud022, #自定義欄位(日期時間)022
       pmcbud023 LIKE pmcb_t.pmcbud023, #自定義欄位(日期時間)023
       pmcbud024 LIKE pmcb_t.pmcbud024, #自定義欄位(日期時間)024
       pmcbud025 LIKE pmcb_t.pmcbud025, #自定義欄位(日期時間)025
       pmcbud026 LIKE pmcb_t.pmcbud026, #自定義欄位(日期時間)026
       pmcbud027 LIKE pmcb_t.pmcbud027, #自定義欄位(日期時間)027
       pmcbud028 LIKE pmcb_t.pmcbud028, #自定義欄位(日期時間)028
       pmcbud029 LIKE pmcb_t.pmcbud029, #自定義欄位(日期時間)029
       pmcbud030 LIKE pmcb_t.pmcbud030, #自定義欄位(日期時間)030
       pmcb010 LIKE pmcb_t.pmcb010, #原證照類別
       pmcb011 LIKE pmcb_t.pmcb011  #原證照號碼
 END RECORD
#161104-00002#11 161110 By rainy mod---(E) 
DEFINE l_n       LIKE type_t.num5
DEFINE p_pmcb001 LIKE pmcb_t.pmcb001
DEFINE p_pmcb002 LIKE pmcb_t.pmcb002
DEFINE p_pmcb003 LIKE pmcb_t.pmcb003
   SELECT pmag001,pmag002,pmag003,pmag004,pmag005,pmag006,pmag007,pmag008,pmag009 INTO
          l_pmcb.pmcb001,l_pmcb.pmcb002,l_pmcb.pmcb003,l_pmcb.pmcb004,l_pmcb.pmcb005,l_pmcb.pmcb006,
          l_pmcb.pmcb007,l_pmcb.pmcb008,l_pmcb.pmcb009 
     FROM pmag_t
    WHERE pmagent = g_enterprise AND pmag001 = p_pmcb001 AND pmag002 = p_pmcb002 AND pmag003 = p_pmcb003     
   IF NOT cl_null(l_pmcb.pmcb001) AND NOT cl_null(l_pmcb.pmcb002) AND NOT cl_null(l_pmcb.pmcb003) THEN
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM pmcb_t,pmca_t WHERE pmcbent = g_enterprise
         AND pmcbdocno = pmcadocno
         AND pmcbent   = pmcaent
         AND pmcastus  = 'N' 
         AND pmcb001 = l_pmcb.pmcb001
         AND pmcb002 = l_pmcb.pmcb002
         AND pmcb003 = l_pmcb.pmcb003
         
      IF l_n > 0 THEN   
         RETURN FALSE
      END IF
   END IF

   IF NOT cl_null(l_pmcb.pmcb002) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM oocq_t 
       WHERE oocq001 = '2036'
         AND oocq002 = l_pmcb.pmcb002
         AND oocqent = g_enterprise
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
      
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM oocq_t 
       WHERE oocq001 = '2036'
         AND oocq002 = l_pmcb.pmcb002
         AND oocqent = g_enterprise
         AND oocqstus= 'Y'
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
   END IF

   IF NOT cl_null(l_pmcb.pmcb005) THEN
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM rtax_t
       WHERE rtax001 = l_pmcb.pmcb005
         AND rtaxent = g_enterprise
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM rtax_t
       WHERE rtax001 = l_pmcb.pmcb005
         AND rtaxent = g_enterprise
         AND rtaxstus= 'Y'
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
      IF NOT cl_null(l_pmcb.pmcb006) THEN
         LET l_n = 0 
         SELECT COUNT(*) INTO l_n FROM imaa_t
          WHERE imaa001 =  l_pmcb.pmcb006 
            AND imaa009 =  l_pmcb.pmcb005
            AND imaaent = g_enterprise                     
         IF l_n = 0 THEN
            RETURN FALSE  
         END IF 
      END IF
   END IF     

   IF NOT cl_null(l_pmcb.pmcb006) THEN
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM imaa_t
       WHERE imaa001 = l_pmcb.pmcb006
         AND imaaent = g_enterprise
      IF l_n = 0 THEN
         RETURN FALSE 
      END IF
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM imaa_t
       WHERE imaa001 = l_pmcb.pmcb006
         AND imaaent = g_enterprise
         AND imaastus= 'Y'
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
      
      IF NOT cl_null(l_pmcb.pmcb005) THEN
         LET l_n = 0 
         SELECT COUNT(*) INTO l_n FROM imaa_t
          WHERE imaa001 =  l_pmcb.pmcb006 
            AND imaa009 =  l_pmcb.pmcb005
            AND imaaent = g_enterprise                     
         IF l_n = 0 THEN
            RETURN FALSE
         END IF   
      END IF
    END IF

   IF NOT cl_null(l_pmcb.pmcb007) AND NOT cl_null(l_pmcb.pmcb008) THEN
      IF l_pmcb.pmcb007 > l_pmcb.pmcb008 THEN
         RETURN FALSE
      END IF
   END IF

   IF NOT cl_null(l_pmcb.pmcb009) THEN
      LET l_n = 0 
      #150518-00050#1 Modify By Ken 150520 原本抓ooea_t  改為ooef_t
      SELECT COUNT(*) INTO l_n FROM ooef_t 
       WHERE ooef001 = l_pmcb.pmcb009
         AND ooefent = g_enterprise
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM ooef_t 
       WHERE ooef001 = l_pmcb.pmcb009
         AND ooefent = g_enterprise
         AND ooefstus= 'Y'
      
      IF l_n = 0 THEN
         RETURN FALSE
      END IF
      #150518-00050#1 Modify By Ken 150520
   END IF
RETURN TRUE 
END FUNCTION
#+
PRIVATE FUNCTION apmt820_pmag_insert(p_pmcb001,p_pmcb002,p_pmcb003)
DEFINE l_pmcb     type_g_pmcb_d
DEFINE p_num      LIKE type_t.num5
DEFINE p_num_ac   LIKE type_t.num5
DEFINE p_i        LIKE type_t.num5
DEFINE p_pmcb001  LIKE pmcb_t.pmcb001
DEFINE p_pmcb002  LIKE pmcb_t.pmcb002
DEFINE p_pmcb003  LIKE pmcb_t.pmcb003
DEFINE l_pmagstus LIKE pmag_t.pmagstus
   INITIALIZE l_pmcb.* TO NULL
   LET l_pmcb.pmcb001 = p_pmcb001
   LET l_pmcb.pmcb002 = p_pmcb002
   LET l_pmcb.pmcb003 = p_pmcb003
   IF NOT cl_null(l_pmcb.pmcb001) AND NOT cl_null(l_pmcb.pmcb002) AND NOT cl_null(l_pmcb.pmcb003) THEN
      SELECT pmag001,pmag002,pmag003,pmag004,pmag005,pmag006,pmag007,pmag008,pmag009,
             pmaal004,pmaastus,pmaa083,oocql004,imaal003,imaal004,ooefl003
        INTO l_pmcb.pmcb001,l_pmcb.pmcb002,l_pmcb.pmcb003,l_pmcb.pmcb004,l_pmcb.pmcb005,l_pmcb.pmcb006,
             l_pmcb.pmcb007,l_pmcb.pmcb008,l_pmcb.pmcb009,l_pmcb.pmcb001_desc,l_pmcb.pmaastus,
             l_pmcb.pmaa083,l_pmcb.pmcb002_desc,l_pmcb.pmcb006_desc,l_pmcb.pmcb006_desc_desc,l_pmcb.pmcb009_desc
        FROM pmag_t LEFT OUTER JOIN pmaal_t ON pmaalent = pmagent AND pmaal001 = pmag001 AND pmaal002 = g_dlang
                    LEFT OUTER JOIN pmaa_t  ON pmaaent = pmagent AND pmaa001 = pmag001 
                    LEFT OUTER JOIN oocql_t ON oocqlent = pmagent AND oocql001 = '2036' AND oocql002 = pmag002 AND oocql003 = g_dlang
                    LEFT OUTER JOIN imaal_t ON imaalent = pmagent AND imaal001 = pmag006 AND imaal002 = g_dlang
                    LEFT OUTER JOIN ooefl_t ON ooeflent = pmagent AND ooefl001 = pmag009 AND ooefl002 = g_dlang
       WHERE pmagent = g_enterprise AND pmag001 = l_pmcb.pmcb001 
         AND pmag002 = l_pmcb.pmcb002 AND pmag003 = l_pmcb.pmcb003
       SELECT MAX(pmcbseq)+1 INTO l_pmcb.pmcbseq FROM pmcb_t WHERE pmcbent = g_enterprise AND pmcbdocno = g_pmca_m.pmcadocno
       IF cl_null(l_pmcb.pmcbseq) THEN LET l_pmcb.pmcbseq = 1 END IF
   #  IF p_i = 2 THEN
   #     LET l_pmcb.pmcbseq = l_pmcb.pmcbseq + 1
   #  END IF
      SELECT pmagstus INTO l_pmagstus FROM pmag_t WHERE pmagent = g_enterprise 
         AND pmag001 = l_pmcb.pmcb001 AND pmag002 = l_pmcb.pmcb002 AND pmag003 = l_pmcb.pmcb003
      IF l_pmagstus = 'Y' OR l_pmagstus = 'N' THEN LET l_pmcb.pmcbacti = 'Y' END IF
      IF l_pmagstus = 'X' THEN LET l_pmcb.pmcbacti = 'N' END IF
      #151207-00021#5 151215 by sakura add(S)
      LET l_pmcb.pmcb010 = l_pmcb.pmcb002
      LET l_pmcb.pmcb011 = l_pmcb.pmcb003
      #151207-00021#5 151215 by sakura add(E)      
#      IF p_i != 1 THEN
#         LET g_pmcb_d[p_num].* = l_pmcb.*
#         DISPLAY BY NAME g_pmcb_d[p_num].*
#      ELSE
#         LET g_pmcb_d[p_num_ac].* = l_pmcb.*
#         DISPLAY BY NAME g_pmcb_d[p_num_ac].*
#      END IF
#      IF p_i != 1 THEN
         INSERT INTO pmcb_t(pmcbent,pmcbdocno,pmcbseq,pmcb001,pmcb002,pmcb003,pmcb004,pmcb005,pmcb006,pmcb007,pmcb008,pmcb009,pmcbacti,pmcb010,pmcb011)   #151207-00021#5 151215 by sakura add pmcb010,pmcb011 
                     VALUES(g_enterprise,g_pmca_m.pmcadocno,l_pmcb.pmcbseq,l_pmcb.pmcb001,l_pmcb.pmcb002,l_pmcb.pmcb003,l_pmcb.pmcb004,
                            l_pmcb.pmcb005,l_pmcb.pmcb006,l_pmcb.pmcb007,l_pmcb.pmcb008,l_pmcb.pmcb009,l_pmcb.pmcbacti,l_pmcb.pmcb010,l_pmcb.pmcb011)      #151207-00021#5 151215 by sakura add pmcb010,pmcb011
#      END IF
   END IF
END FUNCTION
#+
PRIVATE FUNCTION apmt820_controlp_chk(p_str_array)
DEFINE  p_str_array    DYNAMIC ARRAY OF STRING
DEFINE  l_i            LIKE type_t.num5
DEFINE  l_cnt          LIKE type_t.num5
DEFINE  tok            base.StringTokenizer
DEFINE  l_str1         LIKE type_t.chr100
DEFINE  l_str2         LIKE type_t.chr100
DEFINE  l_str3         LIKE type_t.chr100
DEFINE  l_num          LIKE type_t.num5
DEFINE  l_i1           LIKE type_t.num5
DEFINE  l_num_ac       LIKE type_t.num5
#   LET l_num = g_pmcb_d.getLength() + 1
#   LET l_num_ac = l_ac
   LET l_i1 = 1
   FOR l_i = 1 TO p_str_array.getLength()
      
      LET tok = base.StringTokenizer.create(g_qryparam.str_array[l_i],"|")
      LET l_cnt = 0
      WHILE tok.hasMoreTokens()
         LET l_cnt = l_cnt + 1
         CASE l_cnt
            WHEN "1"
               LET l_str1 = tok.nextToken()
            WHEN "2"
               LET l_str2 = tok.nextToken()
            WHEN "3"
               LET l_str3 = tok.nextToken()
            OTHERWISE
               EXIT WHILE
         END CASE
      END WHILE
      IF NOT apmt820_pmag_chk(l_str1,l_str2,l_str3) THEN
         CONTINUE FOR
      END IF

    # CALL apmt820_pmag_insert(l_str1,l_str2,l_str3,l_num,l_num_ac,l_i1)
      CALL apmt820_pmag_insert(l_str1,l_str2,l_str3)
#      IF l_i1 != 1 THEN
#         LET l_num = l_num + 1
#      END IF
      LET l_i1 = l_i1 + 1
   END FOR
   RETURN l_i1
END FUNCTION

PRIVATE FUNCTION apmt820_pmag001_pmag002_pmag003_chk()
DEFINE l_n     LIKE type_t.num5 
   
   IF NOT cl_null(g_pmcb_d[l_ac].pmcb001) AND NOT cl_null(g_pmcb_d[l_ac].pmcb002) AND NOT cl_null(g_pmcb_d[l_ac].pmcb003) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM pmag_t 
       WHERE pmag001 = g_pmcb_d[l_ac].pmcb001
         AND pmag002 = g_pmcb_d[l_ac].pmcb002
         AND pmag003 = g_pmcb_d[l_ac].pmcb003
         AND pmagent = g_enterprise
      IF l_n > 0 THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apmt820_detail_count()
DEFINE l_n    LIKE type_t.num5
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM pmcb_t WHERE pmcbent = g_enterprise AND pmcbdocno = g_pmca_m.pmcadocno
   IF l_n != 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apmt820_pmcb005_pmcb006_chk()
DEFINE r_bottom   STRING
DEFINE l_n    LIKE type_t.num5
DEFINE l_sql  STRING
   IF NOT cl_null(g_pmcb_d[l_ac].pmcb005) AND NOT cl_null(g_pmcb_d[l_ac].pmcb006) THEN
      
      CALL apmt820_get_bottom() RETURNING r_bottom
      LET l_n = 0 
      LET l_sql = "SELECT COUNT(*) FROM imaa_t  WHERE imaa001 =  '",g_pmcb_d[l_ac].pmcb006,"'", 
                  "   AND imaa009 IN (",r_bottom,")",
                  "   AND imaaent = ",g_enterprise   
      PREPARE rtax001_pre FROM l_sql  
      EXECUTE rtax001_pre INTO l_n      
      IF l_n = 0 THEN
         RETURN FALSE
      END IF   
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apmt820_get_bottom()
DEFINE l_rtax001        DYNAMIC ARRAY OF LIKE rtax_t.rtax001
DEFINE l_i    LIKE type_t.num5
DEFINE l_str  STRING
      CALL　s_arti202_search_bottom(g_pmcb_d[l_ac].pmcb005)　RETURNING l_rtax001
      
      LET l_str = ''
      FOR l_i=1 TO l_rtax001.getLength()
         IF l_i = 1 THEN
            LET l_str = "'",l_rtax001[l_i],"'" 
         ELSE
            LET l_str = l_str,",'",l_rtax001[l_i],"'" 
         END IF
         
      END FOR
      RETURN l_str
END FUNCTION

PRIVATE FUNCTION apmt820_pmag001_exists()
  IF NOT ap_chk_isExist(g_pmcb_d[l_ac].pmcb001,"SELECT COUNT(*) FROM pmag_t WHERE pmagent="||g_enterprise||" AND pmag001=?",'apm-00225',1) THEN
     RETURN FALSE
  END IF
  RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apmt820_pmcb001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcb_d[l_ac].pmcb001_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_pmcb_d[l_ac].pmcb001_desc
   
   SELECT pmaastus,pmaa083 INTO g_pmcb_d[l_ac].pmaastus,g_pmcb_d[l_ac].pmaa083 FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_pmcb_d[l_ac].pmcb001
   DISPLAY BY NAME g_pmcb_d[l_ac].pmaastus,g_pmcb_d[l_ac].pmaa083
   #CALL apmt820_pmaa083_desc()
END FUNCTION

PRIVATE FUNCTION apmt820_pmcb002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2036' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcb_d[l_ac].pmcb002_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_pmcb_d[l_ac].pmcb002_desc
END FUNCTION

PRIVATE FUNCTION apmt820_pmaa083_desc()
       #INITIALIZE g_ref_fields TO NULL
       #LET g_ref_fields[1] = g_pmcb_d[l_ac].pmaa083
       #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='255' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       #LET g_pmcb_d[l_ac].pmaa083_desc = '', g_rtn_fields[1] , ''
       #DISPLAY BY NAME g_pmcb_d[l_ac].pmaa083_desc
END FUNCTION

PRIVATE FUNCTION apmt820_pmcb005_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmcb_d[l_ac].pmcb005
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=?  AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmcb_d[l_ac].pmcb005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmcb_d[l_ac].pmcb005_desc
END FUNCTION

 
{</section>}
 
